        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
main
        MOV R0, #0              ;;R0 recebe o valor 5 decimal
        PUSH {R1, R2}           ;;introduz-se os valores R1 e R2 na pilha 
        MOV R1, R0              ;;R1 recebe o valor de R0
        CMP R0, #0              ;;Verificando se o valor do registrador R0 é zero, podendo alterar a flag Z
        BEQ zero_fatorial       ;;Se a flag Z estiver em 1, é realizado um desvio para a sub_rotina "zero_fatorial"
        B fatorial              ;;Caso contrário, é realizado um desvio para a sub_rotina "fatorial"

zero_fatorial
        MOV R0, #1              ;;Caso a flag Z tenha valor 1, entra-se na subrotina (zero_fatorial), que atribui 1 a R0
        B fim

fatorial
        SUB R1, #1              ;;Para a lógica de fatorial, usa-se a subtração de 1 em R1
        CBZ R1, fim             ;;Verifica-se se R1 possui valor 0. Em caso afirmativo, desvia-se para o fim
        SMULL R0, R2, R0, R1    ;;Multiplica-se os registradores R0 e R1 de forma sinalizada, e o resultado é armazenado em R2 e R0
                                ;;sendo que o primeiro recebe os bits mais significativos, enquanto que o segundo recebe os bits menos
                                ;;significativos do resultado da multiplicação
        CMP R2, #0              ;;Verifica-se se R2 possui valor 0. Se for verdadeiro, a flag Z recebe 1, indicando o fim do cálculo
        BNE carry               ;;Se o flag Z está em 0, significa que foram extrapolados os 32 bits
        B fatorial              ;;Esta linha de comando realiza um desvio para o começo da subrotina, enquanto o cálculo ainda estiver sendo efetuado

carry
        MOV R0, #-1             ;;Se o cálculo excede os 32 bits, é adicionado o valor -1 em R0
        POP {R1, R2}            ;;O comando POP devolve os valores de R1 e R2 que foram empilhados com PUSH, conservando seus bits iniciais

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
