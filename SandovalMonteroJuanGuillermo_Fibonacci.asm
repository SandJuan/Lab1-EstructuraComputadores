.data
mensaje_pedir: .asciiz "Ingrese cu�ntos t�rminos de Fibonacci desea generar: "
mensaje_resultado: .asciiz "La serie de Fibonacci es: "
mensaje_suma: .asciiz "\nLa suma de los t�rminos es: "

.text
.globl main

main:
    # Pedir al usuario la cantidad de t�rminos
    li $v0, 4
    la $a0, mensaje_pedir
    syscall
    
    li $v0, 5  # Leer n�mero entero
    syscall
    move $t0, $v0  # Guardar cantidad de t�rminos
    
    # Verificar que el n�mero sea mayor que 0
    blez $t0, salir
    
    # Mostrar mensaje inicial
    li $v0, 4
    la $a0, mensaje_resultado
    syscall
    
    # Inicializar los dos primeros n�meros de la serie
    li $t1, 0  # Primer n�mero de Fibonacci
    li $t2, 1  # Segundo n�mero de Fibonacci
    li $t3, 0  # Contador
    li $t4, 0  # Suma total de la serie
    
    loop:
        # Imprimir el n�mero actual de la serie
        li $v0, 1
        move $a0, $t1
        syscall
        
        # Imprimir un espacio
        li $v0, 11
        li $a0, ' '
        syscall
        
        # Sumar al total
        add $t4, $t4, $t1
        
        # Calcular el siguiente n�mero de Fibonacci
        add $t5, $t1, $t2  # t5 = t1 + t2
        move $t1, $t2  # Actualizar t1 (ahora es el valor de t2)
        move $t2, $t5  # Actualizar t2 (nuevo n�mero de Fibonacci)
        
        # Incrementar contador
        addi $t3, $t3, 1
        blt $t3, $t0, loop  # Repetir hasta completar la cantidad de t�rminos
    
    # Imprimir la suma de la serie
    li $v0, 4
    la $a0, mensaje_suma
    syscall
    
    li $v0, 1
    move $a0, $t4
    syscall
    
    # Salir del programa
    salir:
    li $v0, 10
    syscall
