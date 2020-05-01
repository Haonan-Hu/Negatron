.data
.globl	main
gbl_a:	.quad 0
.align 8

.text

main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$0, %rsp
				callq getInt
				movq	%rdx, gbl_a
				movq	gbl_a, %rdx
				callq printInt
lbl_0: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
