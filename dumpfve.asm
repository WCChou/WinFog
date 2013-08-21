kd> uf 90e965ce
dump_dumpfve!DriverEntry:

NTSTATUS
DriverEntry(
    FILTER_EXTENSION*           pFltExt,
    FILTER_INITIALIZATION_DATA* pFltInitData )
{
    pFltInitData->Flag |= DUMP_FILTER_CRITICAL;

    if ( 0x10000 > pFltInitData->MaxPagesPerWrite ) {
        return STATUS_INVALID_PARAMETER;
    }

    NTSTATUS    status;
    void*   pBuf =
        ExAllocatePoolWithTag(
            NonPagedPool,
            0x4000,
            'EVFd' );

    if ( NULL == pBuf ) {
        status = STATUS_INSUFFICIENT_RESOURCES;
        goto CLENAUP;
    }

    memset( pBuf, 0, 0x4000 );

    NTSTATUS    status =
        GetFveContext(
            pFltExt,
            pFltInitData->MaxPagesPerWrite,
            pBuf );

    if ( !NT_SUCCESS( status ) ) {
        goto CLEANUP;
    }

    pFltInitData->DumpStart    = DumpStart;
    pFltInitData->DumpWrite    = DumpWrite;
    pFltInitData->DumpFinish   = DumpFinish;
    pFltInitData->DumpUnload   = DumpUnload;
    pFltInitData->DumpData     = pBuf;
    pBuf = 0;

CLEANUP:
    if ( pBuf ) {
        ExFreePoolWithTag(
            pBuf,
            'EVFd' );
    }

    return status;
}

90e965ce 8bff            mov     edi,edi
90e965d0 55              push    ebp
90e965d1 8bec            mov     ebp,esp
90e965d3 56              push    esi
90e965d4 8b750c          mov     esi,dword ptr [ebp+0Ch]
90e965d7 834e2001        or      dword ptr [esi+20h],1
90e965db 817e1c00000100  cmp     dword ptr [esi+1Ch],10000h
90e965e2 57              push    edi
90e965e3 7607            jbe     dump_dumpfve!DriverEntry+0x1e (90e965ec)

dump_dumpfve!DriverEntry+0x17:
90e965e5 bf0d0000c0      mov     edi,0C000000Dh     // STATUS_INVALID_PARAMETER
90e965ea eb73            jmp     dump_dumpfve!DriverEntry+0x91 (90e9665f)

dump_dumpfve!DriverEntry+0x1e:
90e965ec 53              push    ebx
90e965ed 6864465645      push    45564664h          // Tag: dFVE
90e965f2 bf00400000      mov     edi,4000h
90e965f7 57              push    edi                // 0x4000
90e965f8 6a00            push    0                  // NonPagedPool
90e965fa ff1534c0e990    call    dword ptr [dump_dumpfve!_imp__ExAllocatePoolWithTag (90e9c034)]
90e96600 8bd8            mov     ebx,eax
90e96602 85db            test    ebx,ebx
90e96604 7507            jne     dump_dumpfve!DriverEntry+0x3f (90e9660d)

dump_dumpfve!DriverEntry+0x38:
90e96606 bf9a0000c0      mov     edi,0C000009Ah     // STATUS_INSUFFICIENT_RESOURCES
90e9660b eb41            jmp     dump_dumpfve!DriverEntry+0x80 (90e9664e)

dump_dumpfve!DriverEntry+0x3f:
90e9660d 57              push    edi
90e9660e 6a00            push    0
90e96610 53              push    ebx
90e96611 e87a000000      call    dump_dumpfve!memset (90e96690)
90e96616 83c40c          add     esp,0Ch
90e96619 53              push    ebx
90e9661a 893b            mov     dword ptr [ebx],edi
90e9661c ff761c          push    dword ptr [esi+1Ch]
90e9661f ff7508          push    dword ptr [ebp+8]
90e96622 e8adfbffff      call    dump_dumpfve!GetFveContext (90e961d4)
90e96627 8bf8            mov     edi,eax
90e96629 85ff            test    edi,edi
90e9662b 7c21            jl      dump_dumpfve!DriverEntry+0x80 (90e9664e)

dump_dumpfve!DriverEntry+0x5f:
90e9662d 895e18          mov     dword ptr [esi+18h],ebx
90e96630 c74608e064e990  mov     dword ptr [esi+8],offset dump_dumpfve!DumpStart (90e964e0)
90e96637 c7460c1e65e990  mov     dword ptr [esi+0Ch],offset dump_dumpfve!DumpWrite (90e9651e)
90e9663e c746101465e990  mov     dword ptr [esi+10h],offset dump_dumpfve!DumpFinish (90e96514)
90e96645 c746145e65e990  mov     dword ptr [esi+14h],offset dump_dumpfve!DumpUnload (90e9655e)
90e9664c 33db            xor     ebx,ebx

dump_dumpfve!DriverEntry+0x80:
90e9664e 85db            test    ebx,ebx
90e96650 740c            je      dump_dumpfve!DriverEntry+0x90 (90e9665e)

dump_dumpfve!DriverEntry+0x84:
90e96652 6864465645      push    45564664h
90e96657 53              push    ebx
90e96658 ff152cc0e990    call    dword ptr [dump_dumpfve!_imp__ExFreePoolWithTag (90e9c02c)]

dump_dumpfve!DriverEntry+0x90:
90e9665e 5b              pop     ebx

dump_dumpfve!DriverEntry+0x91:
90e9665f 8bc7            mov     eax,edi
90e96661 5f              pop     edi
90e96662 5e              pop     esi
90e96663 5d              pop     ebp
90e96664 c20800          ret     8


NTSTATUS
GetFveContext(
    FILTER_EXTENSION* pFltExt,
    ULONG             maxPagesPerWrite,
    void*             pBuf )
{
    if ( NULL == pFltExt ||
         NULL == pBuf ) {
        return STATUS_INVALID_PARAMETER;
    }
}

kd> uf dump_dumpfve!GetFveContext
dump_dumpfve!GetFveContext:
946b91d4 8bff            mov     edi,edi
946b91d6 55              push    ebp
946b91d7 8bec            mov     ebp,esp
946b91d9 51              push    ecx
946b91da 51              push    ecx
946b91db 837d0800        cmp     dword ptr [ebp+8],0
946b91df 53              push    ebx
946b91e0 56              push    esi
946b91e1 57              push    edi
946b91e2 0f84ea010000    je      dump_dumpfve!GetFveContext+0x1fe (946b93d2)

dump_dumpfve!GetFveContext+0x14:
946b91e8 8b5d10          mov     ebx,dword ptr [ebp+10h]
946b91eb 85db            test    ebx,ebx
946b91ed 0f84df010000    je      dump_dumpfve!GetFveContext+0x1fe (946b93d2)

dump_dumpfve!GetFveContext+0x1f:
946b91f3 8b7d0c          mov     edi,dword ptr [ebp+0Ch]
946b91f6 68a4316c94      push    offset dump_dumpfve!FveCallbacks (946c31a4)
946b91fb 8d7308          lea     esi,[ebx+8]
946b91fe c645ff00        mov     byte ptr [ebp-1],0
946b9202 c645fe00        mov     byte ptr [ebp-2],0
946b9206 c1e70c          shl     edi,0Ch
946b9209 e8a3060000      call    dump_dumpfve!FveLibInit (946b98b1)
946b920e 89450c          mov     dword ptr [ebp+0Ch],eax
946b9211 85c0            test    eax,eax
946b9213 0f8c13010000    jl      dump_dumpfve!GetFveContext+0x158 (946b932c)

dump_dumpfve!GetFveContext+0x45:
946b9219 8b4508          mov     eax,dword ptr [ebp+8]
946b921c 8b481c          mov     ecx,dword ptr [eax+1Ch]
946b921f 894b04          mov     dword ptr [ebx+4],ecx
946b9222 833802          cmp     dword ptr [eax],2
946b9225 751a            jne     dump_dumpfve!GetFveContext+0x6d (946b9241)

dump_dumpfve!GetFveContext+0x53:
946b9227 ff7004          push    dword ptr [eax+4]
946b922a e893feffff      call    dump_dumpfve!FvePrepareForHibernate (946b90c2)
946b922f 89450c          mov     dword ptr [ebp+0Ch],eax
946b9232 85c0            test    eax,eax
946b9234 0f8cf2000000    jl      dump_dumpfve!GetFveContext+0x158 (946b932c)

dump_dumpfve!GetFveContext+0x66:
946b923a 8b4508          mov     eax,dword ptr [ebp+8]
946b923d c645fe01        mov     byte ptr [ebp-2],1

dump_dumpfve!GetFveContext+0x6d:
946b9241 833801          cmp     dword ptr [eax],1
946b9244 8b1d24f06b94    mov     ebx,dword ptr [dump_dumpfve!_imp__MmAllocateContiguousMemory (946bf024)]
946b924a 7520            jne     dump_dumpfve!GetFveContext+0x98 (946b926c)

dump_dumpfve!GetFveContext+0x78:
946b924c 33c9            xor     ecx,ecx
946b924e 51              push    ecx
946b924f 83c8ff          or      eax,0FFFFFFFFh
946b9252 50              push    eax
946b9253 57              push    edi
946b9254 897e0c          mov     dword ptr [esi+0Ch],edi
946b9257 ffd3            call    ebx
946b9259 894610          mov     dword ptr [esi+10h],eax
946b925c 85c0            test    eax,eax
946b925e 750c            jne     dump_dumpfve!GetFveContext+0x98 (946b926c)

dump_dumpfve!GetFveContext+0x8c:
946b9260 c7450c9a0000c0  mov     dword ptr [ebp+0Ch],0C000009Ah
946b9267 e9bd000000      jmp     dump_dumpfve!GetFveContext+0x155 (946b9329)

dump_dumpfve!GetFveContext+0x98:
946b926c 8b4508          mov     eax,dword ptr [ebp+8]
946b926f 56              push    esi
946b9270 ff7004          push    dword ptr [eax+4]
946b9273 e88efeffff      call    dump_dumpfve!FveRegisterDynamicContext (946b9106)
946b9278 89450c          mov     dword ptr [ebp+0Ch],eax
946b927b 85c0            test    eax,eax
946b927d 0f8ca6000000    jl      dump_dumpfve!GetFveContext+0x155 (946b9329)

dump_dumpfve!GetFveContext+0xaf:
946b9283 8b4508          mov     eax,dword ptr [ebp+8]
946b9286 833801          cmp     dword ptr [eax],1
946b9289 c645ff01        mov     byte ptr [ebp-1],1
946b928d 740a            je      dump_dumpfve!GetFveContext+0xc5 (946b9299)

dump_dumpfve!GetFveContext+0xbb:
946b928f 837e0800        cmp     dword ptr [esi+8],0
946b9293 0f8486000000    je      dump_dumpfve!GetFveContext+0x14b (946b931f)

dump_dumpfve!GetFveContext+0xc5:
946b9299 397e0c          cmp     dword ptr [esi+0Ch],edi
946b929c 7376            jae     dump_dumpfve!GetFveContext+0x140 (946b9314)

dump_dumpfve!GetFveContext+0xca:
946b929e 837e1000        cmp     dword ptr [esi+10h],0
946b92a2 75bc            jne     dump_dumpfve!GetFveContext+0x8c (946b9260)

dump_dumpfve!GetFveContext+0xd0:
946b92a4 56              push    esi
946b92a5 ff7004          push    dword ptr [eax+4]
946b92a8 e881feffff      call    dump_dumpfve!FveUnregisterDynamicContext (946b912e)
946b92ad 89450c          mov     dword ptr [ebp+0Ch],eax
946b92b0 85c0            test    eax,eax
946b92b2 7c75            jl      dump_dumpfve!GetFveContext+0x155 (946b9329)

dump_dumpfve!GetFveContext+0xe0:
946b92b4 8b4610          mov     eax,dword ptr [esi+10h]
946b92b7 c645ff00        mov     byte ptr [ebp-1],0
946b92bb 85c0            test    eax,eax
946b92bd 741f            je      dump_dumpfve!GetFveContext+0x10a (946b92de)

dump_dumpfve!GetFveContext+0xeb:
946b92bf 8b4e0c          mov     ecx,dword ptr [esi+0Ch]
946b92c2 3bcf            cmp     ecx,edi
946b92c4 7318            jae     dump_dumpfve!GetFveContext+0x10a (946b92de)

dump_dumpfve!GetFveContext+0xf2:
946b92c6 85c9            test    ecx,ecx
946b92c8 7407            je      dump_dumpfve!GetFveContext+0xfd (946b92d1)

dump_dumpfve!GetFveContext+0xf6:
946b92ca c60000          mov     byte ptr [eax],0
946b92cd 40              inc     eax
946b92ce 49              dec     ecx
946b92cf 75f9            jne     dump_dumpfve!GetFveContext+0xf6 (946b92ca)

dump_dumpfve!GetFveContext+0xfd:
946b92d1 ff7610          push    dword ptr [esi+10h]
946b92d4 ff1520f06b94    call    dword ptr [dump_dumpfve!_imp__MmFreeContiguousMemory (946bf020)]
946b92da 83661000        and     dword ptr [esi+10h],0

dump_dumpfve!GetFveContext+0x10a:
946b92de 33c9            xor     ecx,ecx
946b92e0 394e10          cmp     dword ptr [esi+10h],ecx
946b92e3 750e            jne     dump_dumpfve!GetFveContext+0x11f (946b92f3)

dump_dumpfve!GetFveContext+0x111:
946b92e5 51              push    ecx
946b92e6 83c8ff          or      eax,0FFFFFFFFh
946b92e9 50              push    eax
946b92ea 57              push    edi
946b92eb 897e0c          mov     dword ptr [esi+0Ch],edi
946b92ee ffd3            call    ebx
946b92f0 894610          mov     dword ptr [esi+10h],eax

dump_dumpfve!GetFveContext+0x11f:
946b92f3 837e1000        cmp     dword ptr [esi+10h],0
946b92f7 0f8463ffffff    je      dump_dumpfve!GetFveContext+0x8c (946b9260)

dump_dumpfve!GetFveContext+0x129:
946b92fd 8b4508          mov     eax,dword ptr [ebp+8]
946b9300 56              push    esi
946b9301 ff7004          push    dword ptr [eax+4]
946b9304 e8fdfdffff      call    dump_dumpfve!FveRegisterDynamicContext (946b9106)
946b9309 89450c          mov     dword ptr [ebp+0Ch],eax
946b930c 85c0            test    eax,eax
946b930e 7c19            jl      dump_dumpfve!GetFveContext+0x155 (946b9329)

dump_dumpfve!GetFveContext+0x13c:
946b9310 c645ff01        mov     byte ptr [ebp-1],1

dump_dumpfve!GetFveContext+0x140:
946b9314 ff7510          push    dword ptr [ebp+10h]
946b9317 e83afeffff      call    dump_dumpfve!FveInitCrypto (946b9156)
946b931c 89450c          mov     dword ptr [ebp+0Ch],eax

dump_dumpfve!GetFveContext+0x14b:
946b931f 837d0c00        cmp     dword ptr [ebp+0Ch],0
946b9323 0f8db0000000    jge     dump_dumpfve!GetFveContext+0x205 (946b93d9)

dump_dumpfve!GetFveContext+0x155:
946b9329 8b5d10          mov     ebx,dword ptr [ebp+10h]

dump_dumpfve!GetFveContext+0x158:
946b932c 6a4d            push    4Dh
946b932e 59              pop     ecx
946b932f 8d8388000000    lea     eax,[ebx+88h]

dump_dumpfve!GetFveContext+0x161:
946b9335 c60000          mov     byte ptr [eax],0
946b9338 40              inc     eax
946b9339 49              dec     ecx
946b933a 75f9            jne     dump_dumpfve!GetFveContext+0x161 (946b9335)

dump_dumpfve!GetFveContext+0x168:
946b933c 8d45f8          lea     eax,[ebp-8]
946b933f 50              push    eax
946b9340 68ec000000      push    0ECh
946b9345 ff33            push    dword ptr [ebx]
946b9347 e8bafcffff      call    dump_dumpfve!ULongSub (946b9006)
946b934c 85c0            test    eax,eax
946b934e 7c14            jl      dump_dumpfve!GetFveContext+0x190 (946b9364)

dump_dumpfve!GetFveContext+0x17c:
946b9350 8b4df8          mov     ecx,dword ptr [ebp-8]
946b9353 8d83ec000000    lea     eax,[ebx+0ECh]
946b9359 85c9            test    ecx,ecx
946b935b 7407            je      dump_dumpfve!GetFveContext+0x190 (946b9364)

dump_dumpfve!GetFveContext+0x189:
946b935d c60000          mov     byte ptr [eax],0
946b9360 40              inc     eax
946b9361 49              dec     ecx
946b9362 75f9            jne     dump_dumpfve!GetFveContext+0x189 (946b935d)

dump_dumpfve!GetFveContext+0x190:
946b9364 6a14            push    14h
946b9366 59              pop     ecx
946b9367 8d83d8000000    lea     eax,[ebx+0D8h]

dump_dumpfve!GetFveContext+0x199:
946b936d c60000          mov     byte ptr [eax],0
946b9370 40              inc     eax
946b9371 49              dec     ecx
946b9372 75f9            jne     dump_dumpfve!GetFveContext+0x199 (946b936d)

dump_dumpfve!GetFveContext+0x1a0:
946b9374 384dff          cmp     byte ptr [ebp-1],cl
946b9377 740c            je      dump_dumpfve!GetFveContext+0x1b1 (946b9385)

dump_dumpfve!GetFveContext+0x1a5:
946b9379 8b4508          mov     eax,dword ptr [ebp+8]
946b937c 56              push    esi
946b937d ff7004          push    dword ptr [eax+4]
946b9380 e8a9fdffff      call    dump_dumpfve!FveUnregisterDynamicContext (946b912e)

dump_dumpfve!GetFveContext+0x1b1:
946b9385 8b4e10          mov     ecx,dword ptr [esi+10h]
946b9388 85c9            test    ecx,ecx
946b938a 7417            je      dump_dumpfve!GetFveContext+0x1cf (946b93a3)

dump_dumpfve!GetFveContext+0x1b8:
946b938c 8b460c          mov     eax,dword ptr [esi+0Ch]
946b938f 85c0            test    eax,eax
946b9391 7407            je      dump_dumpfve!GetFveContext+0x1c6 (946b939a)

dump_dumpfve!GetFveContext+0x1bf:
946b9393 c60100          mov     byte ptr [ecx],0
946b9396 41              inc     ecx
946b9397 48              dec     eax
946b9398 75f9            jne     dump_dumpfve!GetFveContext+0x1bf (946b9393)

dump_dumpfve!GetFveContext+0x1c6:
946b939a ff7610          push    dword ptr [esi+10h]
946b939d ff1520f06b94    call    dword ptr [dump_dumpfve!_imp__MmFreeContiguousMemory (946bf020)]

dump_dumpfve!GetFveContext+0x1cf:
946b93a3 b880000000      mov     eax,80h

dump_dumpfve!GetFveContext+0x1d4:
946b93a8 c60600          mov     byte ptr [esi],0
946b93ab 46              inc     esi
946b93ac 48              dec     eax
946b93ad 75f9            jne     dump_dumpfve!GetFveContext+0x1d4 (946b93a8)

dump_dumpfve!GetFveContext+0x1db:
946b93af 3845fe          cmp     byte ptr [ebp-2],al
946b93b2 740b            je      dump_dumpfve!GetFveContext+0x1eb (946b93bf)

dump_dumpfve!GetFveContext+0x1e0:
946b93b4 8b4508          mov     eax,dword ptr [ebp+8]
946b93b7 ff7004          push    dword ptr [eax+4]
946b93ba e825fdffff      call    dump_dumpfve!FveCancelHibernate (946b90e4)

dump_dumpfve!GetFveContext+0x1eb:
946b93bf 817d0c020000c0  cmp     dword ptr [ebp+0Ch],0C0000002h
946b93c6 7511            jne     dump_dumpfve!GetFveContext+0x205 (946b93d9)

dump_dumpfve!GetFveContext+0x1f4:
946b93c8 83631000        and     dword ptr [ebx+10h],0
946b93cc 83650c00        and     dword ptr [ebp+0Ch],0
946b93d0 eb07            jmp     dump_dumpfve!GetFveContext+0x205 (946b93d9)

dump_dumpfve!GetFveContext+0x1fe:
946b93d2 c7450c0d0000c0  mov     dword ptr [ebp+0Ch],0C000000Dh

dump_dumpfve!GetFveContext+0x205:
946b93d9 8b450c          mov     eax,dword ptr [ebp+0Ch]
946b93dc 5f              pop     edi
946b93dd 5e              pop     esi
946b93de 5b              pop     ebx
946b93df c9              leave
946b93e0 c20c00          ret     0Ch

NTSTATUS
DumpWrite(
    FILTER_EXTENSION* pFltExt,
    LARGE_INTEGER*    pDiskByteOffset,
    MDL*              pMdl )
{
    if ( 0 != pFltExt->DumpData->10h ) {
        DoubleBufferMdl(
            pMdl,
            dword ptr[ pFltExt->DumpData->18h ],
            esi );

        FveEncryptionWrite(
            pFltExt->DumpData,
            pMdl->MappedSystemVa,
            pDiskByteOffset->LowPart,
            pDiskByteOffset->HighPart,
            pMdl->ByteCount );
    }

    return STATUS_SUCCESS;
}

kd> uf dump_dumpfve!DumpWrite
dump_dumpfve!DumpWrite:
946b951e 8bff            mov     edi,edi
946b9520 55              push    ebp
946b9521 8bec            mov     ebp,esp
946b9523 8b4508          mov     eax,dword ptr [ebp+8]
946b9526 57              push    edi
946b9527 8b7840          mov     edi,dword ptr [eax+40h]    // edi = pFltExt->DumpData
946b952a 837f1000        cmp     dword ptr [edi+10h],0
946b952e 7422            je      dump_dumpfve!DumpWrite+0x34 (946b9552)

dump_dumpfve!DumpWrite+0x12:
946b9530 56              push    esi
946b9531 ff7718          push    dword ptr [edi+18h]
946b9534 8b7510          mov     esi,dword ptr [ebp+10h]    // esi = pMdl
946b9537 56              push    esi
946b9538 e8f7faffff      call    dump_dumpfve!DoubleBufferMdl (946b9034)
946b953d ff7614          push    dword ptr [esi+14h]        // pMdl->ByteCount
946b9540 8b450c          mov     eax,dword ptr [ebp+0Ch]
946b9543 ff7004          push    dword ptr [eax+4]
946b9546 ff30            push    dword ptr [eax]
946b9548 ff760c          push    dword ptr [esi+0Ch]        // pMdl->MappedSystemVa
946b954b 57              push    edi
946b954c e897feffff      call    dump_dumpfve!FveEncryptWrite (946b93e8)
946b9551 5e              pop     esi

dump_dumpfve!DumpWrite+0x34:
946b9552 33c0            xor     eax,eax
946b9554 5f              pop     edi
946b9555 5d              pop     ebp
946b9556 c20c00          ret     0Ch

void
DoubleBufferMdl(
    PMDL    pMdl,
            dword ptr[ pFltExt->DumpData->18h ] )
{
    char*   pSystemVa = pMdl->MappedSystemVa & 0xFFFFF000;
    pSystemVa += pMdl->ByteOffset;
    pFltExt->DumpData->18h &= 0xFFFFF000;
    pFltExt->DumpData->18h += pMdl->ByteOffset;

    memmove( pFltExt->DumpData->18h, pSystemVa, pMdl->ByteCount );

    pMdl->MappedSystemVa = pFltExt->DumpData->18h;
    ULONG byteCount = pMdl->ByteCount;

    pMdl->ByteCount &= 0xFFF;
    pSystemVa       &= 0xFFF;
}

kd> uf dump_dumpfve!DoubleBufferMdl
dump_dumpfve!DoubleBufferMdl:
946b9034 8bff            mov     edi,edi
946b9036 55              push    ebp
946b9037 8bec            mov     ebp,esp
946b9039 53              push    ebx
946b903a 8b5d0c          mov     ebx,dword ptr [ebp+0Ch]
946b903d 56              push    esi
946b903e 8b7508          mov     esi,dword ptr [ebp+8]      // esi = pMdl
946b9041 8b4e18          mov     ecx,dword ptr [esi+18h]    // ecx = pMdl->ByteOffset
946b9044 57              push    edi
946b9045 8b7e0c          mov     edi,dword ptr [esi+0Ch]    // edi = pMdl->MappedSystemVa
946b9048 ff7614          push    dword ptr [esi+14h]        // get pMdl->ByteCount
946b904b b800f0ffff      mov     eax,0FFFFF000h
946b9050 23f8            and     edi,eax                    // pMdl->MappedSystemVa &= 0xFFFFF000;  // PAGE_ALIGN
946b9052 03f9            add     edi,ecx                    // pMdl->MappedSystemVa += pMdl->ByteOffset;
946b9054 23d8            and     ebx,eax
946b9056 03d9            add     ebx,ecx
946b9058 57              push    edi
946b9059 53              push    ebx
946b905a ff1514f06b94    call    dword ptr [dump_dumpfve!_imp__memmove (946bf014)]
946b9060 8b4614          mov     eax,dword ptr [esi+14h]
946b9063 8bd3            mov     edx,ebx
946b9065 895e0c          mov     dword ptr [esi+0Ch],ebx
946b9068 8bd8            mov     ebx,eax
946b906a b9ff0f0000      mov     ecx,0FFFh
946b906f 23d9            and     ebx,ecx
946b9071 23f9            and     edi,ecx
946b9073 8dbc3bff0f0000  lea     edi,[ebx+edi+0FFFh]
946b907a 81e200f0ffff    and     edx,0FFFFF000h             // edx = PAGE_ALIGN( edx );
946b9080 c1ef0c          shr     edi,0Ch
946b9083 c1e80c          shr     eax,0Ch
946b9086 83c40c          add     esp,0Ch
946b9089 03f8            add     edi,eax
946b908b 895610          mov     dword ptr [esi+10h],edx    // pMdl->StartVa = PAGE_ALIGN( ebx );
946b908e 8d761c          lea     esi,[esi+1Ch]
946b9091 8bda            mov     ebx,edx
946b9093 7420            je      dump_dumpfve!DoubleBufferMdl+0x81 (946b90b5)

dump_dumpfve!DoubleBufferMdl+0x61:
946b9095 85db            test    ebx,ebx
946b9097 741c            je      dump_dumpfve!DoubleBufferMdl+0x81 (946b90b5)

dump_dumpfve!DoubleBufferMdl+0x65:
946b9099 53              push    ebx
946b909a ff1510f06b94    call    dword ptr [dump_dumpfve!_imp__MmGetPhysicalAddress (946bf010)]
946b90a0 b10c            mov     cl,0Ch
946b90a2 e8d1050000      call    dump_dumpfve!_allshr (946b9678)
946b90a7 8906            mov     dword ptr [esi],eax
946b90a9 83c604          add     esi,4
946b90ac 81c300100000    add     ebx,1000h
946b90b2 4f              dec     edi
946b90b3 75e0            jne     dump_dumpfve!DoubleBufferMdl+0x61 (946b9095)

dump_dumpfve!DoubleBufferMdl+0x81:
946b90b5 5f              pop     edi
946b90b6 5e              pop     esi
946b90b7 5b              pop     ebx
946b90b8 5d              pop     ebp
946b90b9 c20800          ret     8

