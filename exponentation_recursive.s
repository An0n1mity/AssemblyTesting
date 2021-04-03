#function exponentiate(x, n) {
#    if(n == 0) {
#        return 1;
#    } else {
#        return x * exponentiate(x, n - 1);
#    }
#}

#16(%rbp) contient la valeur de retour de expo
#%ecx contient la base

.section .text
.globl _start
.type expo, @function

_start:
	push $2
	push $3
	call expo
	addq $16, %rsp
	mov %rax, %rbx
	movq $1, %rax
	int $0x80		

expo:
	push %rbp
	mov %rsp, %rbp
	subq $24, %rsp

	movl 16(%rbp), %eax
	movl 24(%rbp), %ecx
	cmpl $0, %eax
	je go

	decl %eax
	push %rcx
	push %rax
	call expo
	
	imul %rcx, %rax
	mov %rax, 16(%rbp)
return:
	mov %rbp, %rsp
	pop %rbp
	ret

go:
	movq $1, %rax
	jmp return
