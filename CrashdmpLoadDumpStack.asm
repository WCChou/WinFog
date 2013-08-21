kd> uf CrashdmpLoadDumpStack
crashdmp!CrashdmpLoadDumpStack:
95ce0006 8bff            mov     edi,edi
95ce0008 55              push    ebp
95ce0009 8bec            mov     ebp,esp
95ce000b 83ec30          sub     esp,30h
95ce000e 53              push    ebx
95ce000f 33db            xor     ebx,ebx
95ce0011 895df4          mov     dword ptr [ebp-0Ch],ebx
95ce0014 885dff          mov     byte ptr [ebp-1],bl
95ce0017 895df8          mov     dword ptr [ebp-8],ebx
95ce001a e847bcffff      call    crashdmp!CheckContextIntegrity (95cdbc66)
95ce001f 3bc3            cmp     eax,ebx
95ce0021 0f8cc9020000    jl      crashdmp!CrashdmpLoadDumpStack+0x2ea (95ce02f0)

crashdmp!CrashdmpLoadDumpStack+0x21:
95ce0027 56              push    esi
95ce0028 57              push    edi
95ce0029 8b7d10          mov     edi,dword ptr [ebp+10h]
95ce002c 83ff02          cmp     edi,2
95ce002f 753b            jne     crashdmp!CrashdmpLoadDumpStack+0x66 (95ce006c)

crashdmp!CrashdmpLoadDumpStack+0x2b:
95ce0031 c6055cf6cd9501  mov     byte ptr [crashdmp!Context+0x40c (95cdf65c)],1
95ce0038 381d54f2cd95    cmp     byte ptr [crashdmp!Context+0x4 (95cdf254)],bl
95ce003e 7505            jne     crashdmp!CrashdmpLoadDumpStack+0x3f (95ce0045)

crashdmp!CrashdmpLoadDumpStack+0x3a:
95ce0040 e8cbbfffff      call    crashdmp!HibernationInitialize (95cdc010)

crashdmp!CrashdmpLoadDumpStack+0x3f:
95ce0045 391d50f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],ebx
95ce004b 751f            jne     crashdmp!CrashdmpLoadDumpStack+0x66 (95ce006c)

crashdmp!CrashdmpLoadDumpStack+0x47:
95ce004d 8d45f0          lea     eax,[ebp-10h]
95ce0050 50              push    eax
95ce0051 688e15ce95      push    offset crashdmp! ?? ::NNGAKEGL::`string' (95ce158e)
95ce0056 680e15ce95      push    offset crashdmp! ?? ::NNGAKEGL::`string' (95ce150e)
95ce005b e874110000      call    crashdmp!ReadRegULongKey (95ce11d4)
95ce0060 85c0            test    eax,eax
95ce0062 7c08            jl      crashdmp!CrashdmpLoadDumpStack+0x66 (95ce006c)

crashdmp!CrashdmpLoadDumpStack+0x5e:
95ce0064 8b45f0          mov     eax,dword ptr [ebp-10h]
95ce0067 a350f6cd95      mov     dword ptr [crashdmp!Context+0x400 (95cdf650)],eax

crashdmp!CrashdmpLoadDumpStack+0x66:
95ce006c 6840010000      push    140h
95ce0071 e8be110000      call    crashdmp!AllocPool (95ce1234)
95ce0076 8bf0            mov     esi,eax
95ce0078 3bf3            cmp     esi,ebx
95ce007a 741a            je      crashdmp!CrashdmpLoadDumpStack+0x90 (95ce0096)

crashdmp!CrashdmpLoadDumpStack+0x76:
95ce007c 813d50f6cd9501200000 cmp dword ptr [crashdmp!Context+0x400 (95cdf650)],2001h
95ce0086 750a            jne     crashdmp!CrashdmpLoadDumpStack+0x8c (95ce0092)

crashdmp!CrashdmpLoadDumpStack+0x82:
95ce0088 53              push    ebx
95ce0089 56              push    esi
95ce008a ff151ce0cd95    call    dword ptr [crashdmp!_imp__ExFreePoolWithTag (95cde01c)]
95ce0090 33f6            xor     esi,esi

crashdmp!CrashdmpLoadDumpStack+0x8c:
95ce0092 3bf3            cmp     esi,ebx
95ce0094 750f            jne     crashdmp!CrashdmpLoadDumpStack+0x9f (95ce00a5)

crashdmp!CrashdmpLoadDumpStack+0x90:
95ce0096 bb9a0000c0      mov     ebx,0C000009Ah
95ce009b bf01200000      mov     edi,2001h
95ce00a0 e9cb010000      jmp     crashdmp!CrashdmpLoadDumpStack+0x26a (95ce0270)

crashdmp!CrashdmpLoadDumpStack+0x9f:
95ce00a5 8d8634010000    lea     eax,[esi+134h]
95ce00ab 894004          mov     dword ptr [eax+4],eax
95ce00ae 8900            mov     dword ptr [eax],eax
95ce00b0 8d8684000000    lea     eax,[esi+84h]
95ce00b6 894004          mov     dword ptr [eax+4],eax
95ce00b9 8900            mov     dword ptr [eax],eax
95ce00bb 8b4508          mov     eax,dword ptr [ebp+8]
95ce00be 89bea8000000    mov     dword ptr [esi+0A8h],edi
95ce00c4 898680000000    mov     dword ptr [esi+80h],eax
95ce00ca 395d18          cmp     dword ptr [ebp+18h],ebx
95ce00cd 7571            jne     crashdmp!CrashdmpLoadDumpStack+0x13a (95ce0140)

crashdmp!CrashdmpLoadDumpStack+0xc9:
95ce00cf a15cf2cd95      mov     eax,dword ptr [crashdmp!Context+0xc (95cdf25c)]
95ce00d4 6a40            push    40h
95ce00d6 8945d8          mov     dword ptr [ebp-28h],eax
95ce00d9 6a03            push    3
95ce00db 8d45e8          lea     eax,[ebp-18h]
95ce00de 50              push    eax
95ce00df 8d45d0          lea     eax,[ebp-30h]
95ce00e2 50              push    eax
95ce00e3 6880011000      push    100180h
95ce00e8 8d4518          lea     eax,[ebp+18h]
95ce00eb 50              push    eax
95ce00ec c745d018000000  mov     dword ptr [ebp-30h],18h
95ce00f3 895dd4          mov     dword ptr [ebp-2Ch],ebx
95ce00f6 c745dc00020000  mov     dword ptr [ebp-24h],200h
95ce00fd 895de0          mov     dword ptr [ebp-20h],ebx
95ce0100 895de4          mov     dword ptr [ebp-1Ch],ebx
95ce0103 ff1518e0cd95    call    dword ptr [crashdmp!_imp__ZwOpenFile (95cde018)]
95ce0109 8bd8            mov     ebx,eax
95ce010b bf02200000      mov     edi,2002h
95ce0110 85db            test    ebx,ebx
95ce0112 7c1e            jl      crashdmp!CrashdmpLoadDumpStack+0x12c (95ce0132)

crashdmp!CrashdmpLoadDumpStack+0x10e:
95ce0114 393d50f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],edi
95ce011a 7512            jne     crashdmp!CrashdmpLoadDumpStack+0x128 (95ce012e)

crashdmp!CrashdmpLoadDumpStack+0x116:
95ce011c ff7518          push    dword ptr [ebp+18h]
95ce011f ff1514e0cd95    call    dword ptr [crashdmp!_imp__ZwClose (95cde014)]
95ce0125 83651800        and     dword ptr [ebp+18h],0
95ce0129 bb010000c0      mov     ebx,0C0000001h

crashdmp!CrashdmpLoadDumpStack+0x128:
95ce012e 85db            test    ebx,ebx
95ce0130 7d08            jge     crashdmp!CrashdmpLoadDumpStack+0x134 (95ce013a)

crashdmp!CrashdmpLoadDumpStack+0x12c:
95ce0132 897df8          mov     dword ptr [ebp-8],edi
95ce0135 e929010000      jmp     crashdmp!CrashdmpLoadDumpStack+0x25d (95ce0263)

crashdmp!CrashdmpLoadDumpStack+0x134:
95ce013a c645ff01        mov     byte ptr [ebp-1],1
95ce013e 33db            xor     ebx,ebx

crashdmp!CrashdmpLoadDumpStack+0x13a:
95ce0140 53              push    ebx
95ce0141 8d4508          lea     eax,[ebp+8]
95ce0144 50              push    eax
95ce0145 a110e0cd95      mov     eax,dword ptr [crashdmp!IoFileObjectType (95cde010)]
95ce014a 53              push    ebx
95ce014b ff30            push    dword ptr [eax]
95ce014d 53              push    ebx
95ce014e ff7518          push    dword ptr [ebp+18h]
95ce0151 ff151ce1cd95    call    dword ptr [crashdmp!_imp__ObReferenceObjectByHandle (95cde11c)]
95ce0157 8b7d08          mov     edi,dword ptr [ebp+8]
95ce015a ff7704          push    dword ptr [edi+4]
95ce015d 897df4          mov     dword ptr [ebp-0Ch],edi
95ce0160 ff1590e0cd95    call    dword ptr [crashdmp!_imp__IoGetAttachedDeviceReference (95cde090)]
95ce0166 807dff01        cmp     byte ptr [ebp-1],1
95ce016a 898630010000    mov     dword ptr [esi+130h],eax
95ce0170 89bea4000000    mov     dword ptr [esi+0A4h],edi
95ce0176 7509            jne     crashdmp!CrashdmpLoadDumpStack+0x17b (95ce0181)

crashdmp!CrashdmpLoadDumpStack+0x172:
95ce0178 ff7518          push    dword ptr [ebp+18h]
95ce017b ff1514e0cd95    call    dword ptr [crashdmp!_imp__ZwClose (95cde014)]

crashdmp!CrashdmpLoadDumpStack+0x17b:
95ce0181 56              push    esi
95ce0182 e85d0d0000      call    crashdmp!QueryPortDriver (95ce0ee4)
95ce0187 8bd8            mov     ebx,eax
95ce0189 b803200000      mov     eax,2003h
95ce018e 85db            test    ebx,ebx
95ce0190 7c13            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x18c:
95ce0192 bf010000c0      mov     edi,0C0000001h
95ce0197 390550f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],eax
95ce019d 7502            jne     crashdmp!CrashdmpLoadDumpStack+0x19b (95ce01a1)

crashdmp!CrashdmpLoadDumpStack+0x199:
95ce019f 8bdf            mov     ebx,edi

crashdmp!CrashdmpLoadDumpStack+0x19b:
95ce01a1 85db            test    ebx,ebx
95ce01a3 7d08            jge     crashdmp!CrashdmpLoadDumpStack+0x1a7 (95ce01ad)

crashdmp!CrashdmpLoadDumpStack+0x19f:
95ce01a5 8945f8          mov     dword ptr [ebp-8],eax
95ce01a8 e9b6000000      jmp     crashdmp!CrashdmpLoadDumpStack+0x25d (95ce0263)

crashdmp!CrashdmpLoadDumpStack+0x1a7:
95ce01ad 685cf2cd95      push    offset crashdmp!Context+0xc (95cdf25c)
95ce01b2 56              push    esi
95ce01b3 e83e0f0000      call    crashdmp!LoadPortDriver (95ce10f6)
95ce01b8 8bd8            mov     ebx,eax
95ce01ba b804200000      mov     eax,2004h
95ce01bf 85db            test    ebx,ebx
95ce01c1 7ce2            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x1bd:
95ce01c3 390550f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],eax
95ce01c9 7502            jne     crashdmp!CrashdmpLoadDumpStack+0x1c7 (95ce01cd)

crashdmp!CrashdmpLoadDumpStack+0x1c5:
95ce01cb 8bdf            mov     ebx,edi

crashdmp!CrashdmpLoadDumpStack+0x1c7:
95ce01cd 85db            test    ebx,ebx
95ce01cf 7cd4            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x1cb:
95ce01d1 685cf2cd95      push    offset crashdmp!Context+0xc (95cdf25c)
95ce01d6 56              push    esi
95ce01d7 e864a4ffff      call    crashdmp!LoadFilterDrivers (95cda640)
95ce01dc 8bd8            mov     ebx,eax
95ce01de b805200000      mov     eax,2005h
95ce01e3 85db            test    ebx,ebx
95ce01e5 7cbe            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x1e1:
95ce01e7 390550f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],eax
95ce01ed 7502            jne     crashdmp!CrashdmpLoadDumpStack+0x1eb (95ce01f1)

crashdmp!CrashdmpLoadDumpStack+0x1e9:
95ce01ef 8bdf            mov     ebx,edi

crashdmp!CrashdmpLoadDumpStack+0x1eb:
95ce01f1 85db            test    ebx,ebx
95ce01f3 7cb0            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x1ef:
95ce01f5 56              push    esi
95ce01f6 e84ba5ffff      call    crashdmp!InitializeFilterDrivers (95cda746)
95ce01fb 8bd8            mov     ebx,eax
95ce01fd b806200000      mov     eax,2006h
95ce0202 85db            test    ebx,ebx
95ce0204 7c9f            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x200:
95ce0206 390550f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],eax
95ce020c 7502            jne     crashdmp!CrashdmpLoadDumpStack+0x20a (95ce0210)

crashdmp!CrashdmpLoadDumpStack+0x208:
95ce020e 8bdf            mov     ebx,edi

crashdmp!CrashdmpLoadDumpStack+0x20a:
95ce0210 85db            test    ebx,ebx
95ce0212 7c91            jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x20e:
95ce0214 ff7514          push    dword ptr [ebp+14h]
95ce0217 6a01            push    1
95ce0219 56              push    esi
95ce021a e8250a0000      call    crashdmp!SendUsageNotification (95ce0c44)
95ce021f 8bd8            mov     ebx,eax
95ce0221 b807200000      mov     eax,2007h
95ce0226 85db            test    ebx,ebx
95ce0228 0f8c77ffffff    jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x228:
95ce022e 390550f6cd95    cmp     dword ptr [crashdmp!Context+0x400 (95cdf650)],eax
95ce0234 7502            jne     crashdmp!CrashdmpLoadDumpStack+0x232 (95ce0238)

crashdmp!CrashdmpLoadDumpStack+0x230:
95ce0236 8bdf            mov     ebx,edi

crashdmp!CrashdmpLoadDumpStack+0x232:
95ce0238 85db            test    ebx,ebx
95ce023a 0f8c65ffffff    jl      crashdmp!CrashdmpLoadDumpStack+0x19f (95ce01a5)

crashdmp!CrashdmpLoadDumpStack+0x23a:
95ce0240 837d1002        cmp     dword ptr [ebp+10h],2
95ce0244 8d86b0000000    lea     eax,[esi+0B0h]
95ce024a 894678          mov     dword ptr [esi+78h],eax
95ce024d 8d86ec000000    lea     eax,[esi+0ECh]
95ce0253 894650          mov     dword ptr [esi+50h],eax
95ce0256 8b450c          mov     eax,dword ptr [ebp+0Ch]
95ce0259 8930            mov     dword ptr [eax],esi
95ce025b 7506            jne     crashdmp!CrashdmpLoadDumpStack+0x25d (95ce0263)

crashdmp!CrashdmpLoadDumpStack+0x257:
95ce025d 893558f6cd95    mov     dword ptr [crashdmp!Context+0x408 (95cdf658)],esi

crashdmp!CrashdmpLoadDumpStack+0x25d:
95ce0263 85db            test    ebx,ebx
95ce0265 7d74            jge     crashdmp!CrashdmpLoadDumpStack+0x2d5 (95ce02db)

crashdmp!CrashdmpLoadDumpStack+0x261:
95ce0267 837df800        cmp     dword ptr [ebp-8],0
95ce026b 7417            je      crashdmp!CrashdmpLoadDumpStack+0x27e (95ce0284)

crashdmp!CrashdmpLoadDumpStack+0x267:
95ce026d 8b7df8          mov     edi,dword ptr [ebp-8]

crashdmp!CrashdmpLoadDumpStack+0x26a:
95ce0270 57              push    edi
95ce0271 53              push    ebx
95ce0272 682d0004c0      push    0C004002Dh
95ce0277 6a00            push    0
95ce0279 e83cbdffff      call    crashdmp!CrashdmpWriteErrorLog (95cdbfba)
95ce027e 893d3cf6cd95    mov     dword ptr [crashdmp!Context+0x3ec (95cdf63c)],edi

crashdmp!CrashdmpLoadDumpStack+0x27e:
95ce0284 a138f6cd95      mov     eax,dword ptr [crashdmp!Context+0x3e8 (95cdf638)]
95ce0289 85c0            test    eax,eax
95ce028b 7420            je      crashdmp!CrashdmpLoadDumpStack+0x2a7 (95ce02ad)

crashdmp!CrashdmpLoadDumpStack+0x287:
95ce028d 50              push    eax
95ce028e ff1510e1cd95    call    dword ptr [crashdmp!_imp__KeDeregisterBugCheckReasonCallback (95cde110)]
95ce0294 a138f6cd95      mov     eax,dword ptr [crashdmp!Context+0x3e8 (95cdf638)]
95ce0299 85c0            test    eax,eax
95ce029b 7410            je      crashdmp!CrashdmpLoadDumpStack+0x2a7 (95ce02ad)

crashdmp!CrashdmpLoadDumpStack+0x297:
95ce029d 6a00            push    0
95ce029f 50              push    eax
95ce02a0 ff151ce0cd95    call    dword ptr [crashdmp!_imp__ExFreePoolWithTag (95cde01c)]
95ce02a6 832538f6cd9500  and     dword ptr [crashdmp!Context+0x3e8 (95cdf638)],0

crashdmp!CrashdmpLoadDumpStack+0x2a7:
95ce02ad 685cf2cd95      push    offset crashdmp!Context+0xc (95cdf25c)
95ce02b2 56              push    esi
95ce02b3 e8b20b0000      call    crashdmp!FreePortResources (95ce0e6a)
95ce02b8 8b4df4          mov     ecx,dword ptr [ebp-0Ch]
95ce02bb 85c9            test    ecx,ecx
95ce02bd 7406            je      crashdmp!CrashdmpLoadDumpStack+0x2bf (95ce02c5)

crashdmp!CrashdmpLoadDumpStack+0x2b9:
95ce02bf ff1514e1cd95    call    dword ptr [crashdmp!_imp_ObfDereferenceObject (95cde114)]

crashdmp!CrashdmpLoadDumpStack+0x2bf:
95ce02c5 8b450c          mov     eax,dword ptr [ebp+0Ch]
95ce02c8 832000          and     dword ptr [eax],0
95ce02cb 803d5cf6cd9501  cmp     byte ptr [crashdmp!Context+0x40c (95cdf65c)],1
95ce02d2 7507            jne     crashdmp!CrashdmpLoadDumpStack+0x2d5 (95ce02db)

crashdmp!CrashdmpLoadDumpStack+0x2ce:
95ce02d4 c6055cf6cd9500  mov     byte ptr [crashdmp!Context+0x40c (95cdf65c)],0

crashdmp!CrashdmpLoadDumpStack+0x2d5:
95ce02db b906010000      mov     ecx,106h
95ce02e0 be50f2cd95      mov     esi,offset crashdmp!Context (95cdf250)
95ce02e5 bf68f6cd95      mov     edi,offset crashdmp!ContextCopy (95cdf668)
95ce02ea f3a5            rep movs dword ptr es:[edi],dword ptr [esi]
95ce02ec 5f              pop     edi
95ce02ed 8bc3            mov     eax,ebx
95ce02ef 5e              pop     esi

crashdmp!CrashdmpLoadDumpStack+0x2ea:
95ce02f0 5b              pop     ebx
95ce02f1 c9              leave
95ce02f2 c21400          ret     14h
kd> du 95ce150e
95ce150e  "\Registry\Machine\System\Current"
95ce154e  "ControlSet\Control\CrashControl"
kd> du 95ce158e
95ce158e  "SimulateError"

