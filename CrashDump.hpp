typedef struct _MINIPORT_DUMP_POINTERS {
    USHORT Version;                                 // 0x0
    USHORT Size;                                    // 0x2
    WCHAR DriverName[DUMP_MINIPORT_NAME_LENGTH];    // 0x4
    struct _ADAPTER_OBJECT *AdapterObject;          // 0x22
    PVOID MappedRegisterBase;                       // 0x24
    ULONG CommonBufferSize;
    PVOID MiniportPrivateDumpData;
    ULONG SystemIoBusNumber;
    INTERFACE_TYPE AdapterInterfaceType;
    ULONG MaximumTransferLength;
    ULONG NumberOfPhysicalBreaks;
    ULONG AlignmentMask;
    ULONG NumberOfAccessRanges;
    ACCESS_RANGE (*AccessRanges)[];
    UCHAR NumberOfBuses;
    BOOLEAN  Master;
    BOOLEAN MapBuffers;
    UCHAR MaximumNumberOfTargets;
} MINIPORT_DUMP_POINTERS, *PMINIPORT_DUMP_POINTERS;

typedef struct _SCSI_ADDRESS {
    ULONG Length;
    UCHAR PortNumber;
    UCHAR PathId;
    UCHAR TargetId;
    UCHAR Lun;
} SCSI_ADDRESS, *PSCSI_ADDRESS;

typedef struct _DUMP_POINTERS_VERSION {
    //
    // Dump pointers structure version
    //
    ULONG Version;

    //
    // Dump pointers structure size
    //
    ULONG Size;

} DUMP_POINTERS_VERSION, *PDUMP_POINTERS_VERSION;

/*!
 * size: 0x24
 */
typedef struct _DUMP_POINTERS {
    struct _ADAPTER_OBJECT* AdapterObject;          // 0x0
    PVOID                   MappedRegisterBase;     // 0x4
    PVOID                   DumpData;               // 0x8
    PVOID                   CommonBufferVa;         // 0xC
    LARGE_INTEGER           CommonBufferPa;         // 0x10
    ULONG                   CommonBufferSize;       // 0x18
    BOOLEAN                 AllocateCommonBuffers;  // 0x1C
    BOOLEAN                 UseDiskDump;            // 0x1D
    UCHAR                   Spare1[2];              // 0x1E
    PVOID                   DeviceObject;           // 0x20
} DUMP_POINTERS, *PDUMP_POINTERS;

/*!
 * size: 0x20
 */
typedef struct _DUMP_POINTERS_EX {
    DUMP_POINTERS_VERSION   Header;                 // 0x0
    PVOID                   DumpData;               // 0x8
    PVOID                   CommonBufferVa;         // 0xC
    ULONG                   CommonBufferSize;       // 0x10
    BOOLEAN                 AllocateCommonBuffers;  // 0x14
    PVOID                   DeviceObject;           // 0x18
    PVOID                   DriverList;             // 0x1C
} DUMP_POINTERS_EX, *PDUMP_POINTERS_EX;

void
(*SleepFuncT)(
    IN ULONG  MicroSeconds );

/*!
 * size 0x140, allocate by AllocPool() in CrashdmpLoadDumpStack()
    kd> dt _Dump_STACK_CONTEXT
    nt!_DUMP_STACK_CONTEXT
       +0x000 Init             : _DUMP_INITIALIZATION_CONTEXT
       +0x070 PartitionOffset  : _LARGE_INTEGER
       +0x078 DumpPointers     : Ptr32 Void
       +0x07c PointersLength   : Uint4B
       +0x080 ModulePrefix     : Ptr32 Uint2B
       +0x084 DriverList       : _LIST_ENTRY
       +0x08c InitMsg          : _STRING
       +0x094 ProgMsg          : _STRING
       +0x09c DoneMsg          : _STRING
       +0x0a4 FileObject       : Ptr32 Void
       +0x0a8 UsageType        : _DEVICE_USAGE_NOTIFICATION_TYPE
    kd> dt _DUMP_INITIALIZATION_CONTEXT
    nt!_DUMP_INITIALIZATION_CONTEXT
       +0x000 Length           : Uint4B
       +0x004 Reserved         : Uint4B
       +0x008 MemoryBlock      : Ptr32 Void
       +0x00c CommonBuffer     : [2] Ptr32 Void
       +0x018 PhysicalAddress  : [2] _LARGE_INTEGER
       +0x028 StallRoutine     : Ptr32     void 
       +0x02c OpenRoutine      : Ptr32     unsigned char 
       +0x030 WriteRoutine     : Ptr32     long 
       +0x034 FinishRoutine    : Ptr32     void 
       +0x038 AdapterObject    : Ptr32 _ADAPTER_OBJECT
       +0x03c MappedRegisterBase : Ptr32 Void
       +0x040 PortConfiguration : Ptr32 Void
       +0x044 CrashDump        : UChar
       +0x048 MaximumTransferSize : Uint4B
       +0x04c CommonBufferSize : Uint4B
       +0x050 TargetAddress    : Ptr32 Void
       +0x054 WritePendingRoutine : Ptr32     long 
       +0x058 PartitionStyle   : Uint4B
       +0x05c DiskInfo         : <unnamed-tag>
 */
struct CrashdmpContext {
    _DUMP_STACK_CONTEXT
        DUMP_INITIALIZATION_CONTEXT {
            ULONG                           Length;               // 0x0, FillDumpInitContext()
            ULONG                           Reserved;             // 0x4, FillDumpInitContext(), timeout ??
            void*                           MemoryBlock;          // 0x8,
            void*                           CommonBuffer[ 2 ];    // 0xC ~ 0x14, for UNICODE_STRING*     PartitionName;
            LARGE_INTEGER                   PhysicalAddress[ 2 ]; // 0x18, FillDumpInitContext()
            SleepFuncT                      StallRoutine;         // 0x28, FillDumpInitContext()
            OptnFuncT                       OpenRoutine;          // 0x2C, BOOLEAN (*OpenFuncT)();
            WriteFuncT                      WriteRoutine;         // 0x30, long (*WriteFuncT)();
            FinishFuncT                     FinishRoutine;        // 0x34, void (*FinishFuncT)();
            _ADAPTER_OBJECT*                AdapterObject;        // 0x38, FillDumpInitContext()
            void*                           MappedRegisterBase;   // 0x3C, FillDumpInitContext()
            PORT_CONFIGURATION_INFORMATION* PortConfiguration;    // 0x40, FillDumpInitContext()
            BOOLEAN                         CrashDump;            // 0x44, FillDumpInitContext()
            ULONG                           MaximumTransferSize;  // 0x48
            ULONG                           CommonBufferSize;     // 0x4C
            SCSI_ADDRESS*                   TargetAddress;        // 0x50, FillDumpInitContext()
            WritePendingFuncT               WritePendingRoutine;  // 0x54, long* (*WritePendingFuncT)()
            PARTITION_STYLE                 PartitionStyle;       // 0x58, FillDumpInitContext()
            struct {                                              // 0x5C ~ 0x70, size = 0x14
                union {
                    struct {
                        ULONG   Signature;                        // 0x5C, FillDumpInitContext()
                        ULONG   CheckSum;                         // 0x60, FillDumpInitContext()
                    } Mbr;
                    struct {
                        GUID    DiskId;                           // 0x5C ~ 0x6C, size = 0x10
                    } Gpt;
                };
            } DiskInfo;
        } Init;

        LARGE_INTEGER                   PartitionOffset;// 0x70 ~ 0x78
        void*                           DumpPointers;   // 0x78
        ULONG                           PointersLength; // 0x7C QueryPortDriver()
        void*                           ModulePrefix;   // 0x80, is FILE_OBJECT* to UserAppliedHibVolumeFileobj ??
        LIST_ENTRY                      DriverList;     // 0x84 ~ 0x8C, port driver list, CrashdmpLoadDumpStack()
        UNICODE_STRING                  InitMsg;        // 0x8C ~ 0x94
        UNICODE_STRING                  ProgMsg;        // 0x94 ~ 0x9C
        UNICODE_STRING                  DoneMsg;        // 0x9C ~ 0xA4
        FILE_OBJECT*                    FileObject;     // 0xA4, points to file object that hibernation file resides
        DEVICE_USAGE_NOTIFICATION_TYPE  UsageType;      // 0xA8, different from _FILTER_DUMP_TYPE
    } StackContext;

    struct {                                            // 0xB0 ~ 0xD8, size = 0x28, QueryPortDriver(), FillDumpInitContext()
        union {                                         // 0xB0 ~ 0xD4, size = 0x24
            DUMP_POINTERS       DumpPointers;           // size = 0x24
            DUMP_POINTERS_EX    DumpPointersEx;         // size = 0x20
        };
        BOOLEAN                 0xD8;
    }
#if (0)
    V1 {                                                // 0xB0 ~ 0xD4, size = 0x24
        struct _ADAPTER_OBJECT* AdapterObject;          // 0xB0
        PVOID                   MappedRegisterBase;     // 0xB4
        PVOID                   DumpData;               // 0xB8
        PVOID                   CommonBufferVa;         // 0xBC
        LARGE_INTEGER           CommonBufferPa;         // 0xC0
        ULONG                   CommonBufferSize;       // 0xC8
        BOOLEAN                 AllocateCommonBuffers;  // 0xCC
        BOOLEAN                 UseDiskDump;            // 0xCD
        UCHAR                   Spare1[2];              // 0xCE
        PVOID                   DeviceObject;           // 0xD0
    };
    V2 {                                                // 0xB0 ~ 0xD0, size = 0x20
        ULONG                   Version;                // 0xB0
        ULONG                   Size;                   // 0xB4
        PVOID                   DumpData;               // 0xB8, PortConfigurationData??
        PVOID                   CommonBufferVa;         // 0xBC
        ULONG                   CommonBufferSize;       // 0xC0
        BOOLERAN                AllocateCommonBuffers;  // 0xC4
        PVOID                   DeviceObject;           // 0xC8
        PVOID                   DriverList;             // 0xCC
    };
    DUMP_POINTERS       DumpPointers;       // 0xB0 ~ 0xD8, QueryPortDriver(), size = 0x28
                                            // 0xB4, (), FillDumpInitContext()
                                            // 0xB8, FillDumpInitContext()
                                            // 0xC0, FillDumpInitContext()
                                            // 0xC4, FillDumpInitContext()
                                            // 0xC8, FillDumpInitContext()
                                            // 0xCC, FillDumpInitContext()
                                            // 0xD8, QueryPortDriver(), FillDumpInitContext()
#endif
    SCSI_ADDRESS        ScsiAddress         // 0xEC ~ 0xF4
    DISK_GEOMETRY_EX    DiskGeometry;       // 0xF8 ~ 0x130, size = 0x38, QueryPortDriver()
#if (0)
    DISK_GEOMETRY_EX {
        DiskGeometry {
            LARGE_INTEGER   Cylinders;          // 0xF8
            MEDIA_TYPE      MediaType;          // 0xFC
            ULONG           TracksPerCylinder;  // 0xD0
            ULONG           SectorsPerTrack;    // 0xD4
            ULONG           BytesPerSector;     // 0xD8
        };
        LARGE_INTEGER       DiskSize;           // 0xDC
        UCHAR               Data[ 1 ];          // 0xE0
        DISK_PARTITION_INFO {
            ULONG           SizeOfPartitionInfo;    // 0x118
            PARTITION_STYLE PartitionStyle;         // 0x11C, FillDumpInitContext()
            ULONG           Signature;              // 0x120, FillDumpInitContext()
            ULONG           CheckSum;               // 0x124, FillDumpInitContext()
                                                    // 0x128
                                                    // 0x12C
    };
#endif
    DEVICE_OBJECT*      AttachedDevice;     // 0x130, QueryPortDriver()
    LIST_ENTRY          FilterDriverList;   // 0x134 ~ 0x13C
                                            // 0x13C
};

