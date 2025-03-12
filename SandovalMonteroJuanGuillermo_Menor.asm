.data
mensaje_pedir_cant: .asciiz "Ingrese la cantidad de números (3-5): "
mensaje_pedir_num: .asciiz "Ingrese un número: "
mensaje_resultado: .asciiz "El número menor es: "

.text
.globl main

main:
    # Pedir la cantidad de números
    li $v0, 4
    la $a0, mensaje_pedir_cant
    syscall
    
    li $v0, 5  # Leer número entero
    syscall
    move $t0, $v0  # Guardar la cantidad de números en $t0
    
    # Verificar que la cantidad esté en el rango (3-5)
    li $t1, 3
    li $t2, 5
    blt $t0, $t1, salir
    bgt $t0, $t2, salir
    
    # Inicializar contador y menor
    li $t3, 0  # Contador
    li $t4, 2147483647  # Inicializar el número menor con el mayor valor posible
    
    loop:
        # Pedir un número
        li $v0, 4
        la $a0, mensaje_pedir_num
        syscall
        
        li $v0, 5  # Leer número entero
        syscall
        move $t5, $v0  # Guardar número ingresado
        
        # Comparar con el número menor actual
        blt $t5, $t4, actualizar_menor
        j siguiente
        
    actualizar_menor:
        move $t4, $t5  # Actualizar número menor
        
    siguiente:
        addi $t3, $t3, 1  # Incrementar contador
        blt $t3, $t0, loop  # Repetir hasta completar la cantidad de números
    
    # Mostrar resultado
    li $v0, 4
    la $a0, mensaje_resultado
    syscall
    
    li $v0, 1
    move $a0, $t4  # Mostrar el número menor
    syscall
    
    salir:
    li $v0, 10  # Salir del programa
    syscall
