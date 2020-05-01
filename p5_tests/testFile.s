.data
.globl	main
gbl_a:	.quad 0
str_0: 	.asciz "hit"
.align 8

.text

main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$8, %rsp
				movq	$1, %rax
				movq	$2, %rbx
				cmpq %rbx, %rax
				setl %al
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rax
				cmpq $1, %rax
				jne lbl_1
				movq	$str_0, %rdi
				callq printString
lbl_1: nop
				movq	$0, %rax
				jmp lbl_0
lbl_0:
				movq	%rax, %rdi
				movq $60, %rax
				syscall
