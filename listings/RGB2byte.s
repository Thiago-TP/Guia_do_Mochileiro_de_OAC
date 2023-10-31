    RGB2byte:
    	# bits de vermelho
    	li	t3, 32		      # t3 <- 32
    	divu	t0, t0, t3	  # t0 <- R/32 = 0...000 rrr
    	# bits de verde
    	divu	t1, t1, t3	  # t1 <- G/32 = 0...000 ggg
    	slli	t1, t1, 3	    # t1 <- 0...00 ggg000
    	# bits de azul
    	li	t3, 64		      # t3 <- 64
    	divu	t2, t2, t3	  # t2 <- B/64 = 0...000 0bb
    	slli	t2, t2, 6	    # t2 <- 0...0 bb000000
    	# montagem de t5
    	add	t5, x0, t0	    # t5 <- 0...0 00000rrr
    	add	t5, t5, t1	    # t5 <- 0...0 00gggrrr
    	add	t5, t5, t2	    # t5 <- 0...0 bbgggrrr
    	
    	ret			            # retorno por pseudo