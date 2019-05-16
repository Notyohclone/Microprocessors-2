CNT EQU 3FD6H
BPORT EQU 3FD2H
COMM1 EQU 0FFC8H
COMM2 EQU 0FFCAH  
CODE SEGMENT
     ASSUME CS:CODE, DS:CODE
START:
        CLI
        MOV SP,4000H  
        MOV AX,CS
        MOV DS,AX
;Setup IRO interrupt vector
MAIN:
        MOV AX,0
        MOV ES, AX
        MOV BX,40H*4
        MOV ES:WORD PTR[BX],OFFSET INTR0
; Initialize COmmand WOrds
ICW1:
        MOV DX,COMM1
        MOV AL,00010011B
        OUT DX,AL
ICW2:
        MOV DX,COMM2
        MOV AL,40H
        OUT DX,AL
ICW4:
        MOV AL,00000101B
        OUT DX,AL
;Operation COmmand Words
OCW1:
        MOV AL,11111110B
        OUT DX,AL
;Setup 8255 Control Word register and initialize LED
8255:
        MOV DX,CNT
        MOV AL,80H
        OUT DX,AL
        MOV AL,01H
        MOV DX,BPORT
        OUT DX,AL
        STI
        JMP $
INTR0:
        ROL AL,1
        OUT DX,AL
        MOV CX,5FFFH
        LOOP $
        PUSH AX
        PUSH DX
        MOV DX,COMM1
        MOV AL,20H
        OUT DX,AL
        POP DX
        POP AX
CODE   ENDS
        END START

