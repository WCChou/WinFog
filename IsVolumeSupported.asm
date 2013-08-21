kd> uf crashdmp!IsVolumeSupported
crashdmp!IsVolumeSupported:
91d512e8 8bff            mov     edi,edi
91d512ea 55              push    ebp
91d512eb 8bec            mov     ebp,esp
91d512ed 83ec20          sub     esp,20h
91d512f0 8365e000        and     dword ptr [ebp-20h],0
91d512f4 57              push    edi
91d512f5 6a06            push    6
91d512f7 59              pop     ecx
91d512f8 33c0            xor     eax,eax
91d512fa 8d7de8          lea     edi,[ebp-18h]
91d512fd f3ab            rep stos dword ptr es:[edi]
91d512ff 8d4508          lea     eax,[ebp+8]
91d51302 50              push    eax
91d51303 6a20            push    20h
91d51305 8d45e0          lea     eax,[ebp-20h]
91d51308 50              push    eax
91d51309 6a00            push    0
91d5130b 6a00            push    0
91d5130d ff7508          push    dword ptr [ebp+8]
91d51310 6800005600      push    560000h
91d51315 e850ffffff      call    crashdmp!SendDeviceControl (91d5126a)
91d5131a 5f              pop     edi
91d5131b 85c0            test    eax,eax
91d5131d 7d0e            jge     crashdmp!IsVolumeSupported+0x45 (91d5132d)

crashdmp!IsVolumeSupported+0x37:
91d5131f 3d05000080      cmp     eax,80000005h
91d51324 7407            je      crashdmp!IsVolumeSupported+0x45 (91d5132d)

crashdmp!IsVolumeSupported+0x3e:
91d51326 3d230000c0      cmp     eax,0C0000023h
91d5132b 7522            jne     crashdmp!IsVolumeSupported+0x67 (91d5134f)

crashdmp!IsVolumeSupported+0x45:
91d5132d 837de001        cmp     dword ptr [ebp-20h],1
91d51331 761c            jbe     crashdmp!IsVolumeSupported+0x67 (91d5134f)

crashdmp!IsVolumeSupported+0x4b:
91d51333 8b450c          mov     eax,dword ptr [ebp+0Ch]
91d51336 8b4004          mov     eax,dword ptr [eax+4]
91d51339 8b401c          mov     eax,dword ptr [eax+1Ch]
91d5133c 2500010000      and     eax,100h
91d51341 f7d8            neg     eax
91d51343 1bc0            sbb     eax,eax
91d51345 2545ffff3f      and     eax,3FFFFF45h
91d5134a 05bb0000c0      add     eax,0C00000BBh

crashdmp!IsVolumeSupported+0x67:
91d5134f c9              leave
91d51350 c20800          ret     8

