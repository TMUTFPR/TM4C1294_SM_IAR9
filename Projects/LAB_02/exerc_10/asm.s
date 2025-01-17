        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
main       
        MOV R0, #0x1 ;R0 recebe o valor 1 hexadecimal
        MOV R1, #0x4    ; R1 recebe o valor 4 hexadecimal
        MOV R2, #0 ; R2 recebe o valor 4 decimal
        
Mul16b
        LSRS R1, R1, #1; aqui, � realizado um deslocamento para a direita em R1, colocando o bit menos significativo no flag C
        BCS multiplica ; Se o flag C estiver setado em 1, realiza-se um desvio para a subrotina "multiplica"
        BCC desloca     ;Caso contr�rio, realiza-se um desvio para a subrotina "desloca"
        
multiplica
        ADD R2, R0 ; Soma-se o conte�do dos dois registradores
        LSL R0, R0, #1 ; deslocase-se R0 para a esquerda em uma unidade
        B sair  ; indica o fim da subrotina
        
desloca ADD R2, #0 ;
        LSL R0, R0, #1 ;deslocase-se R0 para a esquerda em uma unidade
        B sair  ;fim da subrotina
        
sair

        BNE Mul16b
fim     B fim

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
