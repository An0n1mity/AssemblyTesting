
#int recurSum(int n)
#{
#    if (n <= 1)
#        return n;
#   return n + recurSum(n - 1);
#}

.section .text
.globl _start
.type sum, @function

_start:
	push $3
	call sum
	add $16, %rsp
	mov %eax, %ebx
	mov $1, %rax
	int $0x80	

sum:
	push %rbp
	mov %rsp, %rbp
	subq $16, %rsp

	movl 16(%rbp), %eax
	cmpl $1, %eax
	je return 
	
	decl %eax
	push %rax
	call sum

	movl 16(%rbp), %ebx
	addl %ebx, %eax
	return:
		mov %rbp, %rsp
		pop %rbp
		ret
