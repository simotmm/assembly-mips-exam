LEN = 4 
.data 
testoInChiaro:  .asciiz "ciao" 
verme:    .asciiz "mips" 
testoCifrato:  .space 23 
 
.text 
.globl main 
.ent main 

main: 
    la $a0, testoInChiaro 
    la $a1, verme 
    li $a2, LEN 
    la $a3, testoCifrato 

    jal cifrarioVigenere   
    
    li $v0, 4
    addi $a0, $a3, 0
    syscall

    li $v0, 10
    syscall
.end main

cifrarioVigenere:
    li $t0, 0

    loop:
        lb $t1, ($a0)
        beq $t1, $0, endLoop

        div $t0, $a2        #posizione del verme    
        mfhi $t9

        add $t8, $t9, $a1   #indirizzo del verme carattere

        li $t7, 'a'
        sub $t8, $t8, $t7   #posizione alfabetica del carattere del verme

        add $t6, $t8, $t1   #carattere cifrato

        li $t7, 'z'
        bgt $t6, $t7, riparti
        j continua

        riparti:
            div $t6, $t7
            mfhi $t6
            li $t7, 'a'
            add $t6, $t6, $t7

        continua:

        sb $t6, ($a3)

        addi $t0, $t0, 1
        addi $a3, $a3, 1
        addi $a0, $a0, 1
        j loop
    endLoop:
    addi $t0, $t0, 1
    addi $a3, $a3, 1
    sb $0, ($a3)
    sub $a3, $a3, $t0
    jr $ra
