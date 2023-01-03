DATA SEGMENT          ;定义数据段
             VARX DB 18H     ;X
             VARY DB 34H     ;Y
             VARZ DW ?
             OPR DB 0         ;0表示无符号数，1表示有符号数
DATA ENDS
CODE SEGMENT          ;定义代码段
             ASSUME CS:CODE,DS:DATA
START:                               
             MOV AX,DATA     ;指令开始地址
             MOV DS,AX          ;初始化DS
	     XOR AH,AH
	     XOR BH,BH
             MOV AL,VARX	;取X
             MOV BL,VARY	;取Y
             MOV CL,OPR
             CMP  CL,0   
             JZ UNSIGN      ;若为无符号数则跳转7
             MOV DX,AX
             MOV CL,2
             SAL AX,CL     ;X左移两位，4X
             ADD AX,DX   ;计算4X+X=5X
             SAL BX,1     ;Y左移一位，2Y
             ADD AX,BX   ;5X+7Y
             SUB AX,7	;5X+2Y-7
             SAR AX,1	;(5X+2Y-7)/2
             JMP RESULT
UNSIGN:
             MOV DX,AX
             MOV CL,2
             SHL AX,CL     ;X左移两位，4X
             ADD AX,DX   ;计算4X+X=5X
             
             SHL BX,1     ;Y左移一位，2Y
             
             ADD AX,BX   ;5X+7Y
             SUB AX,7      ;5X+2Y-7
             SHR AX,1      ;(5X+2Y-7)/2
RESULT:
             MOV VARZ,AX ;将运算结果存到Z中
             MOV AH,4CH
             INT 21H             ;返回DOS操作系统
CODE    ENDS
             END START        ;汇编结束标志
            