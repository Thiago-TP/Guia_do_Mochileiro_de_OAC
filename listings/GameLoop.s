.data			          # x    y    estado 
	  personagem:	.word 152, 112, 0
	  .include "sprites/Lyn_datas.data"
	  .include "sprites/TileGrama.data"
.text
	  # inicializacao da animacao, s0 e a0
	  li	  t0, 0xFF200604
	  lw	  s0, 0(t0)	      # s0 = frame sendo mostrado
	  la	  a0, TileGrama	  # a0 <- sprite do fundo
	  li	  a1, 152		      # x
	  li	  a2, 112		      # y
	  mv	  a3, zero	      # frame 0
	  call	Print
	  li	  a3, 1		        # frame 1
	  call	Print
	  mv	  a3, s0		      # frame exposto
	  la	  a0, Lyn1StandBy	# a0 <- sprite do personagem
	  call	Print

GameLoop:	
	  la	  a0, personagem
	  call	Animacao
	  li	  a0, 150		      # intervalo em ms de cada pose
	  call	Sleep
	  j 	  GameLoop

.include "Animacao.s"
.include "AtualizaPose.s"
.include "GuardaFundo.s"
.include "ImprimeFundo.s"
.include "Print.s"
.include "Sleep.s"
