#Macros segundo parcial (Juego de memoria)
#Colores: 0x00RRGGBB

	.eqv DIR_BASE 0x10000000	
	.eqv ROJO 0x00FF0000
	.eqv AZUL_CLARO 0x000080FF
	.eqv MEDIUM_BLUE 0x000000CD
	.eqv BURGUNDY 0x00800000
	.eqv BLANCO 0x00FFFFFF
	.eqv PIEL 0x00FAD295
	.eqv ROSA 0x00F95BB2
	.eqv CAFE 0x00A76320
	.eqv NEGRO 0x00050505
	.eqv AMARILLO 0x00FFFF00
	.eqv VERDE 0x00FF00


.macro imprimirMensaje( %mensaje )
	li $v0, 4
	la $a0, %mensaje
	syscall
.end_macro		
	
		
.macro dibujarPunto( %x, %y, %color )
	add $t0, $zero, %x
	add $t1, $zero, %y
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1	
	li $t0, %color
	sw  $t0, 0($t2) 
.end_macro


.macro dibujarLineasVerticales( %x, %yi, %yf, %color )
	add $t3, $zero, %yi	
loopLineaV:
	dibujarPunto( %x, $t3, %color )
	addi $t3, $t3, 1
	ble $t3, %yf, loopLineaV
.end_macro


.macro dibujarLineasHorizontales( %y, %xi, %xf, %color)
	add $t3, $zero, %xi	
loopLineaH:
	dibujarPunto( $t3, %y, %color )
	addi $t3, $t3, 1
	ble $t3, %xf, loopLineaH
.end_macro


.macro dibujarNombre( )
	#Dibujar lineas verticales de la primer letra M
	dibujarLineasVerticales( 18, 4, 13, NEGRO )
	dibujarLineasVerticales( 20, 4, 11, NEGRO )
	dibujarLineasVerticales( 22, 4, 11, NEGRO )
	dibujarLineasVerticales( 24, 4, 13, NEGRO )
	#Dibujar linea vertical de la letra E
	dibujarLineasVerticales( 26, 4, 13, NEGRO )
	#Dibujar lineas verticales de la segunda letra M
	dibujarLineasVerticales( 34, 4, 13, NEGRO )
	dibujarLineasVerticales( 36, 4, 11, NEGRO )
	dibujarLineasVerticales( 38, 4, 11, NEGRO )
	dibujarLineasVerticales( 40, 4, 13, NEGRO )
	#Dibujar lineas verticales de la letra y
	dibujarLineasVerticales( 42, 4, 8, NEGRO )
	dibujarLineasVerticales( 48, 4, 13, NEGRO )
	
	#Dibujar lineas horizontales de la primer letra M
	dibujarLineasHorizontales( 4, 18, 20, NEGRO )
	dibujarLineasHorizontales( 11, 20, 22, NEGRO )
	dibujarLineasHorizontales( 4, 22, 24, NEGRO )
	#Dibujar lineas horizontales de la letra E
	dibujarLineasHorizontales( 4, 26, 32, NEGRO )
	dibujarLineasHorizontales( 8, 26, 31,NEGRO )
	dibujarLineasHorizontales( 13, 26, 32,NEGRO )
	#Dibujar lineas horizontales de la segunda letra M
	dibujarLineasHorizontales( 4, 34, 36, NEGRO )
	dibujarLineasHorizontales( 11, 36, 38, NEGRO )
	dibujarLineasHorizontales( 4, 38, 40, NEGRO )
	#Dibujar lineas horizontales de la letra y
	dibujarLineasHorizontales( 8, 42, 48, NEGRO )
	dibujarLineasHorizontales( 13, 43, 48, NEGRO )
.end_macro 


.macro dibujarIcono( )
	#Dibujar lineas verticales
	dibujarLineasVerticales( 18, 21, 56, NEGRO )
	dibujarLineasVerticales( 33, 21, 56, NEGRO )
	dibujarLineasVerticales( 48, 21, 56, NEGRO )
	#Dibujar lineas horizontales
	dibujarLineasHorizontales( 20, 18, 48, NEGRO )
	dibujarLineasHorizontales( 32, 18, 48, NEGRO )
	dibujarLineasHorizontales( 42, 18, 48, NEGRO )
	dibujarLineasHorizontales( 56, 18, 48, NEGRO )
	
	#Dibuja primer cuadrado
	dibujarLineasVerticales( 25, 48, 50, BLANCO )
	dibujarLineasVerticales( 26, 48, 50, BLANCO )
	dibujarLineasVerticales( 27, 48, 50, BLANCO )
	#Dibuja segundo cuadrado
	dibujarLineasVerticales( 39, 48, 50, BLANCO )
	dibujarLineasVerticales( 40, 48, 50, BLANCO )
	dibujarLineasVerticales( 41, 48, 50, BLANCO )
	#Dibuja tercer cuadrado
	dibujarLineasVerticales( 39, 36, 38, BLANCO )
	dibujarLineasVerticales( 40, 36, 38, BLANCO )
	dibujarLineasVerticales( 41, 36, 38, BLANCO )
.end_macro 


.macro dibujarTablero()
#Dibuja primer cuadrado fila uno
	dibujarCuadrado( 1, 2, 15, 13, BURGUNDY )
#Dibuja segundo cuadrado fila uno
	dibujarCuadrado( 17, 2, 15, 13, BURGUNDY )
#Dibuja tercer cuadrado fila uno
	dibujarCuadrado( 33, 2, 15, 13, BURGUNDY )
#Dibuja cuarto cuadrado fila uno
	dibujarCuadrado( 49, 2, 15, 13, BURGUNDY )
	
#Dibuja primer cuadrado fila dos
	dibujarCuadrado( 1, 18, 31, 13, BURGUNDY )
#Dibuja segundo cuadrado fila dos
	dibujarCuadrado( 17, 18,31, 13, BURGUNDY )
#Dibuja tercer cuadrado fila dos
	dibujarCuadrado( 33, 18, 31, 13, BURGUNDY )
#Dibuja cuarto cuadrado fila dos
	dibujarCuadrado( 49, 18, 31, 13, BURGUNDY )
	
#Dibuja primer cuadrado fila tres
	dibujarCuadrado( 1, 34, 47, 13, BURGUNDY )
#Dibuja segundo cuadrado fila tres
	dibujarCuadrado( 17, 34, 47, 13, BURGUNDY )
#Dibuja tercer cuadrado fila tres
	dibujarCuadrado( 33, 34, 47, 13, BURGUNDY )
#Dibuja cuarto cuadrado fila tres
	dibujarCuadrado( 49, 34, 47, 13, BURGUNDY )
	
#Dibuja primer cuadrado fila cuatro
	dibujarCuadrado( 1, 50, 63, 13, BURGUNDY )
#Dibuja segundo cuadrado fila cuatro
	dibujarCuadrado( 17, 50, 63, 13, BURGUNDY )
#Dibuja tercer cuadrado fila cuatro
	dibujarCuadrado( 33, 50, 63, 13, BURGUNDY )
#Dibuja cuarto cuadrado fila cuatro
	dibujarCuadrado( 49, 50, 63, 13, BURGUNDY )
.end_macro 


.macro dibujarCuadrado( %x, %yi, %yf, %tam, %color )
	add $t4, $zero, %x
	add $t5, $t4, %tam
loopCuadrado:
	dibujarLineasVerticales( $t4, %yi, %yf, BURGUNDY )
	addi $t4, $t4, 1
	ble $t4, $t5, loopCuadrado
.end_macro 


.macro dibujarCuadradoIcono( %x, %yi, %yf, %tam, %color )
	add $t4, $zero, %x
	add $t5, $t4, %tam
loopCuadrado:
	dibujarLineasVerticales( $t4, %yi, %yf, NEGRO )
	addi $t4, $t4, 1
	ble $t4, $t5, loopCuadrado
.end_macro 


.macro dibujarLetras( )
#Dibujar las lineas verticales desde la a hasta la p
	dibujarLineasVerticales( 5, 8, 11, BLANCO )
	dibujarLineasVerticales( 9, 5, 11, BLANCO )
	dibujarLineasVerticales( 21, 5, 11, BLANCO )
	dibujarLineasVerticales( 26, 8, 11, BLANCO )
	dibujarLineasVerticales( 37, 5, 11, BLANCO )
	dibujarLineasVerticales( 5, 21, 28, BLANCO )
	dibujarLineasVerticales( 10, 21, 24, BLANCO )
	dibujarLineasVerticales( 21, 21, 28, BLANCO )
	dibujarLineasVerticales( 37, 21, 24, BLANCO )
	dibujarLineasVerticales( 42, 21, 28, BLANCO )
	dibujarLineasVerticales( 58, 5, 11, BLANCO )
	dibujarLineasVerticales( 53, 8, 11, BLANCO )
	dibujarLineasVerticales( 53, 21, 28, BLANCO )
	dibujarLineasVerticales( 58, 24, 28, BLANCO )
	dibujarLineasVerticales( 7, 39, 43, BLANCO )
	dibujarLineasVerticales( 23, 39, 43, BLANCO )
	dibujarLineasVerticales( 21, 42, 43, BLANCO )
	dibujarLineasVerticales( 38, 37, 43, BLANCO )
	dibujarLineasVerticales( 55, 37, 43, BLANCO )
	dibujarLineasVerticales( 5, 53, 59, BLANCO )
	dibujarLineasVerticales( 7, 53, 59, BLANCO )
	dibujarLineasVerticales( 9, 53, 59, BLANCO )
	dibujarLineasVerticales( 22, 53, 59, BLANCO )
	dibujarLineasVerticales( 25, 53, 59, BLANCO )
	dibujarLineasVerticales( 37, 53, 60, BLANCO )
	dibujarLineasVerticales( 42, 53, 60, BLANCO )
	dibujarLineasVerticales( 53, 53, 60, BLANCO )
	dibujarLineasVerticales( 58, 53, 56, BLANCO )
	
#Dibujar las lineas horizontales desde la a hasta la p	
	dibujarLineasHorizontales( 5, 6, 9, BLANCO )
	dibujarLineasHorizontales( 8, 5, 9, BLANCO )
	dibujarLineasHorizontales( 11, 5, 9, BLANCO )
	dibujarLineasHorizontales( 8, 21, 26, BLANCO )
	dibujarLineasHorizontales( 11, 21, 26, BLANCO )
	dibujarLineasHorizontales( 5, 37, 42, BLANCO )
	dibujarLineasHorizontales( 11, 37, 42, BLANCO )
	dibujarLineasHorizontales( 8, 53, 58, BLANCO )
	dibujarLineasHorizontales( 11, 53, 58, BLANCO )
	dibujarLineasHorizontales( 21, 5, 10, BLANCO )
	dibujarLineasHorizontales( 24, 5, 10, BLANCO )
	dibujarLineasHorizontales( 28, 5, 10, BLANCO )
	dibujarLineasHorizontales( 21, 21, 26, BLANCO )
	dibujarLineasHorizontales( 24, 21, 26, BLANCO )
	dibujarLineasHorizontales( 21, 37, 42, BLANCO )
	dibujarLineasHorizontales( 24, 37, 42, BLANCO )
	dibujarLineasHorizontales( 28, 37, 42, BLANCO )
	dibujarLineasHorizontales( 24, 53, 58, BLANCO )
	dibujarLineasHorizontales( 43, 21, 23, BLANCO )
	dibujarLineasHorizontales( 53, 5, 9, BLANCO )
	dibujarLineasHorizontales( 53, 22, 25, BLANCO )
	dibujarLineasHorizontales( 53, 37, 42, BLANCO )
	dibujarLineasHorizontales( 60, 37, 42, BLANCO )
	dibujarLineasHorizontales( 53, 53, 58, BLANCO )
	dibujarLineasHorizontales( 56, 53, 58, BLANCO )

#Dibuja los puntos de las letras i, j y k	
	dibujarPunto( 7, 37, BLANCO )
	dibujarPunto( 23, 37, BLANCO )
	dibujarPunto( 39, 41, BLANCO )
	dibujarPunto( 40, 40, BLANCO )
	dibujarPunto( 41, 39, BLANCO )
	dibujarPunto( 40, 42, BLANCO )
	dibujarPunto( 41, 43, BLANCO )
.end_macro


.macro dibujarLetraA()
	dibujarLineasVerticales( 5, 8, 11, BLANCO )
	dibujarLineasVerticales( 9, 5, 11, BLANCO )
	dibujarLineasHorizontales( 5, 6, 9, BLANCO )
	dibujarLineasHorizontales( 8, 5, 9, BLANCO )
	dibujarLineasHorizontales( 11, 5, 9, BLANCO )
.end_macro


.macro dibujarLetraB()
	dibujarLineasVerticales( 21, 5, 11, BLANCO )
	dibujarLineasVerticales( 26, 8, 11, BLANCO )
	dibujarLineasHorizontales( 8, 21, 26, BLANCO )
	dibujarLineasHorizontales( 11, 21, 26, BLANCO )
.end_macro


.macro dibujarLetraC()
	dibujarLineasVerticales( 37, 5, 11, BLANCO )
	dibujarLineasHorizontales( 5, 37, 42, BLANCO )
	dibujarLineasHorizontales( 11, 37, 42, BLANCO )
.end_macro


.macro dibujarLetraD()
	dibujarLineasVerticales( 58, 5, 11, BLANCO )
	dibujarLineasVerticales( 53, 8, 11, BLANCO )
	dibujarLineasHorizontales( 8, 53, 58, BLANCO )
	dibujarLineasHorizontales( 11, 53, 58, BLANCO )
.end_macro


.macro dibujarLetraE()
	dibujarLineasVerticales( 5, 21, 28, BLANCO )
	dibujarLineasVerticales( 10, 21, 24, BLANCO )
	dibujarLineasHorizontales( 21, 5, 10, BLANCO )
	dibujarLineasHorizontales( 24, 5, 10, BLANCO )
	dibujarLineasHorizontales( 28, 5, 10, BLANCO )
.end_macro


.macro dibujarLetraF()
	dibujarLineasVerticales( 21, 21, 28, BLANCO )
	dibujarLineasHorizontales( 21, 21, 26, BLANCO )
	dibujarLineasHorizontales( 24, 21, 26, BLANCO )
.end_macro


.macro dibujarLetraG()
	dibujarLineasVerticales( 37, 21, 24, BLANCO )
	dibujarLineasVerticales( 42, 21, 28, BLANCO )
	dibujarLineasHorizontales( 21, 37, 42, BLANCO )
	dibujarLineasHorizontales( 24, 37, 42, BLANCO )
	dibujarLineasHorizontales( 28, 37, 42, BLANCO )
.end_macro


.macro dibujarLetraH()
	dibujarLineasVerticales( 53, 21, 28, BLANCO )
	dibujarLineasVerticales( 58, 24, 28, BLANCO )
	dibujarLineasHorizontales( 24, 53, 58, BLANCO )
.end_macro


.macro dibujarLetraI()
	dibujarLineasVerticales( 7, 39, 43, BLANCO )
.end_macro


.macro dibujarLetraJ()
	dibujarLineasVerticales( 23, 39, 43, BLANCO )
	dibujarLineasVerticales( 21, 42, 43, BLANCO )
	dibujarLineasHorizontales( 43, 21, 23, BLANCO )
.end_macro


.macro dibujarLetraK()
	dibujarLineasVerticales( 38, 37, 43, BLANCO )
.end_macro


.macro dibujarLetraL()
	dibujarLineasVerticales( 55, 37, 43, BLANCO )
.end_macro


.macro dibujarLetraM()
	dibujarLineasVerticales( 5, 53, 59, BLANCO )
	dibujarLineasVerticales( 7, 53, 59, BLANCO )
	dibujarLineasVerticales( 9, 53, 59, BLANCO )
	dibujarLineasHorizontales( 53, 5, 9, BLANCO )
.end_macro


.macro dibujarLetraN()
	dibujarLineasVerticales( 22, 53, 59, BLANCO )
	dibujarLineasVerticales( 25, 53, 59, BLANCO )
	dibujarLineasHorizontales( 53, 22, 25, BLANCO )
.end_macro


.macro dibujarLetraO()
	dibujarLineasVerticales( 37, 53, 60, BLANCO )
	dibujarLineasVerticales( 42, 53, 60, BLANCO )
	dibujarLineasHorizontales( 53, 37, 42, BLANCO )
	dibujarLineasHorizontales( 60, 37, 42, BLANCO )
.end_macro


.macro dibujarLetraP()
	dibujarLineasVerticales( 53, 53, 60, BLANCO )
	dibujarLineasVerticales( 58, 53, 56, BLANCO )
	dibujarLineasHorizontales( 53, 53, 58, BLANCO )
	dibujarLineasHorizontales( 56, 53, 58, BLANCO )
.end_macro


.macro dibujarIconoA( )
	dibujarCuadradoIcono( 1, 2, 15, 13, NEGRO )
	dibujarLineasVerticales( 7, 6, 11, VERDE )
	dibujarLineasHorizontales( 8, 5, 9, VERDE )
.end_macro


.macro dibujarIconoB( )
	dibujarCuadradoIcono( 17, 2, 15, 13, NEGRO )
	dibujarLineasHorizontales( 9, 21, 27, VERDE )
.end_macro


.macro dibujarIconoC( )
	dibujarCuadradoIcono( 33, 2, 15, 13, NEGRO )
        dibujarLineasVerticales( 39, 6, 11, VERDE )
	dibujarLineasHorizontales( 8, 37, 41, VERDE )
.end_macro


.macro dibujarIconoD( )
	dibujarCuadradoIcono( 49, 2, 15, 13, NEGRO )
        dibujarLineasVerticales( 54, 7, 12, VERDE )
        dibujarLineasVerticales( 56, 7, 12, VERDE )
.end_macro


.macro dibujarIconoE( )
	dibujarCuadradoIcono( 1, 18, 31, 13, NEGRO )
	dibujarLineasHorizontales( 23, 5, 10, VERDE )
	dibujarLineasHorizontales( 26, 5, 10, VERDE )
.end_macro


.macro dibujarIconoF( )
	dibujarCuadradoIcono( 17, 18,31, 13, NEGRO )
	dibujarLineasHorizontales( 25, 21, 27, VERDE )
.end_macro


.macro dibujarIconoG( )
	dibujarCuadradoIcono( 33, 18, 31, 13, NEGRO )
	dibujarLineasHorizontales( 24, 39, 40, VERDE )
	dibujarLineasHorizontales( 25, 39, 40, VERDE )
.end_macro


.macro dibujarIconoH( )
	dibujarCuadradoIcono( 49, 18, 31, 13, NEGRO )
	dibujarLineasHorizontales( 23, 54, 60, VERDE )
	dibujarLineasHorizontales( 26, 54, 60, VERDE )
.end_macro


.macro dibujarIconoI( )
	dibujarCuadradoIcono( 1, 34, 47, 13, NEGRO )
	dibujarLineasHorizontales( 40, 5, 10, VERDE )
	dibujarLineasHorizontales( 43, 5, 10, VERDE )
	dibujarLineasVerticales( 6, 38, 45, VERDE )
        dibujarLineasVerticales( 9, 38, 45, VERDE )
.end_macro


.macro dibujarIconoJ( )
	dibujarCuadradoIcono( 17, 34, 47, 13, NEGRO )
	dibujarLineasHorizontales( 40, 23, 24, VERDE )
	dibujarLineasHorizontales( 41, 23, 24, VERDE )
	
.end_macro


.macro dibujarIconoK( )
	dibujarCuadradoIcono( 33, 34, 47, 13, NEGRO )
	dibujarLineasVerticales( 39, 37, 42, VERDE )
	dibujarLineasVerticales( 39, 44, 44, VERDE )
	
.end_macro


.macro dibujarIconoL( )
	dibujarCuadradoIcono( 49, 34, 47, 13, NEGRO )
	dibujarLineasHorizontales( 40, 54, 58, VERDE )
	dibujarLineasHorizontales( 44, 54, 58, VERDE )
	dibujarLineasVerticales( 54, 40, 44, VERDE )
        dibujarLineasVerticales( 58, 40, 44, VERDE )
	
.end_macro


.macro dibujarIconoM( )
	dibujarCuadradoIcono( 1, 50, 63, 13, NEGRO )
	dibujarLineasVerticales( 6, 55, 61, VERDE )
        dibujarLineasVerticales( 8, 55, 61, VERDE )
.end_macro


.macro dibujarIconoN( )
	dibujarCuadradoIcono( 17, 50, 63, 13, NEGRO )
	dibujarLineasHorizontales( 55, 22, 26, VERDE )
	dibujarLineasHorizontales( 59, 22, 26, VERDE )
	dibujarLineasVerticales( 22, 55, 59, VERDE )
        dibujarLineasVerticales( 26, 55, 59, VERDE )
.end_macro


.macro dibujarIconoO( )
	dibujarCuadradoIcono( 33, 50, 63, 13, NEGRO )
	dibujarLineasVerticales( 39, 54, 60, VERDE )
	dibujarLineasVerticales( 39, 62, 62, VERDE )
	
.end_macro


.macro dibujarIconoP( )
	dibujarCuadradoIcono( 49, 50, 63, 13, NEGRO )
	dibujarLineasHorizontales( 55, 52, 58, VERDE )
	dibujarLineasHorizontales( 57, 52, 58, VERDE )
	dibujarLineasVerticales( 54, 53, 59, VERDE )
        dibujarLineasVerticales( 56, 53, 59, VERDE )
.end_macro

#Macro que borra toda lo que hay en pantalla y la pone en el color determinado
.macro borrar(%color)
	li $t0, DIR_BASE
	li $t1, %color
	li $t2, 0	
loopBorrar:
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t2, $t2, 1	
	ble $t2, 4095, loopBorrar
.end_macro


#Macro que muestra una cara triste :( en la pantalla con fondo rojo, mostrando que el usuario ha perdido
.macro perder( %color )
	li $t0, DIR_BASE
	li $t1, %color
	li $t2, 0	
loopBorrar:
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t2, $t2, 1	
	ble $t2, 4095, loopBorrar
#Dibuja la cara triste mediante lineas verticales y horizontales
dibujarLineasVerticales( 17, 15, 20, BLANCO )	
dibujarLineasVerticales( 18, 15, 20, BLANCO )	
dibujarLineasVerticales( 19, 15, 20, BLANCO )	
dibujarLineasVerticales( 20, 15, 20, BLANCO )	
dibujarLineasVerticales( 21, 15, 20, BLANCO )	
dibujarLineasVerticales( 22, 15, 20, BLANCO )	
dibujarLineasVerticales( 23, 15, 20, BLANCO )	
dibujarLineasVerticales( 24, 15, 20, BLANCO )	
dibujarLineasVerticales( 37, 15, 20, BLANCO )	
dibujarLineasVerticales( 38, 15, 20, BLANCO )	
dibujarLineasVerticales( 39, 15, 20, BLANCO )	
dibujarLineasVerticales( 40, 15, 20, BLANCO )	
dibujarLineasVerticales( 41, 15, 20, BLANCO )	
dibujarLineasVerticales( 42, 15, 20, BLANCO )	
dibujarLineasVerticales( 43, 15, 20, BLANCO )	
dibujarLineasVerticales( 44, 15, 20, BLANCO )	
dibujarLineasVerticales( 17, 32, 43, BLANCO )	
dibujarLineasVerticales( 18, 32, 43, BLANCO )	
dibujarLineasVerticales( 19, 32, 43, BLANCO )	
dibujarLineasVerticales( 20, 32, 43, BLANCO )	
dibujarLineasVerticales( 21, 32, 43, BLANCO )	
dibujarLineasVerticales( 22, 32, 34, BLANCO )	
dibujarLineasVerticales( 23, 32, 34, BLANCO )	
dibujarLineasVerticales( 24, 32, 34, BLANCO )	
dibujarLineasVerticales( 25, 32, 34, BLANCO )	
dibujarLineasVerticales( 26, 32, 34, BLANCO )	
dibujarLineasVerticales( 27, 32, 34, BLANCO )	
dibujarLineasVerticales( 28, 32, 34, BLANCO )	
dibujarLineasVerticales( 29, 32, 34, BLANCO )	
dibujarLineasVerticales( 30, 32, 34, BLANCO )	
dibujarLineasVerticales( 31, 32, 34, BLANCO )	
dibujarLineasVerticales( 32, 32, 34, BLANCO )	
dibujarLineasVerticales( 33, 32, 34, BLANCO )	
dibujarLineasVerticales( 34, 32, 34, BLANCO )	
dibujarLineasVerticales( 35, 32, 34, BLANCO )	
dibujarLineasVerticales( 36, 32, 34, BLANCO )	
dibujarLineasVerticales( 37, 32, 34, BLANCO )	
dibujarLineasVerticales( 38, 32, 34, BLANCO )	
dibujarLineasVerticales( 39, 32, 34, BLANCO )	
dibujarLineasVerticales( 40, 32, 43, BLANCO )	
dibujarLineasVerticales( 41, 32, 43, BLANCO )	
dibujarLineasVerticales( 42, 32, 43, BLANCO )
dibujarLineasVerticales( 43, 32, 43, BLANCO )	
dibujarLineasVerticales( 44, 32, 43, BLANCO )	
.end_macro

#Macro que muestra una cara feliz :) en la pantalla con fondo verde, mostrando que el usuario ha ganado
.macro ganar( %color )
	li $t0, DIR_BASE
	li $t1, %color
	li $t2, 0	
loopBorrar:
	sw $t1, 0($t0)
	addi $t0, $t0, 4
	addi $t2, $t2, 1	
	ble $t2, 4095, loopBorrar
#Dibuja la cara feliz mediante lineas horizontales y verticales
dibujarLineasVerticales( 17, 15, 20, BLANCO )	
dibujarLineasVerticales( 18, 15, 20, BLANCO )	
dibujarLineasVerticales( 19, 15, 20, BLANCO )	
dibujarLineasVerticales( 20, 15, 20, BLANCO )	
dibujarLineasVerticales( 21, 15, 20, BLANCO )	
dibujarLineasVerticales( 22, 15, 20, BLANCO )	
dibujarLineasVerticales( 23, 15, 20, BLANCO )	
dibujarLineasVerticales( 24, 15, 20, BLANCO )	
dibujarLineasVerticales( 37, 15, 20, BLANCO )	
dibujarLineasVerticales( 38, 15, 20, BLANCO )	
dibujarLineasVerticales( 39, 15, 20, BLANCO )	
dibujarLineasVerticales( 40, 15, 20, BLANCO )	
dibujarLineasVerticales( 41, 15, 20, BLANCO )	
dibujarLineasVerticales( 42, 15, 20, BLANCO )	
dibujarLineasVerticales( 43, 15, 20, BLANCO )	
dibujarLineasVerticales( 44, 15, 20, BLANCO )	
dibujarLineasVerticales( 17, 32, 43, BLANCO )	
dibujarLineasVerticales( 18, 32, 43, BLANCO )	
dibujarLineasVerticales( 19, 32, 43, BLANCO )	
dibujarLineasVerticales( 20, 32, 43, BLANCO )	
dibujarLineasVerticales( 21, 32, 43, BLANCO )	
dibujarLineasHorizontales(40, 17, 44, BLANCO )
dibujarLineasHorizontales(41, 17, 44, BLANCO )
dibujarLineasHorizontales(42, 17, 44, BLANCO )
dibujarLineasHorizontales(43, 17, 44, BLANCO )
dibujarLineasVerticales( 40, 32, 43, BLANCO )	
dibujarLineasVerticales( 41, 32, 43, BLANCO )	
dibujarLineasVerticales( 42, 32, 43, BLANCO )
dibujarLineasVerticales( 43, 32, 43, BLANCO )	
dibujarLineasVerticales( 44, 32, 43, BLANCO )		
.end_macro


#Macro que revisa si la carta está volteada mediante la comparación de colores en un pixel específico
.macro volteada( %x, %y )
       imprimirMensaje( msjBienvenida )
        add $t0, $zero, %x
	add $t1, $zero, %y
	li $t2, DIR_BASE
	sll $t0, $t0, 2	
	sll $t1, $t1, 8 
	add $t2, $t2, $t0	
	add $t2, $t2, $t1
	li $t4,BURGUNDY
	lw $t6,0($t2)
	bne  $t6,$t4, novolteada
	jal fin
novolteada:
       jal fin
fin:
.end_macro
