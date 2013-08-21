NTSTATUS
ReadRegULongKey(
    const wchar_t*  pKeyPath,
    const wchar_t*  pValueName,
    ULONG*          pData,)
{
    RTL_QUERY_REGISTRY_TABLE    queryTable  = { 0 };
    ULONG                       defaultData = 0;

    queryTable.QueryRoutine  = NULL;
    queryTable.Flags         = RTL_QUERY_REGISTRY_REQUIRED | RTL_QUERY_REGISTRY_DIRECT; // 0x24
    queryTable.Name          = pValueName;
    queryTable.EntryContext  = pData;
    queryTable.DefaultType   = REG_DWORD;       // 0x4
    queryTable.DefaultData   = &defaultData;
    queryTable.DefaultLength = sizeof( ULONG ); // 0x4

    return
        RtlQueryRegistryValues(
            RTL_REGISTRY_OPTIONAL,
            pKeyPath,
            &queryTable,
            NULL,
            NULL );
}
