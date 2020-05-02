.data
.globl	main
.align 8

.text

main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$16, %rsp
				movq	$6, %rax
				movq	%rax, -24(%rbp)
lbl_1: nop
				movq	-24(%rbp), %rax
				movq	$0, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				cmpq $1, %rax
				jne lbl_2
				movq	-24(%rbp), %rdi
				callq printInt
				movq	-24(%rbp), %rax
				movq	$1, %rbx
				subq %rbx, %rax
				movq	%rax, -24(%rbp)
				jmp lbl_1
lbl_2: nop
lbl_0: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
