AtualizaEstados:
	beqz	a3, estado0	    # estado = 0 ?
	li	  t0, 1
	beq	  a3, t0, estado1 # estado = 1 ?

	la	  t0, changeTime	# estado = 2
	lw	  t1, 0(t0)	      # t1 <- tempo da ultima troca de pose
	csrr	t2, time	      # t2 <- tempo atual
	sub	  t3, t2, t1	    # t3 <- quanto tempo a pose atual esta na tela
	li	  t1, animTime2	  # t1 <- tempo que a pose atual deve ficar
	bgeu	t3, t1, mudaEstado	# deu o tempo ? muda o estado
fimAtualizaEstados:
	ret
	
estado0:
	la	  t0, changeTime	# estado = 0
	lw	  t1, 0(t0)	      # t1 <- tempo da ultima troca de pose
	csrr	t2, time	      # t2 <- tempo atual
	sub	  t3, t2, t1	    # t3 <- quanto tempo a pose atual esta na tela
	li	  t1, animTime0	  # t1 <- tempo que a pose atual deve ficar
	bgeu	t3, t1, mudaEstado	# deu o tempo ? muda o estado
	j	    fimAtualizaEstados
estado1:
	la	  t0, changeTime	# estado = 1
	lw	  t1, 0(t0)	      # t1 <- tempo da ultima troca de pose
	csrr	t2, time	      # t2 <- tempo atual
	sub	  t3, t2, t1	    # t3 <- quanto tempo a pose atual esta na tela
	li	  t1, animTime1	  # t1 <- tempo que a pose atual deve ficar
	bgeu	t3, t1, mudaEstado	# deu o tempo ? muda o estado
	j	    fimAtualizaEstados

mudaEstado:
	addi	a3, a3, 1
	li	  t0, 3
	remu	a3, a3, t0	    # estado atual = estado anterior + 1 (mod 3)
	la	  t0, changeTime
	sw	  t2, 0(t0)	      # tempo da mudanca eh atualizada
	j	    fimAtualizaEstados