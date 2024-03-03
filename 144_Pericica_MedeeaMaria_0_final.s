.data
	n: .space 5000
	x: .space 5000
	format_citire: .asciz "%d"
	format_afisare: .asciz "%d "
	format_afisare1: .asciz "%d"
	nr: .long 0
	v: .space 50000
    	matrice: .space 50000
    	leg: .space 1001
    	var1: .space 10000
    	var2: .space 10000
    	linie_noua: .asciz "\n"
    	dublu: .space 50000
    	m1: .space 50000
    	m2: .space 50000
    	mres: .space 50000
    	sursa: .space 500
    	destinatie: .space 500
    	lungime: .space 1000
    	cerinta: .space 101
    	format_linie: .asciz "\n"
    
.text
.globl main

matrix_mult:
	push %ebp
	mov %esp, %ebp
	
	subl $20, %esp
	
	mov $-1, %ebx
	mov $-1, %ecx
	mov $-1, %edx
	
	for_1:
		incl %ebx
		
		cmp 20(%ebp), %ebx
		je iesire
		
		mov $-1, %ecx
	
	for_2:
		incl %ecx
		
		cmp 20(%ebp), %ecx
		je for_1
		
		mov $-1, %edx
		
	for_3:
		incl %edx
		
		cmp 20(%ebp), %edx
		je for_2
		
		mov %edx, -20(%ebp)
		mov 8(%ebp), %esi 
		mov 20(%ebp), %eax
		mul %ebx
		mov -20(%ebp), %edx
		addl %edx, %eax
		
		
		mov (%esi, %eax, 4), %eax
		mov %eax, -4(%ebp)
		
		mov %edx, -20(%ebp)
		mov 12(%ebp), %esi
		mov 20(%ebp), %eax
		mul %edx
		mov -20(%ebp), %edx
		addl %ecx, %eax
		
		mov (%esi, %eax, 4), %eax
		mov %eax, -8(%ebp) 
		
		mov %edx, -20(%ebp)
		mov -4(%ebp), %eax
		mull -8(%ebp) 
		mov -20(%ebp), %edx
		mov %eax, -12(%ebp) 
		
		
		mov %edx, -20(%ebp)
		mov 16(%ebp), %esi
		mov 20(%ebp), %eax
		mul %ebx
		mov -20(%ebp), %edx
		addl %ecx, %eax
		
		mov (%esi, %eax, 4), %eax 
		add %eax, -12(%ebp) 
		
		
		mov %edx, -20(%ebp)
		mov 16(%ebp), %esi
		mov 20(%ebp), %eax
		mul %ebx
		mov -20(%ebp), %edx
		addl %ecx, %eax
		
		mov %ebx, -16(%ebp)
		mov -12(%ebp), %ebx
		mov  %ebx, (%esi, %eax, 4)
		mov -16(%ebp), %ebx
		
		jmp for_3
		
		
	iesire:
		mov 16(%ebp), %esi
		addl $20, %esp
		pop %ebp
		ret
		
main:
	push $cerinta
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx

	cmpl $2, cerinta
	je main_2
	
main_1:
	push $n
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	mov $0, %ecx
	movl $0, nr
	mov $v, %esi
	mov $matrice, %edi
	
formare_vector_1:
	cmp n, %ecx
	je incrementari_1
	
	push $x
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	mov x, %eax
	mov nr, %edx
	mov %eax, (%esi, %edx, 4)
	
	incl nr
	mov nr, %ecx
	jmp formare_vector_1

incrementari_1:
	mov $0, %eax
	mov $0, %ebx
	mov $0, %ecx

for_1_1:
	cmp n, %eax
	je incrementare_1_2
	
	mov (%esi, %eax, 4), %ebx
	mov %ebx, leg
	mov $0, %ecx
for_1_2:
	cmp leg, %ecx
	je incrementare_1
	
	mov %eax, var1
	mov %ecx, var2
	
	push $x
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	mov n, %ebx
	mov var1, %eax
	mul %ebx
	addl x, %eax
	movl $1, (%edi, %eax, 4)
	
	mov var1, %eax
	mov var2, %ecx
	
	incl %ecx
	jmp for_1_2

incrementare_1:
	incl %eax
	jmp for_1_1

incrementare_1_2:
	mov n, %eax
	mull n
	mov %eax, dublu
	mov $0, %ecx
	mov $0, %edx

afisare_matrice:
	cmp dublu, %ecx
	je et_exit
	
	cmp n, %edx
	je linie_noua1
	
	mov %ecx, var1
	mov %edx, var2
	mov (%edi, %ecx, 4), %ebx
	
	push %ebx
	push $format_afisare
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	mov var1, %ecx
	mov var2, %edx
	incl %ecx
	incl %edx
	jmp afisare_matrice

linie_noua1:
	mov %ecx, var1
	
	push $format_linie
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	mov var1, %ecx
	mov $0, %edx
	
	jmp afisare_matrice
	
main_2:
	push $n
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	mov $0, %ecx
	movl $0, nr
	mov $v, %esi
	mov $matrice, %edi
	
formare_vector:
	cmp n, %ecx
	je incrementari
	
	push $x
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	mov x, %eax
	mov nr, %edx
	mov %eax, (%esi, %edx, 4)
	
	incl nr
	mov nr, %ecx
	jmp formare_vector

incrementari:
	mov $0, %eax
	mov $0, %ebx
	mov $0, %ecx

creare_for_1:
	cmp n, %eax
	je incrementare_2
	
	mov (%esi, %eax, 4), %ebx
	mov %ebx, leg
	mov $0, %ecx
	
creare_for_2:
	cmp leg, %ecx
	je incrementare
	
	mov %eax, var1
	mov %ecx, var2
	
	push $x
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	mov n, %ebx
	mov var1, %eax
	mul %ebx
	addl x, %eax
	movl $1, (%edi, %eax, 4)
	
	mov var1, %eax
	mov var2, %ecx
	
	incl %ecx
	jmp creare_for_2

incrementare:
	incl %eax
	jmp creare_for_1

incrementare_2:
	mov n, %eax
	mull n
	mov %eax, dublu
	mov $0, %ecx
	mov $0, %edx

citire_continuare:
	push $lungime
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	push $sursa
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	push $destinatie
	push $format_citire
	call scanf
	pop %ebx
	pop %ebx
	
	subl $1, lungime
	
continuare:
	mov $0, %eax
	mov $0, %ebx
	mov $0, %ecx

copiere_vector:
	cmp dublu, %ecx
	je cont
	
	mov $matrice, %esi
	mov (%esi, %ecx, 4), %ebx
	mov $m1, %esi
	mov %ebx, (%esi, %ecx, 4)
	mov $m2, %esi
	mov %ebx, (%esi, %ecx, 4)
	
	incl %ecx
	jmp copiere_vector

cont:
	mov $0, %eax
	
inmultire_matrici:

	cmp lungime, %eax
	je incrementare_3
	
	mov %eax, var1
	mov $0, %ecx
	
initializare:
	cmp dublu, %ecx
	je apelare
	
	mov $mres, %esi
	movl $0, (%esi, %ecx, 4)
	incl %ecx
	jmp initializare

apelare:
	push n
	push $mres
	push $m2
	push $m1
	call matrix_mult
	pop %ebx
	pop %ebx
	pop %ebx
	pop %ebx
	
	mov var1, %eax
	incl %eax
	mov $0, %ecx

copiere_vectori:
	cmp dublu, %ecx
	je inmultire_matrici
	
	mov $mres, %esi
	mov (%esi, %ecx, 4), %ebx
	mov $m2, %esi
	mov %ebx, (%esi, %ecx, 4)
	incl %ecx
	jmp copiere_vectori
	
	
incrementare_3:
	mov $0, %ecx
	mov $0, %edx
	mov $mres, %esi

	
afisare_drumuri:
	mov sursa, %eax
	mov destinatie, %ebx
	mull n
	add %ebx, %eax 
	
	mov $mres, %esi
	mov (%esi, %eax, 4), %ebx
	
	push %ebx
	push $format_afisare1
	call printf
	pop %ebx
	pop %ebx
	
	pushl $0
	call fflush
	popl %ebx
	jmp et_exit1

et_exit:
	push $format_linie
	call printf
	pop %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	mov $1, %eax
	mov $0, %ebx
	int $0x80

et_exit1:
	mov $1, %eax
	mov $0, %ebx
	int $0x80


