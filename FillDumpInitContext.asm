ebx = CrashdmpContext

kd> uf crashdmp!FillDumpInitContext
crashdmp!FillDumpInitContext:
91d62830 8bff            mov     edi,edi
91d62832 55              push    ebp
91d62833 8bec            mov     ebp,esp
91d62835 51              push    ecx
91d62836 51              push    ecx
91d62837 a10400d691      mov     eax,dword ptr [crashdmp!_imp__KeStallExecutionProcessor (91d60004)]
91d6283c 53              push    ebx
91d6283d 8b5d08          mov     ebx,dword ptr [ebp+8]
91d62840 894328          mov     dword ptr [ebx+28h],eax
91d62843 33d2            xor     edx,edx
91d62845 8d83ec000000    lea     eax,[ebx+0ECh]
91d6284b c70370000000    mov     dword ptr [ebx],70h
91d62851 895304          mov     dword ptr [ebx+4],edx
91d62854 894350          mov     dword ptr [ebx+50h],eax
91d62857 8b831c010000    mov     eax,dword ptr [ebx+11Ch]
91d6285d 56              push    esi
91d6285e 57              push    edi
91d6285f 894358          mov     dword ptr [ebx+58h],eax
91d62862 3bc2            cmp     eax,edx
91d62864 7514            jne     crashdmp!FillDumpInitContext+0x4a (91d6287a)

crashdmp!FillDumpInitContext+0x36:
91d62866 8b8320010000    mov     eax,dword ptr [ebx+120h]
91d6286c 89435c          mov     dword ptr [ebx+5Ch],eax
91d6286f 8b8324010000    mov     eax,dword ptr [ebx+124h]
91d62875 894360          mov     dword ptr [ebx+60h],eax
91d62878 eb0d            jmp     crashdmp!FillDumpInitContext+0x57 (91d62887)

crashdmp!FillDumpInitContext+0x4a:
91d6287a 8db320010000    lea     esi,[ebx+120h]
91d62880 8d7b5c          lea     edi,[ebx+5Ch]
91d62883 a5              movs    dword ptr es:[edi],dword ptr [esi]
91d62884 a5              movs    dword ptr es:[edi],dword ptr [esi]
91d62885 a5              movs    dword ptr es:[edi],dword ptr [esi]
91d62886 a5              movs    dword ptr es:[edi],dword ptr [esi]

crashdmp!FillDumpInitContext+0x57:
91d62887 be00000100      mov     esi,10000h
91d6288c 3993d8000000    cmp     dword ptr [ebx+0D8h],edx
91d62892 753e            jne     crashdmp!FillDumpInitContext+0xa2 (91d628d2)

crashdmp!FillDumpInitContext+0x64:
91d62894 8b83b0000000    mov     eax,dword ptr [ebx+0B0h]
91d6289a 8b8bc8000000    mov     ecx,dword ptr [ebx+0C8h]
91d628a0 894338          mov     dword ptr [ebx+38h],eax
91d628a3 8b83b4000000    mov     eax,dword ptr [ebx+0B4h]
91d628a9 89433c          mov     dword ptr [ebx+3Ch],eax
91d628ac 8b83b8000000    mov     eax,dword ptr [ebx+0B8h]
91d628b2 894340          mov     dword ptr [ebx+40h],eax
91d628b5 b800200000      mov     eax,2000h
91d628ba 3bc8            cmp     ecx,eax
91d628bc 7602            jbe     crashdmp!FillDumpInitContext+0x90 (91d628c0)

crashdmp!FillDumpInitContext+0x8e:
91d628be 8bc1            mov     eax,ecx

crashdmp!FillDumpInitContext+0x90:
91d628c0 89434c          mov     dword ptr [ebx+4Ch],eax
91d628c3 3bc6            cmp     eax,esi
91d628c5 7603            jbe     crashdmp!FillDumpInitContext+0x9a (91d628ca)

crashdmp!FillDumpInitContext+0x97:
91d628c7 89734c          mov     dword ptr [ebx+4Ch],esi

crashdmp!FillDumpInitContext+0x9a:
91d628ca 8a83cc000000    mov     al,byte ptr [ebx+0CCh]
91d628d0 eb23            jmp     crashdmp!FillDumpInitContext+0xc5 (91d628f5)

crashdmp!FillDumpInitContext+0xa2:
91d628d2 8b83b8000000    mov     eax,dword ptr [ebx+0B8h]
91d628d8 8b8bc0000000    mov     ecx,dword ptr [ebx+0C0h]
91d628de 894340          mov     dword ptr [ebx+40h],eax
91d628e1 b800200000      mov     eax,2000h
91d628e6 3bc8            cmp     ecx,eax
91d628e8 7602            jbe     crashdmp!FillDumpInitContext+0xbc (91d628ec)

crashdmp!FillDumpInitContext+0xba:
91d628ea 8bc1            mov     eax,ecx

crashdmp!FillDumpInitContext+0xbc:
91d628ec 89434c          mov     dword ptr [ebx+4Ch],eax
91d628ef 8a83c4000000    mov     al,byte ptr [ebx+0C4h]

crashdmp!FillDumpInitContext+0xc5:
91d628f5 89734c          mov     dword ptr [ebx+4Ch],esi
91d628f8 3c01            cmp     al,1
91d628fa 753d            jne     crashdmp!FillDumpInitContext+0x109 (91d62939)

crashdmp!FillDumpInitContext+0xcc:
91d628fc 895508          mov     dword ptr [ebp+8],edx
91d628ff 8955fc          mov     dword ptr [ebp-4],edx
91d62902 8d7318          lea     esi,[ebx+18h]
91d62905 8d7b0c          lea     edi,[ebx+0Ch]

crashdmp!FillDumpInitContext+0xd8:
91d62908 ff75fc          push    dword ptr [ebp-4]
91d6290b 83c8ff          or      eax,0FFFFFFFFh
91d6290e 50              push    eax
91d6290f ff734c          push    dword ptr [ebx+4Ch]
91d62912 ff153000d691    call    dword ptr [crashdmp!_imp__MmAllocateContiguousMemory (91d60030)]
91d62918 85c0            test    eax,eax
91d6291a 7426            je      crashdmp!FillDumpInitContext+0x112 (91d62942)

crashdmp!FillDumpInitContext+0xec:
91d6291c 50              push    eax
91d6291d 8907            mov     dword ptr [edi],eax
91d6291f ff152c00d691    call    dword ptr [crashdmp!_imp__MmGetPhysicalAddress (91d6002c)]
91d62925 ff4508          inc     dword ptr [ebp+8]
91d62928 8906            mov     dword ptr [esi],eax
91d6292a 895604          mov     dword ptr [esi+4],edx
91d6292d 83c704          add     edi,4
91d62930 83c608          add     esi,8
91d62933 837d0802        cmp     dword ptr [ebp+8],2
91d62937 72cf            jb      crashdmp!FillDumpInitContext+0xd8 (91d62908)

crashdmp!FillDumpInitContext+0x109:
91d62939 33c0            xor     eax,eax

crashdmp!FillDumpInitContext+0x10b:
91d6293b 5f              pop     edi
91d6293c 5e              pop     esi
91d6293d 5b              pop     ebx
91d6293e c9              leave
91d6293f c20400          ret     4

crashdmp!FillDumpInitContext+0x112:
91d62942 b89a0000c0      mov     eax,0C000009Ah
91d62947 ebf2            jmp     crashdmp!FillDumpInitC

