
;@-------------------------------------------------------------------------
;@-------------------------------------------------------------------------

.globl _start
_start:
    b skip

.space 0x200000-0x8004,0

skip:

    ;@ stop caching !!!
    ;@ mrc p15,0,r2,c1,c0,0
    ;@ bic r2,#0x1000
    ;@ bic r2,#0x0004
    ;@ mcr p15,0,r2,c1,c0,0

    mov sp,#0x08000000
    bl main
hang: b hang

.globl PUT32
PUT32:
    str r1,[r0]
    bx lr

.globl PUT16
PUT16:
    strh r1,[r0]
    bx lr

.globl PUT8
PUT8:
    strb r1,[r0]
    bx lr

.globl GET32
GET32:
    ldr r0,[r0]
    bx lr

.globl GETPC
GETPC:
    mov r0,lr
    bx lr

.globl BRANCHTO
BRANCHTO:
    mov r12,#0
    mcr p15, 0, r12, c7, c10, 1
    dsb
    mov r12, #0
    mcr p15, 0, r12, c7, c5, 0
    mov r12, #0
    mcr p15, 0, r12, c7, c5, 6
    dsb
    isb
    bx r0

.globl dummy
dummy:
    bx lr

.globl GETCPSR
GETCPSR:
    mrs r0,cpsr
    bx lr

.globl GETSCTLR
GETSCTLR:
    mrc p15,0,r0,c1,c0,0
    bx lr



;@-------------------------------------------------------------------------
;@-------------------------------------------------------------------------
