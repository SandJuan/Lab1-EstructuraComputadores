.data
mensaje_pedir: .asciiz "Ingrese cuántos términos de Fibonacci desea generar: "
mensaje_resultado: .asciiz "La serie de Fibonacci es: "
mensaje_suma: .asciiz "\nLa suma de los términos es: "

.text
.globl main

main:
    # Pedir al usuario la cantidad de términos
    li $v0, 4
    la $a0, mensaje_pedir
    syscall
    
    li $v0, 5  # Leer número entero
    syscall
    move $t0, $v0  # Guardar cantidad de términos
    
    # Verificar que el número sea mayor que 0
    blez $t0, salir
    
    # Mostrar mensaje inicial
    li $v0, 4
    la $a0, mensaje_resultado
    syscall
    
    # Inicializar los dos primeros números de la serie
    li $t1, 0  # Primer número de Fibonacci
    li $t2, 1  # Segundo número de Fibonacci
    li $t3, 0  # Contador
    li $t4, 0  # Suma total de la serie
    
    loop:
        # Imprimir el número actual de la serie
        li $v0, 1
        move $a0, $t1
        syscall
        
        # Imprimir un espacio
        li $v0, 11
        li $a0, ' '
        syscall
        
        # Sumar al total
        add $t4, $t4, $t1
        
        # Calcular el siguiente número de Fibonacci
        add $t5, $t1, $t2  # t5 = t1 + t2
        move $t1, $t2  # Actualizar t1 (ahora es el valor de t2)
        move $t2, $t5  # Actualizar t2 (nuevo número de Fibonacci)
        
        # Incrementar contador
        addi $t3, $t3, 1
        blt $t3, $t0, loop  # Repetir hasta completar la cantidad de términos
    
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
