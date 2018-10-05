.MODEL SMALL
.STACK 100H
.DATA
    ARRAY DB 10,30,45,20,27,26
    TEMP DB 0
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    LEA SI,ARRAY
    LEA DI,TEMP
    XOR AX,AX
    XOR DX,DX
    PUSH AX
    MOV BX,5
    PUSH BX
    CALL MAX
    MOV AX,DX
    CALL OUTDEC
    MOV AH,76
    INT 33
MAIN ENDP

MAX PROC
    PUSH BP
    MOV BP,SP
    MOV BX,[BP+4]
    MOV AX,[BP+6]
    CMP BX,AX
    JG @ELSE
        ;THEN
        PUSH SI
        ADD SI,AX
        MOV DL,[SI]
        POP SI
        JMP @RETURN
    @ELSE:
    PUSH AX
    MOV CX,BX
    SUB CX,AX
    SHR CX,1
    ADD CX,AX
    PUSH CX
    CALL MAX
    MOV [DI],DL
    INC CX
    PUSH CX
    PUSH BX
    CALL MAX
    CMP [DI],DL
    JNG @RETURN
        ;ELSE
        MOV DL,[DI]
    @RETURN:
        POP BP
        RET 4
MAX ENDP
INCLUDE D:\outdec.asm
END MAIN

