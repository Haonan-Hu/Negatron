.data
.globl	main
gbl_a:	.quad 0
.align 8

.text

fun_fn:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$8, %rsp
				movq	0(%rbp), %rax
				movq	$99, %rbx
				subq %rbx, %rax
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rdi
				callq printInt
lbl_0: 	addq $8, %rsp
				popq %rbp
				retq
main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$16, %rsp
				movq	$99, %rax
				movq	$90, %rbx
				subq %rbx, %rax
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fn
				addq $8, %rsp
lbl_1: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
