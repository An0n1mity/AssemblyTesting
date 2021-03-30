.section .data
	array:
		.int 7, 6, 8, 5, 4
	array_size:
		.int 5
	i:
		.int 0
	j:
		.int 0
	min_idx:
		.int 0
.section .text
.globl _start
_start:
	first_loop:
	#Condition d'arret
	movl i, %eax
	movl array_size, %ebx
	decl %ebx
	cmpl %ebx, %eax
	je exit
	        movl i, %eax	
		movl %eax, min_idx
		incl %eax
		movl %eax, j		
		second_loop:
		#Condition d'arret
		movl j, %eax
		movl array_size, %ebx
		cmpl %ebx, %eax
		je swap
		
			#if(arr[j] < arr[min_idx]
			movl j, %edi
			movl array(,%edi,4), %eax #%eax = arr[j]
			movl min_idx, %edi
			movl array(,%edi,4), %ebx #%ebx = arr[min_idx]
			cmpl %ebx, %eax
			jl change
			jmp change_end
			
			change:
				movl j, %eax
				movl %eax, min_idx
			change_end:

		incl j
		jmp second_loop
		swap:
			movl i, %edi
			movl array(,%edi,4), %eax
			lea array(,%edi,4), %ecx
			movl min_idx, %edi
			movl array(,%edi,4), %ebx
			movl %ebx, (%ecx)
			lea array(,%edi,4), %ecx
			movl %eax, (%ecx)			

	incl i
	jmp first_loop
exit:
	movl $1, %eax
	int $0x80
	
