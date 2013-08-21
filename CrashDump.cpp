
KBUGCHECK_CALLBACK_RECORD*  g_pBugCheckCallbackRecord;

CrashdmpContext*   Context;
CrashdmpContext    ContextCopy;

NTSTATUS
FillDumpInitContext(
    CrashdmpContext* pContext )
{
    pContext->StackContext.Init.StallRoutine   = KeStallExecutionProcessor;
    pContext->StackContext.Init.Reserved       = 0; // timeout??
    pContext->StackContext.Init.Length         = sizeof( DUMP_INITIALIZATION_CONTEXT );
    pContext->StackContext.Init.TargetAddress  = &pContext->scsiAddress;
    pContext->StackContext.Init.PartitionStyle = DiskGeometryGetPartition( pContext->DiskGeomtry )->PartitionStyle;

    if ( PARTITION_STYLE_MBR == pContext->StackContext.Init.PartitionStyle ) { // 0x0
        pContext->StackContext.Init.DiskInfo.Mbr.Signature = DiskGeometryGetPartition( pContext->DiskGeomtry )->Mbr.Signature;
        pContext->StackContext.Init.DiskInfo.Mbr.CheckSum  = DiskGeometryGetPartition( pContext->DiskGeomtry )->Mbr.CheckSum;
    }
    else { // PARTITION_STYLE_GPT (0x1)
        memcpy(
            pContext->StackContext.Init.DiskInfo.Gpt,
            DiskGeometryGetPartition( pContext->DiskGeomtry )->Gpt );
    }

    // For DUMP_POINTERS_EX
    if ( pContext->0xD8 ) {
        pContext->StackContext.Init.PortConfiguration = pContext->DumpPointersEx.DumpData;

        if ( 0x2000 < pContext->DumpPointersEx.CommonBufferSize ) {
            pContext->StackContext.Init.CommonBufferSize = pContext->DumpPointersEx.CommonBufferSize;
        }
        else {
            pContext->StackContext.Init.CommonBufferSize = 0x2000;
        }

        pContext->StackContext.Init.AllocateCommonBuffers = pContext->DumpPointersEx.AllocateCommonBuffers;
    }
    else { // For DUMP_POINTERS
        pContext->StackContext.Init.AdapterObject      = pContext->DumpPointers.AdapterObject;
        pContext->StackContext.Init.MappedRegisterBase = pContext->DumpPointers.MappedRegisterBase;
        pContext->StackContext.Init.PortConfiguration  = pContext->DumpPointers.DumpData;

        if ( 0x2000 < pContext->DumpPointers.CommonBufferSize ) {
            pContext->StackContext.Init.CommonBufferSize = pContext->DumpPointers.CommonBufferSize;
        }
        else {
            pContext->StackContext.Init.CommonBufferSize = 0x2000;
        }

        if ( 0x10000 < pContext->StackContext.Init.CommonBufferSize ) {
            pContext->StackContext.Init.CommonBufferSize = 0x10000;
        }

        pContext->StackContext.Init.AllocateCommonBuffers = pContext->DumpPointers.AllocateCommonBuffers;
    }

    // interesting ...
    // We set this field to various value and set it back to 0x10000 in the end.
    pContext->StackContext.Init.CommonBufferSize = 0x10000;

    if ( pContext->StackContext.Init.AllocateCommonBuffers ) {
        return STATUS_SUCCESS;
    }

    PHYSICAL_ADDRESS    highestAddress = { 0xFFFFFFFFUL };

    for ( size_t i = 0; i < 2; ++i ) {
        pContext->StackContext.Init.AllocateCommonBuffers[ i ] =
            MmAllocateContiguousMemory(
                pContext->StackContext.Init.CommonBufferSize,
                highestAddress );

        if ( NULL == pMem ) {
            return STATUS_INSUFFICIENT_RESOURCES; // 0xC000009A
        }

        pContext->StackContext.Init.PhysicalAddress[ i ] = MmGetPhysicalAddress( pMem );
    }

    return STATUS_SUCCESS;
}

NTSTATUS
IsVolumeSupported(
    DEVICE_OBJECT*  pDevObj,
    FILE_OBJECT*    pFileObj )
{

}

NTSTATUS
QueryPortDriver( CrashdmpContext* pContext )
{
    PARTITION_INFORMATION_EX    partitionInfoEx = { 0 };
    ULONG   retLen;     // be optimized

    NTSTATUS status =
        IsVolumeSuppoted(
            pContext->AttachedDevice,
            pContext->hibVolumeFileObj );

    if ( NT_SUCCESS( status ) ) {
        return status;
    }

    pContext->dumpPointers.Header.Version = DUMP_POINTERS_VERSION_2;
    pContext->dumpOointers.Header.Size    = sizeof( DUMP_POINTERS_EX ); // 0x20

    // http://www.ioctls.net/
    status =
        SendDeviceControl(
            IOCTL_SCSI_GET_DUMP_POINTERS,       // 0x41020
            pContext->AttachedDevice,
            &pContext->dumpPointersEx.Header,   // input
            sizeof( DUMP_POINTERS_VERSION ),    // input length, 0x8
            &pContext->dumpPointers,            // output
            sizeof( DUMP_POINTERS_VERSION ) + sizeof( DUMP_POINTERS ), // output length, 0x28
            &retLen );

    if ( !NT_SUCCESS( status ) ) {
        return status;
    }

    if ( DUMP_POINTERS_VERSION_2    == pContext->dumpPointers.Header.Version && 
         sizeof( DUMP_POINTERS_EX ) == pContext->dumpPointers.Header.Size ) {
        pContext->0xD8 = 1;
        pContext->PointersLength = sizeof( DUMP_POINTERS_EX );  // 0x20
    }
    else {
        pContext->0xD8 = 0;
        pContext->PointersLength = sizeof( DUMP_POINTERS );     // 0x28
    }

    status =
        SendDeviceControl(
            IOCTL_SCSI_GET_ADDRESS, // 0x41018
            pContext->AttachedDevice,
            NULL,
            0,
            &pContext->scsiAddress,
            sizeof( SCSI_ADDRESS ), // 0x8
            &retLen );

    if ( !NT_SUCCESS( status ) ) {
        return status;
    }

    status =
        SendDeviceControl(
            IOCTL_DISK_GET_PARTITION_INFO_EX, // 0x70048
            pContext->AttachedDevice,
            NULL,
            0,
            &partitionInfoEx,
            sizeof( PARTITION_INFORMATION_EX ), // 0x90
            &retLen );

    if ( !NT_SUCCESS( status ) ) {
        return status;
    }

    pContext->StartingOffset = partitionInfoEx->StartingOffset;

    status =
        SendDeviceControl(
            IOCTL_DISK_GET_DRIVE_GEOMETRY_EX, // 0x700A0
            pContext->AttachedDevice,
            NULL,
            0,
            &pContext->DiskGeometry,
            sizeof( PARTITION_INFORMATION_EX ), // 0x38
            &retLen );

    if ( !NT_SUCCESS( status ) ) {
        return status;
    }

    FillDumpInitContext( pContext );

    return status;
}

/*!
 * External interface
 * called by NT
    kd> k
    ChildEBP RetAddr  
    8b46ba54 87d9fe82 hiber_HibEnc!DriverEntry+0x74 
    8b46ba84 87d9d265 crashdmp!FilterCallback+0x1a2
    8b46ba94 87da5798 crashdmp!InitializeFilterDrivers+0xf
    8b46bae4 811332b2 crashdmp!CrashdmpLoadDumpStack+0x278
    8b46bb00 8113341c nt!IoGetDumpStack+0x23
    8b46bb28 810870cc nt!PopAllocateHiberContext+0xed
    8b46bbec 80fd62fc nt!NtSetSystemPowerState+0x3d5
    8b46bbec 80f60f69 nt!KiFastCallEntry+0x12c
    8b46bc70 811731b7 nt!ZwSetSystemPowerState+0x11
    8b46bcc4 811d1ae2 nt!PopIssueActionRequest+0x1c0
    8b46bd00 80edd04f nt!PopPolicyWorkerAction+0x54
    8b46bd1c 80eec854 nt!PopPolicyWorkerThread+0x9b
    8b46bd74 80f2f415 nt!ExpWorkerThread+0x111
    8b46bdb0 80fdb039 nt!PspSystemThreadStartup+0x4a
    00000000 00000000 nt!KiThreadStartup+0x19
 */
NTSTATUS
CrashdmpLoadDumpStack(
    FILE_OBJECT*        pHibVolumeObj,
    void*               arg4,       // 
    FILTER_DUMP_TYPE    dumpType,
    void*               argC,       // investigate SendUsageNotifiation()
    HANDLE              hHibVolume )
{
    OBJECT_ATTRIBUTES   objAttributes;
    IO_STATUS_BLOCK     ioStatus;
    //DWORD               simluateError; uses IoStatus.Infomration
    FILE_OBJECT         pVolumeObj    = 0;
    DWORD               simulateError = 0;
    BOOLEAN             isLocalCreatedHibVolumeObj = false;

    NTSTATUS status = CheckContextIntegrity();

    if ( !NT_SUCCESS( status ) ) {
        return status;
    }

    if ( DumpTypeHibernation == dumpType ) {    // 2: DumpTypeHibernation
        0x1665C = 1;

        if ( 0 == 0x16254 ) {
            HibernationInitialize();
        }

        if ( 0 == g_simulateError ) { // Context->0x400
            if ( NT_SUCCESS(
                    ReadRegULongKey(
                        L"\\Registry\\Machine\\System\\CurrentControlSet\\Control\\CrashControl",
                        L"SimulateError",
                        &g_simulateError ) ) ) {
            }
        }
    }

    Context = AllocPool( 0x140 );

    if ( Context ) {
        if ( 0x2001 == g_simulateError ) {
            ExFreePoolWithTag( Context, 0 );
            Context = 0;
        }
    }

    if ( 0 == Context ) {
        status        = STATUS_INSUFFICIENT_RESOURCES; // 0xC000009A
        simulateError = 0x2001;
        goto Error;
    }

    InitializeListHead( &Context->filterDriverList );
    InitializeListHead( &Context->0x84 );
    Context->userAppliedFileObject = UserAppliedHibVolumeFileobj;

    if ( NULL == hHibVolume ) {
        // Context->PartitionName is in ArcNam format
        // "\ArcName\multi(0)disk(0)rdisk(0)partition(2)"
        InitializeObjectAttributes(
            &objAttributes,
            Context->PartitionName,
            OBJ_KERNEL_HANDLE, // 0x200
            NULL,
            NULL );

        status = 
            ZwOpenFile(
                &hHibVolume,
                SYNCHRONIZE | FILE_READ_ATTRIBUTES | FILE_READ_ATTRIBUTES,// DesiredAccess, 0x100180
                &objAttributes,
                &ioStatus,
                FILE_SHARE_READ | FILE_SHARE_WRITE, // 3
                FILE_NON_DIRECTORY_FILE );          // OpenOptions, 0x40

        if ( NT_SUCCESS( status ) ) {
            if ( 0x2002 == g_simluateError ) {
                ZwClose( hHibVolume );
                hHibVolume    = 0;
                status        = STATUS_UNSUCCESSFUL;
                simulateError = 0x2002;
                goto Error;
            }
        }

        if ( NT_SUCCESS( status ) ) {
            isLocalCreatedHibVolumeObj = true;
        }
    }

    ObReferenceObjectByHandle(
        hHibVolume,
        0,          // DesiredAccess
        *IoFileObjectType,
        UserMode,
        pHibVolumeObj,
        0 );        //POBJECT_HANDLE_INFORMATION

    Context->AttachedDevice = 
        IoGetAttachedDeviceReference(
            pHibVolumeObj->DeviceObject );  // esi+0x130
    Context->VolumeObject = pHibVolumeObj;  // esi+0xA4

    if ( isLocalCreatedHibVolumeObj ) {
        ZwClose( hHibVolume );
    }

    status = QueryPortDriver( Context );

    if ( NT_SUCCESS( status ) ) {
        if ( 0x2003 == g_simulateError ) {
            status        = STATUS_UNSUCCESSFUL;
            simulateError = 0x2003;
        }
    }

    if ( !NT_SUCCESS( status ) ) {
        goto Error;
    }

    status = LoadPortDriver( Context, 0x1625C );

    if ( NT_SUCCESS( status ) ) {
        if ( 0x2004 == g_simulateError ) {
            status        = STATUS_UNSUCCESSFUL;
            simulateError = 0x2004;
        }
    }

    if ( !NT_SUCCESS( status ) ) {
        goto Error;
    }

    status = LoadFilterDriver( Context, 0x1625C );

    if ( NT_SUCCESS( status ) ) {
        if ( 0x2005 == g_simulateError ) {
            status        = STATUS_UNSUCCESSFUL;
            simulateError = 0x2005;
        }
    }

    if ( !NT_SUCCESS( status ) ) {
        goto Error;
    }

    status = InitializeFilterDrivers( Context );

    if ( NT_SUCCESS( status ) ) {
        if ( 0x2006 == g_simulateError ) {
            status        = STATUS_UNSUCCESSFUL;
            simulateError = 0x2006;
        }
    }

    if ( !NT_SUCCESS( status ) ) {
        goto Error;
    }

    status =
        SendUsageNotification(
            Context,
            1,
            argC);

    if ( NT_SUCCESS( status ) ) {
        if ( 0x2007 == g_simulateError ) {
            status        = STATUS_UNSUCCESSFUL;
            simulateError = 0x2007;
        }
    }

    if ( !NT_SUCCESS( status ) ) {
        goto Error;
    }

    if ( DumpTypeHibernation == dumpType ) {  // 2: DumpTypeHibernation
        0x16658 = Context;
    }

Error:
    if ( !NT_SUCCESS( status ) ) {
        if ( 0 != simulateError ) {
            CrashdmpWriteErrorLog(
                0,
                status,
                IO_DUMP_DRIVER_LOAD_FAILURE, // 0xC004002D
                simulateError );
        }

        if ( g_pBugCheckCallbackRecord ) {
            KeDeregisterBugCheckReasonCallback( g_pBugCheckCallbackRecord );

            if ( g_pBugCheckCallbackRecord ) {
                ExFreePoolWithTag( g_pBugCheckCallbackRecord, 0 );
                g_pBugCheckCallbackRecord = 0;
            }
        }

        FreePortResource( Context, 0x1625C );

        if ( pVolumeObj ) {
            ObDereferenceObject( pVolumeObj );
        }

        // not finished ...
    }

    memcpy( ContextCopy, Context );

    return status;
}

NTSTATUS
InitializeFilterDrivers( CrashdmpContext pContext )
{
    return FilterCallback( 0, pContext );
}

__cdecl
NTSTATUS
FilterCallback(
    ULONG           actionType,
    CrashdmpContext Context,
    LARGE_INTETER*  pDiskByteOffset,
    MDL*            pMdl )
{
    
}


NTSTATUS
CrashdmpWriteRoutine(
    arg0,
    arg4 )
{
    if ( 1 == byte_1665C ) {
        esi = dword_16658;
    }
    else {
        esi = dword_16270;
    }

    FilterCallback(
        2,
        esi,
        arg0,
        arg4 );

    // dump_diskdump!DiskDumpWrite
    NTSTATUS status =
        esi->0xE0( arg0, arg4 );

    if ( NT_SUCCESS( status ) ) {
        if ( 0x5001 != dword_16650 ) {
            return status;
        }
        else {
            status = STATUS_UNSUCCESSFUL;
        }
    }

    dword_16640 = esi->0xE0; // dump_diskdump!DiskDumpWrite
    dword_16644 = status;
    dword_1663C = 0x5001;

    return status;
}
