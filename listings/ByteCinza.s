    ByteCinza:	
    	addi 	sp, sp, -20 # expansao da pilha 
    	sw	ra, 0(sp)     # armazenamento de registradores
    	sw	t0, 4(sp)
	    sw	t1, 8(sp)
    	sw	t2, 12(sp)	
	    sw	t3, 16(sp)
	
    	li	t3, 0x000000c7
    	beq	t5, t3, fimByteCinza	# cor invisivel -> nao a acinzentamos
    	jal	byte2RGB	    # t0 <- R, t1 <- G, t2 <- B
    	
    	add	t0, t0, t1	  # t0 <- R + G
    	add	t0, t0, t2	  # t0 <- R + G + B
    	li	t1, 3		      # t1 = 3
    	divu	t0, t0, t1	# t0 <- media[R,G,B]
    	mv	t1, t0		    # t1 <- G=R=media
    	mv	t2, t0		    # t2 <- B=R=media
    	
    	jal	RGB2byte	    # t5 <- versao cinza do byte original

fimByteCinza:    	
    	lw	ra, 0(sp)     # recuperacao de registradores
      lw	t0, 4(sp)
	    lw	t1, 8(sp)
    	lw	t2, 12(sp)	
	    lw	t3, 16(sp)
    	addi	sp, sp, 20  # contracao da pilha
    	ret			          # retorno por pseudo