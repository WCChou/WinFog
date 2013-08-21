NTSTATUS
SendDeviceControl(
    ULONG           code,
    DEVICE_OBJECT*  pDevObj,
    void*           pInput,
    ULONG           inputLen,
    void*           pOutput,
    ULONG           outputLen,
    ULONG*          pRetLen )
{
    KEVENT          event;
    IO_STATUS_BLOCK ioStatus;
    IRP*            pIrp;

    KeInitializeEvent(
        &event,
        NotificationEvent, // 0
        FALSE );

    pIrp =
        IoBuildDeviceIoControlRequest(
            code,
            pDevObj,
            pInput,
            inputLen,
            pOutput,
            outputLen,
            0,          // internal ioctl code
            &event,
            &ioStatus );

    if ( 0 == pIrp ) {
        return STATUS_INSUFFICIENT_RESOURCES; // 0xC000009A
    }

    status =
        IofCallDriver(
            pDevObj,
            pIrp );

    if ( STATUS_PENDING == status ) { // 0x00000103
        KeWaitForSingleObject(
            &event,
            Executive,  // wait reasion, 0
            UserMode,   // 0
            FALSE,      // alertable
            0 );        // timeout
    }

    *pRetLen = ioStatus.Information;
    return ioStatus.Status;
}
