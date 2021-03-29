//Algorihtme du tri insertion :
#pour j <- 2 a longueur[A]
#	faire cle <- A[j]
#		Insere A[j] dans la sequence trie A[1..j-1]
#		i <- j - 1
#		tant que i > 0 et A[i] > clé
#			faire A[i+1] <- A[i]
#				i <- i - 1
#			A[i + 1] <- cle 

///

.section .data
	array:
		.int 7, 4, 5, 3, 9, 6
	j:
		.int 0
	i:
		.int 1
	array_size:
		.int 6
	key:
		.int 0

.section .text
.globl _start

_start:
	first_loop:
		#Si i == taille tableau 
		movl i, %eax
		cmpl array_size, %eax
		#Fin du tri insertion
		je exit
		
		#Clé = A[i]
		movl i, %edi
		movl array(,%edi,4), %eax
		movl %eax, key
		#j = i - 1
		movl i, %eax
		decl %eax
		movl %eax, j
		#while(j>=0 && array[j] > key)
		while:
			#Condition d'arret du while
			movl j, %ebx
			movl $0, %eax
			cmpl %eax, %ebx
			jl end_while
			movl j, %edi 
			movl array(,%edi,4), %eax
			cmpl key, %eax
			jl end_while
			#Executer dans le while
			#arr[j+1] = arr[j]
			movl array(,%edi, 4), %eax
			incl %edi
			lea array(,%edi, 4), %ecx
			movl %eax, (%ecx)
			decl j
			jmp while 
		end_while:
			movl j, %edi
			incl %edi
			movl key, %ebx 
			lea array(,%edi,4), %ecx
			movl %ebx, (%ecx)
			incl i
			jmp first_loop
exit:
	movl $1, %eax
	int $0x80
	
	
