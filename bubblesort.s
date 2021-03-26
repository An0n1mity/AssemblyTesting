.section .data
array:
	.int 5, 4, 8, 9, 10, 1, 0

.section .text

.globl _start

_start:
	movl $0, %ecx
	second_loop:
		incl %ecx		
		//Set l'index a 0
		movl $0, %edi
		//Deplace le premier element du tableau dans le registre ebx
		movl array(,%edi,4), %ebx
		cmpl $2, %ecx
		je exit
	//Premiere boucle du tri
	first_loop:
		//Check pour voir si on est à la fin du tableau
		cmpl $0, %ebx
		je second_loop
		//Incremente l'index
		incl %edi
		//Stock le prochain element du tableau dans le registre eax
		movl array(,%edi,4), %eax
		//Si element actuel plus petit que celui d'avant
		cmpl %ebx, %eax
		//Effectuer un swap des valeurs
		jl switch_start
		jmp switch_end
		switch_start:
			movl %ebx, array(,%edi,4)
			decl %edi
			movl %eax, array(,%edi,4)
			incl %edi
			jmp first_loop
		switch_end:
			movl array(,%edi,4), %ebx
	
	exit:
		movl $0, %ebx
		movl $1, %eax
		int $0x80	
			
