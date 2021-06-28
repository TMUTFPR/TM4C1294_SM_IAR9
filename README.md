# TM4C1294_SM_IAR9
Exemplos Assembly ARM Cortex-M (IDE IAR EWARM V9.10)
Neste projeto, estudamos como o sistema se comporta com os comandos de deslocamento e rotação;
As alterações feitas no projeto estão resumidas abaixo;

        MOV R0, #0x55           ;O registrador R0 recebe o valor 2D hexadecimal
        MOV R1, R0, LSL #16     ;R1 recebe o valor de R0 deslocado 16 bits para a esquerda sem alterar R0
        MOV R2, R1, LSR #9      ;R2 recebe o valor de R1 deslocado 8 bits para a direita sem alterar R1
        MOV R3, R2, ASR #8      ;R3 recebe o valor de R2 com o deslocamento aritmético de 8 bits para a direita sem alterar R2
        MOV R4, R3, ROR #2      ;R4 recebe o valor de R3 - inalterado - com rotação de 2 bits para a direita, sendo que os 2 bits, menos significativos tornam-se os 2 bits mais significativos em R4 após a rotação
        MOV R5, R4, RRX         ;R5 recebe o valor de R4 com deslocamento de 1 bit para a direita, apagando o bit menos significativo, sem alterar R4 
        MOV R6, R5, RRX         ;R6 recebe o valor de R5 com deslocamento de 1 bit para a direita, apagando o bit menos significativo, sem alterar R5
