#################################################################################
#	exibicao das cores do RARS pelo metodo de impressao "azulejada"		#
#	agosto de 2022 - 2022/1	- OAC						#	
#################################################################################

li	s0, 300				# s0 <- 300 = quantidade de tiles que serao impressas
li	s1, 256				# s1 <- 256 = quantidade de cores
li	a0, 0x00			# a0 <- byte de cor da tile (inicialmente 0, que eh preto)
mv	a1, x0				# a1 <- posicao em x no bitmap da primeira tile
mv	a2, x0				# a2 <- posicao em y no bitmap da primeira tile
mv	a3, x0				# contador de tiles
PrintTileLoop:
	beq	a3, s0, PrintTileEnd	# num. de tiles = total ? fim do programa : mais uma tile
	call	PrintTile		# uma tile de cor a0 eh impressa em (a1, a2)
	# ^jal ao inves de call economizaria uma instrucao, vide o Execute 
	addi	a0, a0, 1		# uma tile foi impressa => mudamos a cor
	rem	a0, a0, s1		# a0 = a0 % 256 para evitar a0 > 255
	# ^comente a linha acima para ver que o RARS a executa por debaixo dos panos,
	#  isto eh, as cores passam a se repetir
	addi	a1, a1, 16		# deslocamento em x para a proxima tile
	addi	a3, a3, 1		# incrementacao do contador de tiles
	li	t0, 320			# t0 <= largura do bitmap
	beq	a1, t0, ProximaLinhaDeTiles	# eh hora de pular linha ? pulamos : iteramos o loop
	j	PrintTileLoop
ProximaLinhaDeTiles:
	mv	a1, x0			# pos. em x reinicia do 0 (seria possivel usar rem)
	addi	a2, a2, 16		# deslocamento em y para a proxima tile
	j	PrintTileLoop		# iteracao do loop
PrintTileEnd:
	fpg:	j fpg			# loop eterno para o fpgrars
	li	a7, 10			# fim do programa por pseudoinstrucao
	ecall
#
	
# para onde foi a cor 199? ;)	
	
#########################################################################
#	esta funcao imprime uma "tile" colorida 16x16 no bitmap		#
#########################################################################
#	a0 = byte de cor da tile					#
#	a1 = posicao em x no bitmap					#
#	a2 = posicao em y no bitmap					#
#########################################################################

PrintTile:	
	# primeiramente, colorimos uma linha horizontal de 16 bits
	li	t0, 16			# t0 <- tamanho da linha
	mv	t1, x0			# t1 <- contador de bytes na linha
	mv	t2, x0			# t2 <- contador de linhas
	li	t3, 0xFF000000		# t3 recebe o endereco inicial do bitmap no frame 0 (canto superior esquerdo)
	# ^ate aqui, estamos no canto superior esquerdo (0,0), mas queremos ir a (a1, a2)
	mv	t4, a1			# guardamos a1 em t4 por seguranca
	mv	t5, a2			# guardamos a2 em t5 por seguranca
	add	t3, t3, t4		# t3 <- 0xFF000000 + a1	
	# ^ate aqui, estamos em (a1, 0)
	li	t6, 320			# auxiliar t6=320 para pularmos as linhas
	mul	t5, t5, t6		# t5 = 320*a2 => pula a2 linhas no bitmap
	add	t3, t3, t5		# finalmente chegamos ao endereco em (a1, a2) :)
PrintLoop:
	beq	t1, t0, PulaLinha	# len(linha oclorida) = 16 ? proxima linha : mais um byte de cor
	sb	a0, 0(t3) 		# colore o byte de endereco t3
	addi	t3, t3, 1		# 1 byte foi impresso => vamos ao endereco do proximo byte
	addi	t1, t1, 1		# 1 byte foi impresso => contador incrementa
	j	PrintLoop		# iteracao do loop
PulaLinha:
	addi	t2, t2, 1		# nova linha <=> contador de linhas aumenta
	beq	t2, t0, PrintEnd	# num. de linhas = 16 ? fim da funcao : continua o loop
	mv	t1, x0			# contador reinicia
	addi	t3, t3, 320		# nova linha <=> endereco do bitmap incrementa na largura do bitmap
	# ^ate aqui, saimos de um ponto na aresta direita e caimos no ponto logo abaixo da mesma aresta
	addi	t3, t3, -16		# subtraindo a largura da tile, caimos na aresta esquerda 
	j	PrintLoop		# iteracao do loop
PrintEnd:
	ret				# retorno da funcao por pseudoinstrucao	
#		
					
							
