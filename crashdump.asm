kd> uf crashdmp!FilterCallback
crashdmp!FilterCallback:
9468b94a 8bff            mov     edi,edi
9468b94c 55              push    ebp
9468b94d 8bec            mov     ebp,esp
9468b94f 51              push    ecx
9468b950 8b550c          mov     edx,dword ptr [ebp+0Ch]
9468b953 8d8a34010000    lea     ecx,[edx+134h]
9468b959 56              push    esi
9468b95a 8b31            mov     esi,dword ptr [ecx]
9468b95c 33c0            xor     eax,eax
9468b95e 8975fc          mov     dword ptr [ebp-4],esi
9468b961 3bf1            cmp     esi,ecx
9468b963 0f8463010000    je      crashdmp!FilterCallback+0x182 (9468bacc)

crashdmp!FilterCallback+0x1f:
9468b969 53              push    ebx
9468b96a 57              push    edi

crashdmp!FilterCallback+0x21:
9468b96b 8b5dfc          mov     ebx,dword ptr [ebp-4]
9468b96e 83c390          add     ebx,0FFFFFF90h
9468b971 f6437801        test    byte ptr [ebx+78h],1
9468b975 0f8539010000    jne     crashdmp!FilterCallback+0x16a (9468bab4)

crashdmp!FilterCallback+0x31:
9468b97b 8b4d08          mov     ecx,dword ptr [ebp+8]
9468b97e 33f6            xor     esi,esi
9468b980 2bce            sub     ecx,esi
9468b982 747b            je      crashdmp!FilterCallback+0xb5 (9468b9ff)

crashdmp!FilterCallback+0x3a:
9468b984 49              dec     ecx
9468b985 745a            je      crashdmp!FilterCallback+0x97 (9468b9e1)

crashdmp!FilterCallback+0x3d:
9468b987 49              dec     ecx
9468b988 7433            je      crashdmp!FilterCallback+0x73 (9468b9bd)

crashdmp!FilterCallback+0x40:
9468b98a 49              dec     ecx
9468b98b 0f8514010000    jne     crashdmp!FilterCallback+0x15b (9468baa5)

crashdmp!FilterCallback+0x47:
9468b991 8b4b10          mov     ecx,dword ptr [ebx+10h]
9468b994 3bce            cmp     ecx,esi
9468b996 0f8409010000    je      crashdmp!FilterCallback+0x15b (9468baa5)

crashdmp!FilterCallback+0x52:
9468b99c 8d4328          lea     eax,[ebx+28h]
9468b99f 50              push    eax
9468b9a0 ffd1            call    ecx
9468b9a2 85c0            test    eax,eax
9468b9a4 0f8d07010000    jge     crashdmp!FilterCallback+0x167 (9468bab1)

crashdmp!FilterCallback+0x60:
9468b9aa 8b4b10          mov     ecx,dword ptr [ebx+10h]

crashdmp!FilterCallback+0x63:
9468b9ad 890d48f66894    mov     dword ptr [crashdmp!Context+0x3f8 (9468f648)],ecx
9468b9b3 a34cf66894      mov     dword ptr [crashdmp!Context+0x3fc (9468f64c)],eax
9468b9b8 e9e5000000      jmp     crashdmp!FilterCallback+0x158 (9468baa2)

crashdmp!FilterCallback+0x73:
9468b9bd 8b4b0c          mov     ecx,dword ptr [ebx+0Ch]
9468b9c0 3bce            cmp     ecx,esi
9468b9c2 0f84dd000000    je      crashdmp!FilterCallback+0x15b (9468baa5)

crashdmp!FilterCallback+0x7e:
9468b9c8 ff7514          push    dword ptr [ebp+14h]
9468b9cb 8d4328          lea     eax,[ebx+28h]
9468b9ce ff7510          push    dword ptr [ebp+10h]
9468b9d1 50              push    eax
9468b9d2 ffd1            call    ecx
9468b9d4 85c0            test    eax,eax
9468b9d6 0f8dd5000000    jge     crashdmp!FilterCallback+0x167 (9468bab1)

crashdmp!FilterCallback+0x92:
9468b9dc 8b4b0c          mov     ecx,dword ptr [ebx+0Ch]
9468b9df ebcc            jmp     crashdmp!FilterCallback+0x63 (9468b9ad)

crashdmp!FilterCallback+0x97:
9468b9e1 8b4b08          mov     ecx,dword ptr [ebx+8]
9468b9e4 3bce            cmp     ecx,esi
9468b9e6 0f84b9000000    je      crashdmp!FilterCallback+0x15b (9468baa5)

crashdmp!FilterCallback+0xa2:
9468b9ec 8d4328          lea     eax,[ebx+28h]
9468b9ef 50              push    eax
9468b9f0 ffd1            call    ecx
9468b9f2 85c0            test    eax,eax
9468b9f4 0f8db7000000    jge     crashdmp!FilterCallback+0x167 (9468bab1)

crashdmp!FilterCallback+0xb0:
9468b9fa 8b4b08          mov     ecx,dword ptr [ebx+8]
9468b9fd ebae            jmp     crashdmp!FilterCallback+0x63 (9468b9ad)

crashdmp!FilterCallback+0xb5:
9468b9ff 897304          mov     dword ptr [ebx+4],esi
9468ba02 897320          mov     dword ptr [ebx+20h],esi
9468ba05 33c0            xor     eax,eax
9468ba07 c7431c10000000  mov     dword ptr [ebx+1Ch],10h
9468ba0e 40              inc     eax
9468ba0f 8903            mov     dword ptr [ebx],eax
9468ba11 8b8a30010000    mov     ecx,dword ptr [edx+130h]
9468ba17 894b2c          mov     dword ptr [ebx+2Ch],ecx
9468ba1a 6a06            push    6
9468ba1c 59              pop     ecx
9468ba1d 8db2f8000000    lea     esi,[edx+0F8h]
9468ba23 8d7b30          lea     edi,[ebx+30h]
9468ba26 f3a5            rep movs dword ptr es:[edi],dword ptr [esi]
9468ba28 8b8a10010000    mov     ecx,dword ptr [edx+110h]
9468ba2e 894b48          mov     dword ptr [ebx+48h],ecx
9468ba31 8b8a14010000    mov     ecx,dword ptr [edx+114h]
9468ba37 894b4c          mov     dword ptr [ebx+4Ch],ecx
9468ba3a 6a06            push    6
9468ba3c 59              pop     ecx
9468ba3d 8db218010000    lea     esi,[edx+118h]
9468ba43 8d7b50          lea     edi,[ebx+50h]
9468ba46 f3a5            rep movs dword ptr es:[edi],dword ptr [esi]
9468ba48 6a02            push    2
9468ba4a 5e              pop     esi
9468ba4b 8d4b28          lea     ecx,[ebx+28h]
9468ba4e 39b2a8000000    cmp     dword ptr [edx+0A8h],esi
9468ba54 7504            jne     crashdmp!FilterCallback+0x110 (9468ba5a)

crashdmp!FilterCallback+0x10c:
9468ba56 8931            mov     dword ptr [ecx],esi
9468ba58 eb02            jmp     crashdmp!FilterCallback+0x112 (9468ba5c)

crashdmp!FilterCallback+0x110:
9468ba5a 8901            mov     dword ptr [ecx],eax

crashdmp!FilterCallback+0x112:
9468ba5c 8b8380000000    mov     eax,dword ptr [ebx+80h]
9468ba62 8b4008          mov     eax,dword ptr [eax+8]
9468ba65 8b701c          mov     esi,dword ptr [eax+1Ch]
9468ba68 53              push    ebx
9468ba69 51              push    ecx
9468ba6a ffd6            call    esi
9468ba6c 85c0            test    eax,eax
9468ba6e 7c19            jl      crashdmp!FilterCallback+0x13f (9468ba89)

crashdmp!FilterCallback+0x126:
9468ba70 813d50f6689406200000 cmp dword ptr [crashdmp!Context+0x400 (9468f650)],2006h
9468ba7a 7509            jne     crashdmp!FilterCallback+0x13b (9468ba85)

crashdmp!FilterCallback+0x132:
9468ba7c 834b2001        or      dword ptr [ebx+20h],1
9468ba80 b8010000c0      mov     eax,0C0000001h

crashdmp!FilterCallback+0x13b:
9468ba85 85c0            test    eax,eax
9468ba87 7d13            jge     crashdmp!FilterCallback+0x152 (9468ba9c)

crashdmp!FilterCallback+0x13f:
9468ba89 893548f66894    mov     dword ptr [crashdmp!Context+0x3f8 (9468f648)],esi
9468ba8f a34cf66894      mov     dword ptr [crashdmp!Context+0x3fc (9468f64c)],eax
9468ba94 f6432001        test    byte ptr [ebx+20h],1
9468ba98 7530            jne     crashdmp!FilterCallback+0x180 (9468baca)

crashdmp!FilterCallback+0x150:
9468ba9a eb06            jmp     crashdmp!FilterCallback+0x158 (9468baa2)

crashdmp!FilterCallback+0x152:
9468ba9c 8b4b18          mov     ecx,dword ptr [ebx+18h]
9468ba9f 894b68          mov     dword ptr [ebx+68h],ecx

crashdmp!FilterCallback+0x158:
9468baa2 8b550c          mov     edx,dword ptr [ebp+0Ch]

crashdmp!FilterCallback+0x15b:
9468baa5 85c0            test    eax,eax
9468baa7 7d0b            jge     crashdmp!FilterCallback+0x16a (9468bab4)

crashdmp!FilterCallback+0x15f:
9468baa9 834b7801        or      dword ptr [ebx+78h],1
9468baad 33c0            xor     eax,eax
9468baaf eb03            jmp     crashdmp!FilterCallback+0x16a (9468bab4)

crashdmp!FilterCallback+0x167:
9468bab1 8b550c          mov     edx,dword ptr [ebp+0Ch]

crashdmp!FilterCallback+0x16a:
9468bab4 8b4dfc          mov     ecx,dword ptr [ebp-4]
9468bab7 8b09            mov     ecx,dword ptr [ecx]
9468bab9 8db234010000    lea     esi,[edx+134h]
9468babf 894dfc          mov     dword ptr [ebp-4],ecx
9468bac2 3bce            cmp     ecx,esi
9468bac4 0f85a1feffff    jne     crashdmp!FilterCallback+0x21 (9468b96b)

crashdmp!FilterCallback+0x180:
9468baca 5f              pop     edi
9468bacb 5b              pop     ebx

crashdmp!FilterCallback+0x182:
9468bacc 5e              pop     esi
9468bacd c9              leave
9468bace c3              ret

