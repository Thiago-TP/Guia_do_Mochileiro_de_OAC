    byte2RGB:
    	# bits de vermelho	# t5 =  bbgggrrr
    	andi 	t0, t5, 0x07	# t0 <- 0000 0rrr 
    	li	t3, 32		      # t3 <- 32
    	mul	t0, t0, t3	    # t0 <- rrr*32 = R
    	# bits de verde
    	andi	t1, t5, 0x38	# t1 <- 00GG G000
    	srli	t1, t1, 3	    # t1 <- 00000ggg
    	#li	t3, 32		      # t0 <- 32
    	mul	t1, t1, t3	    # t1 <- ggg*32 = G
    	# bits de azul
    	srli	t2, t5, 6	    # t0 <- 000000bb
    	li	t3, 64		      # t3 <- 64 
    	mul	t2, t2, t3	    # t2 <- bb*64 = B
    	
    	ret			            # retorno por pseudo