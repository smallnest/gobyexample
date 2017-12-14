// dummy操作，主要为了noescape, 可以通过go compile生成

#include "textflag.h"

TEXT ·noescape(SB),NOSPLIT,$0-48
        MOVQ    d_base+0(FP),   AX
        MOVQ    AX,     b_base+24(FP)
        MOVQ    d_len+8(FP),    AX
        MOVQ    AX,     b_len+32(FP)
        MOVQ    d_cap+16(FP),AX
        MOVQ    AX,     b_cap+40(FP)
        RET
