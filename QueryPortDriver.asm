kd> uf crashdmp!QueryPortDriver
crashdmp!QueryPortDriver:
91d62ee4 8bff            mov     edi,edi
91d62ee6 55              push    ebp
91d62ee7 8bec            mov     ebp,esp
91d62ee9 81ec90000000    sub     esp,90h
91d62eef 83a570ffffff00  and     dword ptr [ebp-90h],0
91d62ef6 56              push    esi
91d62ef7 6888000000      push    88h
91d62efc 8d8578ffffff    lea     eax,[ebp-88h]
91d62f02 6a00            push    0
91d62f04 50              push    eax
91d62f05 e896bfffff      call    crashdmp!memset (91d5eea0)
91d62f0a 8b7508          mov     esi,dword ptr [ebp+8]
91d62f0d 83c40c          add     esp,0Ch
91d62f10 ffb6a4000000    push    dword ptr [esi+0A4h]
91d62f16 ffb630010000    push    dword ptr [esi+130h]
91d62f1c e8c7030000      call    crashdmp!IsVolumeSupported (91d632e8)
91d62f21 85c0            test    eax,eax
91d62f23 0f8cec000000    jl      crashdmp!QueryPortDriver+0x131 (91d63015)

crashdmp!QueryPortDriver+0x45:
91d62f29 53              push    ebx
91d62f2a 57              push    edi
91d62f2b 6a20            push    20h
91d62f2d 5b              pop     ebx
91d62f2e 8d4508          lea     eax,[ebp+8]
91d62f31 50              push    eax
91d62f32 6a28            push    28h
91d62f34 8dbeb0000000    lea     edi,[esi+0B0h]
91d62f3a 57              push    edi
91d62f3b 6a08            push    8
91d62f3d 57              push    edi
91d62f3e ffb630010000    push    dword ptr [esi+130h]
91d62f44 c70702000000    mov     dword ptr [edi],2
91d62f4a 6820100400      push    41020h
91d62f4f 899eb4000000    mov     dword ptr [esi+0B4h],ebx
91d62f55 e810030000      call    crashdmp!SendDeviceControl (91d6326a)
91d62f5a 33c9            xor     ecx,ecx
91d62f5c 3bc1            cmp     eax,ecx
91d62f5e 0f8caf000000    jl      crashdmp!QueryPortDriver+0x12f (91d63013)

crashdmp!QueryPortDriver+0x80:
91d62f64 833f02          cmp     dword ptr [edi],2
91d62f67 7517            jne     crashdmp!QueryPortDriver+0x9c (91d62f80)

crashdmp!QueryPortDriver+0x85:
91d62f69 399eb4000000    cmp     dword ptr [esi+0B4h],ebx
91d62f6f 750f            jne     crashdmp!QueryPortDriver+0x9c (91d62f80)

crashdmp!QueryPortDriver+0x8d:
91d62f71 c786d800000001000000 mov dword ptr [esi+0D8h],1
91d62f7b 895e7c          mov     dword ptr [esi+7Ch],ebx
91d62f7e eb0d            jmp     crashdmp!QueryPortDriver+0xa9 (91d62f8d)

crashdmp!QueryPortDriver+0x9c:
91d62f80 898ed8000000    mov     dword ptr [esi+0D8h],ecx
91d62f86 c7467c28000000  mov     dword ptr [esi+7Ch],28h

crashdmp!QueryPortDriver+0xa9:
91d62f8d 8d4508          lea     eax,[ebp+8]
91d62f90 50              push    eax
91d62f91 6a08            push    8
91d62f93 8d86ec000000    lea     eax,[esi+0ECh]
91d62f99 50              push    eax
91d62f9a 51              push    ecx
91d62f9b 51              push    ecx
91d62f9c ffb630010000    push    dword ptr [esi+130h]
91d62fa2 6818100400      push    41018h
91d62fa7 e8be020000      call    crashdmp!SendDeviceControl (91d6326a)
91d62fac 33ff            xor     edi,edi
91d62fae 3bc7            cmp     eax,edi
91d62fb0 7c61            jl      crashdmp!QueryPortDriver+0x12f (91d63013)

crashdmp!QueryPortDriver+0xce:
91d62fb2 8d4508          lea     eax,[ebp+8]
91d62fb5 50              push    eax
91d62fb6 6890000000      push    90h
91d62fbb 8d8570ffffff    lea     eax,[ebp-90h]
91d62fc1 50              push    eax
91d62fc2 57              push    edi
91d62fc3 57              push    edi
91d62fc4 ffb630010000    push    dword ptr [esi+130h]
91d62fca 6848000700      push    70048h
91d62fcf e896020000      call    crashdmp!SendDeviceControl (91d6326a)
91d62fd4 3bc7            cmp     eax,edi
91d62fd6 7c3b            jl      crashdmp!QueryPortDriver+0x12f (91d63013)

crashdmp!QueryPortDriver+0xf4:
91d62fd8 8b8578ffffff    mov     eax,dword ptr [ebp-88h]
91d62fde 894670          mov     dword ptr [esi+70h],eax
91d62fe1 8b857cffffff    mov     eax,dword ptr [ebp-84h]
91d62fe7 894674          mov     dword ptr [esi+74h],eax
91d62fea 8d4508          lea     eax,[ebp+8]
91d62fed 50              push    eax
91d62fee 6a38            push    38h
91d62ff0 8d86f8000000    lea     eax,[esi+0F8h]
91d62ff6 50              push    eax
91d62ff7 57              push    edi
91d62ff8 57              push    edi
91d62ff9 ffb630010000    push    dword ptr [esi+130h]
91d62fff 68a0000700      push    700A0h
91d63004 e861020000      call    crashdmp!SendDeviceControl (91d6326a)
91d63009 3bc7            cmp     eax,edi
91d6300b 7c06            jl      crashdmp!QueryPortDriver+0x12f (91d63013)

crashdmp!QueryPortDriver+0x129:
91d6300d 56              push    esi
91d6300e e81df8ffff      call    crashdmp!FillDumpInitContext (91d62830)

crashdmp!QueryPortDriver+0x12f:
91d63013 5f              pop     edi
91d63014 5b              pop     ebx

crashdmp!QueryPortDriver+0x131:
91d63015 5e              pop     esi
91d63016 c9              leave
91d63017 c20400          ret     4

