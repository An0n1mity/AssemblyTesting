.section .data
array:
	.int 5, 4, 8, 9, 10, 1, 0
size_array:
	.int 7
i:
	.int 0
j: 
	.int 0

.section .text
.type BubbleSort, @function

.globl _start

_start:
	lea array, %rcx
	mov size_array, %rdx
	push %rcx 
	push %rdx
	call BubbleSort
	add $8, %rsp
	jmp exit

#Arguments : Adresse du tableau = 24(%rbp) , taille du tableau = 16(%rbp)
#Variable Locales : i = -8(%rbp), j = -16(%rbp)
#%rbx, %rax contiendra les valeurs du tableau
#%rdi, %rdx les valeurs des variables locale
BubbleSort:
	pushq %rbp
	movq %rsp, %rbp
	sub $16, %rsp

	movq $0, -8(%rbp) #i = 0
	mov 24(%rbp), %rsi
	first_loop:
		#for(int i = 0; i < n; i++)
		movl -8(%rbp), %edi #edi = i
		movl 16(%rbp), %edx #edx = size
		dec %edx #ebx = size - 1
		cmp %edx, %edi 
		je return 		
		#for(int j = 0; j < size_array-i-1; j++)
		movl $0, -16(%rbp) #j = 0 
		second_loop:
			movl -16(%rbp), %edi #edi = j
			movl 16(%rbp), %edx #edx = size
			subl -8(%rbp), %edx #edx = size-i
			dec %edx #edx = size-i-1
			cmp %edx, %edi	
			je second_loop_end
			
			#if(arr[j] > arr[j+1]) 
			movl 24(%rbp), %ecx 
			movl (%ecx), %eax #%eax = arr[j]
			addl $4, 24(%rbp)
			movl 24(%rbp), %ecx
			movl (%ecx), %ebx
			cmp %ebx, %eax #cmp arr[i], arr[j+1]
			jg switch
			jmp switch_end
			switch:
				movl (%ecx), %ebx #%ebx = arr[j+1]
				movl %eax, (%ecx) #arr[j+1] = arr[j]
				subl $4, 24(%rbp)
				movl 24(%rbp), %ecx
				movl %ebx, (%ecx) #arr[j] = arr[j+1]  
			switch_end:
			incl -16(%rbp) #j++
			jmp second_loop
		second_loop_end:
			incl -8(%rbp) #i++
			mov %rsi, 24(%rbp)
			jmp first_loop
			
	return:
		mov %rbp, %rsp
		pop %rbp
		ret	
		
exit:
	movq $1, %rax
	int $0x80	
