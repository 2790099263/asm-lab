DATA SEGMENT          ;�������ݶ�
             VARX DB 18H     ;X
             VARY DB 34H     ;Y
             VARZ DW ?
             OPR DB 0         ;0��ʾ�޷�������1��ʾ�з�����
DATA ENDS
CODE SEGMENT          ;��������
             ASSUME CS:CODE,DS:DATA
START:                               
             MOV AX,DATA     ;ָ�ʼ��ַ
             MOV DS,AX          ;��ʼ��DS
	     XOR AH,AH
	     XOR BH,BH
             MOV AL,VARX	;ȡX
             MOV BL,VARY	;ȡY
             MOV CL,OPR
             CMP  CL,0   
             JZ UNSIGN      ;��Ϊ�޷���������ת7
             MOV DX,AX
             MOV CL,2
             SAL AX,CL     ;X������λ��4X
             ADD AX,DX   ;����4X+X=5X
             SAL BX,1     ;Y����һλ��2Y
             ADD AX,BX   ;5X+7Y
             SUB AX,7	;5X+2Y-7
             SAR AX,1	;(5X+2Y-7)/2
             JMP RESULT
UNSIGN:
             MOV DX,AX
             MOV CL,2
             SHL AX,CL     ;X������λ��4X
             ADD AX,DX   ;����4X+X=5X
             
             SHL BX,1     ;Y����һλ��2Y
             
             ADD AX,BX   ;5X+7Y
             SUB AX,7      ;5X+2Y-7
             SHR AX,1      ;(5X+2Y-7)/2
RESULT:
             MOV VARZ,AX ;���������浽Z��
             MOV AH,4CH
             INT 21H             ;����DOS����ϵͳ
CODE    ENDS
             END START        ;��������־
            