DATA SEGMENT
    STR1 DB 4,0,4 DUP(?)
    STR2 DB 4,0,4 DUP(?)
    STR3 DB ?
    RESULT DB 0,0,0AH,0DH,'$'
DATA ENDS

STACK SEGMENT       ;定义代码段
    DB 10H DUP(?)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK

MAIN PROC FAR
START:
    MOV AX,DATA
    MOV DS,AX
    MOV CX,2        ;设置循环次数
    LEA BX,STR1
INPUT1:             ;读入第一个两位数
    MOV AH,1
    INT 21H
    MOV [BX],AL
    INC BX
    LOOP INPUT1
STO:
    MOV AH,02H      ;换行
    MOV DL,0AH
    INT 21H
    MOV AH,02H      ;回车
    MOV DL,0DH
    INT 21H
    MOV CX,2
    LEA BX,STR2
INPUT2:             ;读入第二个两位数
    MOV AH,1
    INT 21H
    MOV [BX],AL
    INC BX
    LOOP INPUT2
OUTPUT:
    CALL BIN        ;调用子程序bin
    CALL HEX        ;调用子程序hex
    MOV AH,02H
    MOV DL,0AH
    INT 21H
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    LEA DX,RESULT
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H         ;返回DOS系统
MAIN ENDP

BIN PROC            ;十进制转二进制并且相加
    MOV AL,STR1
    SUB AL,30H      ;转换为相应的二进制数
    MOV DL,10       ;十位数减去30H再乘10
    MUL DL
    ADD AL,STR1+1   ;加上个位数
    SUB AL,30H      ;减去30H
    MOV STR3,AL
    MOV AL,STR2
    SUB AL,30H
    MOV DL,10
    MUL DL
    ADD AL,STR2+1
    SUB AL,30H
    ADD AL,STR3     ;转换后的两个二进制数相加
    MOV STR3,AL
    RET
BIN ENDP

HEX PROC            ;二进制转换为十六进制
    MOV CH,2
    MOV DL,STR3
    LEA BX,RESULT
STEP1:
    MOV CL,4
    ROL DL,CL       ;循环左移四位
    MOV AL,DL
    AND AL,0FH      ;取低四位
    CMP AL,09H      ;判断是否小于等于9
    JLE STEP2
    ADD AL,07H      ;字母加37H
STEP2:
    ADD AL,30H      ;数字加30H
    MOV [BX],AL
    INC BX
    DEC CH
    JNE STEP1
    RET
HEX ENDP

CODE ENDS
    END START