#Integrantes: Nicolás Miranda y Jonathan Molina
#Segundo parcial (juego de memoria) de la asignatura de Máquinas Digitales
#Pontificia Universidad Javeriana
#NOTA: se deben ingresar todas las letras en minúscula
#Las parejas son: A-C, B-F, D-M, E-H, G-J, I-P, K-O, L-N

	.include "macros.asm"
	.eqv ROJO 0x00FF0000
	.eqv VERDE 0x00FF00
	.data
		msjBienvenida: 	.asciiz "Bienvenido, presione una tecla para continuar...\n"
		msjIntentos: 	.asciiz "Intentos restantes: "
		msjDataError: 	.asciiz "\nletra invalida\n"
		msjacierto: 	.asciiz "\nmuy bien, sigue asi\n"
		msjError: 	.asciiz "\nPareja incorrecta, sigue intentando, presiona una tecla para continuar\n"
		msjParejas: 	.asciiz "\nIngrese las letras que conforman las parejas: "
		msjGanar: 	.asciiz "\nFelicidades, ha ganado :)"
		msjPerder: 	.asciiz "\nIntentos finalizados"
		msjFin: 	.asciiz "\nDesea jugar de nuevo? 1.Si - 2.no: "
		msjVoltea: 	.asciiz "\nLa carta ya esta volteada, intentelo de nuevo\n"
	.text
	
main:
	addi $fp, $zero, 5	#Registro que guarda el contador de los intentos
	addi $a1,$zero, 8	#Registro que guarda el contador de las parejas
	
	#Guarda en el respectivo registro las letras desde la A a la P (en código ASCII)
	li $s0,97		
	li $s1,98		
	li $sp,99		
	li $gp,100		
	li $t6,101		
	li $t7,102		
	li $t8,103		
	li $t9,104		
	li $s3,105
	li $s4,106		
	li $s5,107			
	li $s6,108		
	li $s7,109		
	li $k0,110
	li $k1,111
	li $s2,112
	
	borrar( AZUL_CLARO )
	
	dibujarNombre()
	dibujarIcono()
	
	imprimirMensaje( msjBienvenida )
	
	li $v0, 12
	syscall
	
	borrar( ROSA )
	dibujarTablero()
	dibujarLetras()
	
	addi $t3, $zero, 1

#Funcion que hace tiene el ciclo y e core de las funcionalidades del juego		
while:
        ble $fp, 0, perder	#Si el contador de intentos es menor o igual que cero termina el ciclo y el jugador pierde	
        ble $a1, 0, ganar	#Si el contador de parejas es menor o igual que cero termina el ciclo y el jugado gana
        addi $t3, $zero, -1

	imprimirMensaje( msjIntentos )
	li $v0, 1
	addi $a0, $fp, 0
	syscall
	
	imprimirMensaje( msjParejas )
	li $v0, 12
	syscall
	
	jal verificarVoltea1
	jal comparar
	move $a2, $v0
	jal verificar
	
#Función que permite continuar digitando la letra de la segunda ficha	
continua:	
	imprimirMensaje( msjParejas )
	li $v0, 12
	syscall
	addi $t3, $zero, 1
	
	jal verificarVoltea1
	jal comparar
	move $a3, $v0
	jal verificar1

#Salta a la función de acierto para realizar las correspondientes  verificaciones de las letras	
continua1:
	jal acierto
	
#Función que imprime el mensaje y pantalla alusiva a que el jugador ha ganado	
ganar:
       imprimirMensaje( msjGanar )
       ganar( VERDE )
       jal exit
       
#Función que imprime el mensaje y pantalla alusiva a que el jugador ha perdido
perder:
       imprimirMensaje( msjPerder )
       perder( ROJO )
       jal exit

#Función que espera 2 segundo e imprime el mensaje de que si el jugador quiere seguir jugando o no
exit:
       li $v0, 32
       li $a0, 2000
       syscall
       imprimirMensaje( msjFin )
       li $v0, 5
       syscall
       beq $v0, 1, main
       jal fin

#Función que verifica si la primer letra ingresada está entre el rango de la a y la p	
verificar:	
	beq  $s0,$a2, continua
        beq  $a2,$s1, continua
	beq  $a2,$sp, continua
	beq  $a2,$gp, continua
	beq  $a2,$t6, continua
	beq  $a2,$t7, continua
	beq  $a2,$t8, continua
	beq  $a2,$t9, continua
	beq  $a2,$s3, continua
	beq  $a2,$s4, continua
	beq  $a2,$s5, continua
	beq  $a2,$s6, continua
	beq  $a2,$s7, continua
	beq  $a2,$k0, continua
	beq  $a2,$k1, continua
	beq  $a2,$s2, continua
        imprimirMensaje(msjDataError)
        jal while
 #Función que verifica si la segunda letra ingresada está entre el rango de la a y la p	       
verificar1:	
	beq $s0, $a3, continua1
        beq $a3, $s1, continua1
	beq $a3, $sp, continua1
	beq $a3, $gp, continua1
	beq $a3, $t6, continua1
	beq $a3, $t7, continua1
	beq $a3, $t8, continua1
	beq $a3, $t9, continua1
	beq $a3, $s3, continua1
	beq $a3, $s4, continua1
	beq $a3, $s5, continua1
	beq $a3, $s6, continua1
	beq $a3, $s7, continua1
	beq $a3, $k0, continua1
	beq $a3, $k1, continua1
	beq $a3, $s2, continua1
        imprimirMensaje( msjDataError )
        jal continua
        
#Función que va disminuyendo el contador de los intentos y guarda esto en el registro fp                      
contadorIntentos:
	sub $fp, $fp, 1
	jr $ra	

#Desde esta a la mostrarIconoP invoca la macro de dibujar el icono de la respectiva letra
mostrarIconoA:
	dibujarIconoA()
	jr $ra
	
mostrarIconoB:
	dibujarIconoB()
	jr $ra
	
mostrarIconoC:
	dibujarIconoC()
	jr $ra
	
mostrarIconoD:
	dibujarIconoD()
	jr $ra
	
mostrarIconoE:
	dibujarIconoE()
	jr $ra
	
mostrarIconoF:
	dibujarIconoF()
	jr $ra
	
mostrarIconoG:
	dibujarIconoG()
	jr $ra
	
mostrarIconoH:
	dibujarIconoH()
	jr $ra
	
mostrarIconoI:
	dibujarIconoI()
	jr $ra
	
mostrarIconoJ:
	dibujarIconoJ()
	jr $ra
	
mostrarIconoK:
	dibujarIconoK()
	jr $ra
	
mostrarIconoL:
	dibujarIconoL()
	jr $ra
	
mostrarIconoM:
	dibujarIconoM()
	jr $ra
	
mostrarIconoN:
	dibujarIconoN()
	jr $ra
	
mostrarIconoO:
	dibujarIconoO()
	jr $ra
	
mostrarIconoP:
	dibujarIconoP()
	jr $ra
	
#Función que compara si la primer letra ingresada corresponda a una que está en el rango de la a y la p, y muestra su respectivo icono
comparar:
	beq  $v0,$s0, mostrarIconoA
	beq  $v0,$s1, mostrarIconoB
	beq  $v0,$sp, mostrarIconoC
	beq  $v0,$gp, mostrarIconoD
	beq  $v0,$t6, mostrarIconoE
	beq  $v0,$t7, mostrarIconoF
	beq  $v0,$t8, mostrarIconoG
	beq  $v0,$t9, mostrarIconoH
	beq  $v0,$s3, mostrarIconoI
	beq  $v0,$s4, mostrarIconoJ
	beq  $v0,$s5, mostrarIconoK
	beq  $v0,$s6, mostrarIconoL
	beq  $v0,$s7, mostrarIconoM
	beq  $v0,$k0, mostrarIconoN
	beq  $v0,$k1, mostrarIconoO
	beq  $v0,$s2, mostrarIconoP
     	jr $ra

#Función que se salga a una segunda comparación para ver si las dos letras ingresadas son parejas
acierto:
        beq  $s0,$a2, segundaComparacion1
        beq  $a2,$s1, segundaComparacion2
	beq  $a2,$sp, segundaComparacion3
	beq  $a2,$gp, segundaComparacion4
	beq  $a2,$t6, segundaComparacion5
	beq  $a2,$t7, segundaComparacion6
	beq  $a2,$t8, segundaComparacion7
	beq  $a2,$t9, segundaComparacion8
	beq  $a2,$s3, segundaComparacion9
	beq  $a2,$s4, segundaComparacion10
	beq  $a2,$s5, segundaComparacion11
	beq  $a2,$s6, segundaComparacion12
	beq  $a2,$s7, segundaComparacion13
	beq  $a2,$k0, segundaComparacion14
	beq  $a2,$k1, segundaComparacion15
	beq  $a2,$s2, segundaComparacion16
        jr $ra
	
#Desde la segundaComparacion1 hasta la segundaComparacion16 mira si las dos letras son parejas o no, y de acuerdo
#a esto o muestra un mensaje de acierto, o disminuye el contador de intentos y tapa las letras correspondientes
segundaComparacion1:
        beq  $sp,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal tapara
        jal taparletra
        jal while
        
segundaComparacion2:
        beq  $t7,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparb
        jal taparletra
        jal while
        
segundaComparacion3:
        beq  $s0,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
        jal taparc
        jal taparletra
        jal while  
             
segundaComparacion4:
        beq  $s7,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal tapard
        jal taparletra
        jal while
        
segundaComparacion5:
        beq  $t9,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal tapare
        jal taparletra
        jal while
        
segundaComparacion6:
        beq  $s1,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparf
        jal taparletra
        jal while
        
segundaComparacion7:
        beq  $s4,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparg
        jal taparletra
        jal while
        
segundaComparacion8:
        beq  $t6,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparh
        jal taparletra
        jal while
        
segundaComparacion9:
        beq  $s2,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal tapari
        jal taparletra
        jal while
        
segundaComparacion10:
        beq  $t8,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparj
        jal taparletra
        jal while 
        
segundaComparacion11:
        beq  $k1,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal tapark
        jal taparletra
        jal while
        
segundaComparacion12:
        beq  $k0,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparl
        jal taparletra
        jal while
        
segundaComparacion13:
        beq  $gp,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparm
        jal taparletra
        jal while
        
segundaComparacion14:
        beq  $s6,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparn
        jal taparletra
        jal while
        
segundaComparacion15:
        beq  $s5,$a3, msAcierto
        imprimirMensaje( msjError )
	li $v0, 12
	syscall
	jal contadorIntentos
        jal taparo
        jal taparletra
        jal while
        
segundaComparacion16:
        beq  $3,$a3, msAcierto
        imprimirMensaje( msjError )
        li $v0, 12
	syscall
	jal contadorIntentos
        jal taparp
        jal taparletra
        jal while
        
#Muestra un mensaje de acierto y aumenta el contador de parejas correctas en 1
msAcierto:
      imprimirMensaje( msjacierto )
      sub $a1,$a1,1
      jal while

#Función que realiza las direntes verificaciones de las leras para taparles cuando no son pareja
taparletra:
        beq  $s0,$a3, tapara
        beq  $a3,$s1, taparb
	beq  $a3,$sp, taparc
	beq  $a3,$gp, tapard
	beq  $a3,$t6, tapare
	beq  $a3,$t7, taparf
	beq  $a3,$t8, taparg
	beq  $a3,$t9, taparh
	beq  $a3,$s3, tapari
	beq  $a3,$s4, taparj
	beq  $a3,$s5, tapark
	beq  $a3,$s6, taparl
	beq  $a3,$s7, taparm
	beq  $a3,$k0, taparn
	beq  $a3,$k1, taparo
	beq  $a3,$s2, taparp      
     	jr $ra

 #Desde tapara a taparap dibuja un cuadro y la respectiva letra, simulando que se ha tapado la ficha 
tapara:
        dibujarCuadrado( 1, 2, 15, 13, BURGUNDY )
        dibujarLetraA()
      	jr $ra
      	
taparb:
        dibujarCuadrado( 17, 2, 15, 13, BURGUNDY )
        dibujarLetraB()
      	jr $ra
      	
taparc:
	dibujarCuadrado( 33, 2, 15, 13, BURGUNDY )
        dibujarLetraC()
      	jr $ra
      	
tapard:
	dibujarCuadrado( 49, 2, 15, 13, BURGUNDY )
        dibujarLetraD()
      	jr $ra
      	
tapare:
	dibujarCuadrado( 1, 18, 31, 13, BURGUNDY )
        dibujarLetraE()
      	jr $ra
      	
taparf:
	dibujarCuadrado( 17, 18,31, 13, BURGUNDY )
        dibujarLetraF()
     	 jr $ra
     	 
taparg:
	dibujarCuadrado( 33, 18, 31, 13, BURGUNDY )
        dibujarLetraG()
      	jr $ra
      	
taparh:
	dibujarCuadrado( 49, 18, 31, 13, BURGUNDY )
        dibujarLetraH()
      	jr $ra
      	
tapari:
	dibujarCuadrado( 1, 34, 47, 13, BURGUNDY )
        dibujarLetraI()
      	jr $ra
      	
taparj:
	dibujarCuadrado( 17, 34, 47, 13, BURGUNDY )
        dibujarLetraJ()
      	jr $ra
      	
tapark:
	dibujarCuadrado( 33, 34, 47, 13, BURGUNDY )
        dibujarLetraK()
      	jr $ra     
      	
taparl:
	dibujarCuadrado( 49, 34, 47, 13, BURGUNDY )
        dibujarLetraL()
      	jr $ra
      	
taparm:
	dibujarCuadrado( 1, 50, 63, 13, BURGUNDY )
        dibujarLetraM()
      	jr $ra
      	
taparn:
	dibujarCuadrado( 17, 50, 63, 13, BURGUNDY )
        dibujarLetraN()
     	 jr $ra
     	 
taparo:
	dibujarCuadrado( 33, 50, 63, 13, BURGUNDY )
        dibujarLetraO()
      	jr $ra
      	
taparp:
	dibujarCuadrado( 49, 50, 63, 13, BURGUNDY )
        dibujarLetraP()
      	jr $ra
#Función que termina por completo el juego     
fin:	
	li $v0, 10
	syscall
	
#Desde verificarVolteaa hasta verificarVoleap, se toman dos coordenadas arbitrarias de cada letra, y se verifica si
#el color que está allí es igual al color original del tablero, si es así, significa que la ficha no está volteada y 
#si no, significa que la ficha está volteada y salta a la función novolteada	                                                                                                                                                         
verificarVolteaa:
        add $t0, $zero, 5
	add $t1, $zero, 5
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteab:
        add $t0, $zero,19 
	add $t1, $zero, 4
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteac:
        add $t0, $zero,35 
	add $t1, $zero, 4
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVoltead:
        add $t0, $zero,50 
	add $t1, $zero, 4
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteae:
        add $t0, $zero,2 
	add $t1, $zero, 19
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteaf:
        add $t0, $zero,18 
	add $t1, $zero, 19
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteag:
        add $t0, $zero,34 
	add $t1, $zero, 20
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteah:
        add $t0, $zero,50
	add $t1, $zero, 20
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteai:
        add $t0, $zero,2 
	add $t1, $zero, 36
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteaj:
        add $t0, $zero,18 
	add $t1, $zero, 35
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteak:
        add $t0, $zero,34
	add $t1, $zero, 35
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteal:
        add $t0, $zero,50 
	add $t1, $zero, 35
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteam:
        add $t0, $zero,2 
	add $t1, $zero, 51
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVoltean:
        add $t0, $zero,18
	add $t1, $zero, 51
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteao:
        add $t0, $zero,34 
	add $t1, $zero, 51
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0,BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
verificarVolteap:
        add $t0, $zero,50 
	add $t1, $zero, 51
	li $t2, DIR_BASE
	sll $t0, $t0, 2
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t0, BURGUNDY
	lw $t1,0($t2)
	bne  $t1,$t0, novolteada
	jr $ra
	
novolteada:
       beq $t3, 1, novolteada2
       imprimirMensaje( msjVoltea )
       jal while
       
novolteada2:
       imprimirMensaje( msjVoltea )
       jal continua


verificarVoltea1:
        beq  $s0,$v0, verificarVolteaa
        beq  $v0,$s1, verificarVolteab
       	beq  $v0,$sp, verificarVolteac
	beq  $v0,$gp, verificarVoltead
	beq  $v0,$t6, verificarVolteae
	beq  $v0,$t7, verificarVolteaf
	beq  $v0,$t8, verificarVolteag
	beq  $v0,$t9, verificarVolteah
	beq  $v0,$s3, verificarVolteai
	beq  $v0,$s4, verificarVolteaj
	beq  $v0,$s5, verificarVolteak
	beq  $v0,$s6, verificarVolteal
	beq  $v0,$s7, verificarVolteam
	beq  $v0,$k0, verificarVoltean
	beq  $v0,$k1, verificarVolteao
	beq  $v0,$s2, verificarVolteap
        jr $ra

