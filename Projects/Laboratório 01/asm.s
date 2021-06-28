        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
main    MOV R0, #0x55           ;O registrador R0 recebe o valor 2D hexadecimal
        MOV R1, R0, LSL #16     ;R1 recebe o valor de R0 deslocado 16 bits para a esquerda sem alterar R0
        MOV R2, R1, LSR #9      ;R2 recebe o valor de R1 deslocado 8 bits para a direita sem alterar R1
        MOV R3, R2, ASR #8      ;R3 recebe o valor de R2 com o deslocamento aritmético de 8 bits para a direita sem alterar R2
        MOV R4, R3, ROR #2      ;R4 recebe o valor de R3 - inalterado - com rotação de 2 bits para a direita, sendo que os 2 bits, menos significativos tornam-se os 2 bits mais significativos em R4 após a rotação
        MOV R5, R4, RRX         ;R5 recebe o valor de R4 com deslocamento de 1 bit para a direita, apagando o bit menos significativo, sem alterar R4 
        MOV R6, R5, RRX         ;R6 recebe o valor de R5 com deslocamento de 1 bit para a direita, apagando o bit menos significativo, sem alterar R5

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END
