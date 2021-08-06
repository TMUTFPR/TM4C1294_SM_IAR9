# TM4C1294_SM_IAR9
As alterações realizadas para o exercicio 20 estão no arquivo gpio_int

GPIOJ_Handler:
    LDR R1, =GPIO_PORTJ_BASE
    LDR R0, [R1, #GPIO_RIS]
    STR R0, [R1, #GPIO_ICR]
    
    CMP R0, #2          ; compara se R0 = 2
    IT EQ               ; se for verdadeiro, realiza as linhas seguintes identados 
      SUBEQ R11, R11, #1        ; Subtrai 1 do valor de R11 caso seja verdadeiro
      BEQ int_end       ; se for verdaeiro, vai para o final da SR sem realizar a operação da linha seguinte
    ADD R11, R11, #1    ; se for falso, realiza esta operação
    B int_end ; retorno da ISR 

int_end:  BX LR
