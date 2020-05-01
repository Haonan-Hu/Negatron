.data
.globl	main
gbl_a:	.quad 0
.align 8

.text

main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$8, %rsp
				movq	$50, %rax
				movq	$2, %rbx
				subq %rbx, %rax
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rdi
				callq printInt
lbl_0: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
