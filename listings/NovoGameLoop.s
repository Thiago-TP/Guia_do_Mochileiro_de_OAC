.data
	    .include "sprites/Assassin_datas.data"
	    .include "sprites/TileVioleta.data"
	    personagem:	.word 151, 109, 0
	
	    changeTime:	.word 0x00000000
.eqv	animTime0	1000
.eqv	animTime1	50
.eqv	animTime2	300

.text
	# inicializacao da animacao, s0 e a0
	li	  t0, 0xFF200604
	lw	  s0, 0(t0)	        # s0 = frame sendo mostrado
	la	  a0, TileVioleta	  # a0 <- sprite do fundo
	li	  a1, 151		        # x
	li	  a2, 111		        # y
	mv	  a3, zero	        # frame 0
	call	Print
	li	  a3, 1		          # frame 1
	call	Print
	
	la	  a0, personagem    # a0 <- label do personagem
	lw	  a1, 0(a0)
	lw	  a2, 4(a0)
	mv	  a3, s0		        # frame exposto
	la	  a0, Assassin1Win	# a0 <- sprite do personagem
	call	Print

GameLoop:
	la	  a0, personagem
	call	Animacao
	j	    GameLoop


.include "Animacao.s"
.include "AtualizaPose.s"
.include "AtualizaEstados."
.include "GuardaFundo.s"
.include "ImprimeFundo.s"
.include "Print.s"