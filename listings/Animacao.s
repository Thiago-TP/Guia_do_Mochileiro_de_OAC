Animacao:
    addi	sp, sp, -4
    sw	  ra, 0(sp)
    
    call	GuardaFundo
    lw    a3, 8(a0)	    # a3 <- estado atual
    call	AtualizaPose
    call	ImprimeFundo	
        	
    lw	  ra, 0(sp)
    addi	sp, sp, 4
    ret