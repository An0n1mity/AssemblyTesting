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

.globl _start

_start:
	first_loop:
		#for(int i = 0; i < n; i++)
		movl i, %eax
		movl size_array, %ebx
		decl %ebx
		cmpl %ebx, %eax
		je exit 		
		#for(int j = 0; j < size_array-i; j++)
		movl $0, j
		second_loop:
			movl j, %eax
			movl size_array, %ebx
			subl i, %ebx
			decl %ebx
			cmpl %ebx, %eax	
			je second_loop_end
			
			#if(arr[j] > arr[j+1])
			movl j, %edi
			movl array(,%edi,4), %eax #%eax = arr[j]
			incl %edi
			cmpl array(,%edi,4), %eax #cmp %eax, arr[j+1]
			jg switch
			jmp switch_end
			switch:
				movl array(,%edi,4), %eax #eax = arr[j+1]
				decl %edi
				lea array(,%edi,4), %ecx #ecx = &arr[j]
				movl array(,%edi,4), %ebx #ebx = arr[j]
				movl %eax, (%ecx) #arr[j] = arr[j+1]
				incl %edi
				lea array(,%edi,4), %ecx #ecx = &arr[j+1]
				movl %ebx, (%ecx) #arr[j+1] = arr[j]
			switch_end:
			incl j
			jmp second_loop
		second_loop_end:
			incl i
			jmp first_loop
			
	exit:
		movl $1, %eax
		int $0x80	
			
