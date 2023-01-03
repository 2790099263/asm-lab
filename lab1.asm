DATA SEGMENT                                             
           BUF DB -1,20,3,30,-5,15,100,-54,0,4,78,99,-12,32,3,23,-7,24,60,-51
           STRING DB '10',0AH,0DH,'$'                
DATA ENDS
ESEG SEGMENT
        RES1 DB 0   ;小于0的数据统计数
        RES2 DB 0   ;大于等于0且小于等于5的数据统计数
        RES3 DB 0   ;大于5的数据统计数
ESEG ENDS

STACK SEGMENT   
        DB 20H DUP(?)
STACK ENDS

CODE SEGMENT        ;定义代码段
        ASSUME CS:CODE,DS:DATA,ES:ESEG

START:
    MOV AX,DATA     ;初始开始指令
    MOV DS,AX       ;初始化DS
    MOV AX,ESEG
    MOV ES,AX
    LEA SI,BUF
    MOV RES1,0      ;保证存储单元为0
    MOV RES2,0
    MOV RES3,0
    MOV CX  ,20     ;数据的个数
NEXT1:
    MOV AL,[SI]
    CMP AL,5        ;数据和5进行比较
    JL  NEXT2
    INC RES3        ;单元RES3计数加一
    JMP STO
NEXT2:
    CMP AL,0        ;和数据0进行比较
    JL  NEXT3
    INC RES2        ;单元RES2计数加一
    JMP STO
NEXT3:
    INC RES1        ;单元RES1计数加一
STO:
    INC SI
    LOOP    NEXT1   ;循环
    MOV AH,02H      ;屏幕显示6
    MOV DL,36H
    INT 21H
    MOV AH,02H      ;换行
    MOV DL,0AH
    INT 21H
    MOV AH,02H      ;回车
    MOV DL,0DH
    INT 21H

    MOV AH,02H      ;屏幕显示4
    MOV DL,34H
    INT 21H
    MOV AH,02H
    MOV DL,0AH
    INT 21H
    MOV AH,02H
    MOV DL,0DH
    INT 21H

    LEA DX,STRING   ;获取要显示的字符串的首地址
    MOV AH,09H      ;调用字符串的显示功能
    INT 21H
    MOV AH,02H
    MOV DL,0AH
    INT 21H
    MOV AH,02H
    MOV DL,0DH
    INT 21H         ;屏幕显示10
    MOV AH,4CH
    INT 21H         ;返回DOS操作系统

CODE ENDS
    END START       ;汇编结束标志

