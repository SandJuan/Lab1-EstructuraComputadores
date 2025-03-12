.data
mensaje_pedir_cant: .asciiz "Ingrese la cantidad de n�meros (3-5): "
mensaje_pedir_num: .asciiz "Ingrese un n�mero: "
mensaje_resultado: .asciiz "El n�mero mayor es: "

.text
.globl main

main:
    # Pedir la cantidad de n�meros
    li $v0, 4
    la $a0, mensaje_pedir_cant
    syscall
    
    li $v0, 5  # Leer n�mero entero
    syscall
    move $t0, $v0  # Guardar la cantidad de n�meros en $t0
    
    # Verificar que la cantidad est� en el rango (3-5)
    li $t1, 3
    li $t2, 5
    blt $t0, $t1, salir
    bgt $t0, $t2, salir
    
    # Inicializar contador y mayor
    li $t3, 0  # Contador
    li $t4, -2147483648  # Inicializar el n�mero mayor con el menor valor posible
    
    loop:
        # Pedir un n�mero
        li $v0, 4
        la $a0, mensaje_pedir_num
        syscall
        
        li $v0, 5  # Leer n�mero entero
        syscall
        move $t5, $v0  # Guardar n�mero ingresado
        
        # Comparar con el n�mero mayor actual
        bgt $t5, $t4, actualizar_mayor
        j siguiente
        
    actualizar_mayor:
        move $t4, $t5  # Actualizar n�mero mayor
        
    siguiente:
        addi $t3, $t3, 1  # Incrementar contador
        blt $t3, $t0, loop  # Repetir hasta completar la cantidad de n�meros
    
    # Mostrar resultado
    li $v0, 4
    la $a0, mensaje_resultado
    syscall
    
    li $v0, 1
    move $a0, $t4  # Mostrar el n�mero mayor
    syscall
    
    salir:
    li $v0, 10  # Salir del programa
    syscall
