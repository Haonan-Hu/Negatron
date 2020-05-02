.data
.globl	main
gbl_global:	.quad 0
gbl_myBool:	.quad 0
str_3: 	.asciz "\n"
str_2: 	.asciz "\n"
str_0: 	.asciz "\n"
str_1: 	.asciz "The 20th term of the series is: "
.align 8

.text

fun_fib:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$56, %rsp
				movq	0(%rbp), %rax
				movq	$1, %rbx
				cmpq %rbx, %rax
				setle %al
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rax
				cmpq $1, %rax
				jne lbl_1
				movq	0(%rbp), %rax
				jmp lbl_0
lbl_1: nop
				movq	0(%rbp), %rax
				movq	$1, %rbx
				subq %rbx, %rax
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -40(%rbp)
				movq	0(%rbp), %rax
				movq	$2, %rbx
				subq %rbx, %rax
				movq	%rax, -48(%rbp)
				movq	-48(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -56(%rbp)
				movq	-56(%rbp), %rax
				imulq $-1, %rax
				movq	%rax, -64(%rbp)
				movq	-40(%rbp), %rax
				movq	-64(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -72(%rbp)
				movq	-72(%rbp), %rax
				jmp lbl_0
lbl_0: 	addq $56, %rsp
				popq %rbp
				retq
fun_fn:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$24, %rsp
				movq	0(%rbp), %rax
				imulq $-1, %rax
				movq	%rax, -24(%rbp)
				movq	8(%rbp), %rax
				movq	-24(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				movq	%rax, gbl_global
				movq	8(%rbp), %rax
				movq	0(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -40(%rbp)
				movq	-40(%rbp), %rax
				jmp lbl_2
lbl_2: 	addq $24, %rsp
				popq %rbp
				retq
fun_recursive:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$32, %rsp
lbl_4: nop
				movq	8(%rbp), %rax
				cmpq $1, %rax
				jne lbl_5
				movq	0(%rbp), %rax
				imulq $-1, %rax
				movq	%rax, -24(%rbp)
				movq	16(%rbp), %rax
				movq	-24(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rdi
				callq printInt
				movq	16(%rbp), %rax
				movq	$1, %rbx
				subq %rbx, %rax
				movq	%rax, 16(%rbp)
				movq	16(%rbp), %rax
				movq	$0, %rbx
				cmpq %rbx, %rax
				setle %al
				movq	%rax, -40(%rbp)
				movq	-40(%rbp), %rax
				cmpq $1, %rax
				jne lbl_6
				movq	$0, %rax
				movq	%rax, 8(%rbp)
				jmp lbl_7
lbl_6: nop
				movq	16(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -48(%rbp)
				movq	-48(%rbp), %rdi
				callq printInt
lbl_7: nop
				jmp lbl_4
lbl_5: nop
lbl_3: 	addq $32, %rsp
				popq %rbp
				retq
fun_b:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$88, %rsp
				movq	0(%rbp), %rax
				movq	$2, %rbx
				idivq %rbx
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rax
				movq	$4, %rbx
				imulq %rbx
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				movq	$2, %rbx
				subq %rbx, %rax
				movq	%rax, -40(%rbp)
				movq	-40(%rbp), %rax
				movq	$10, %rbx
				cmpq %rbx, %rax
				setl %al
				movq	%rax, -48(%rbp)
				movq	-48(%rbp), %rax
				cmpq $1, %rax
				jne lbl_9
				movq	$0, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -56(%rbp)
				movq	-56(%rbp), %rax
				jmp lbl_8
				jmp lbl_10
lbl_9: nop
				movq	$0, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -64(%rbp)
				movq	-64(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -72(%rbp)
				movq	-72(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -80(%rbp)
				movq	-80(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -88(%rbp)
				movq	$1, %rax
				movq	$0, %rbx
				cmpq %rbx, %rax
				setl %al
				movq	%rax, -96(%rbp)
				movq	-88(%rbp), %rax
				movq	-96(%rbp), %rbx
				andq %rbx, %rax
				movq	%rax, -104(%rbp)
				movq	-104(%rbp), %rax
				jmp lbl_8
lbl_10: nop
lbl_8: 	addq $88, %rsp
				popq %rbp
				retq
main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$72, %rsp
				movq	$6, %rax
				movq	%rax, -24(%rbp)
lbl_12: nop
				movq	-24(%rbp), %rax
				movq	$0, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				cmpq $1, %rax
				jne lbl_13
				movq	-24(%rbp), %rdi
				callq printInt
				movq	-24(%rbp), %rax
				movq	$1, %rbx
				subq %rbx, %rax
				movq	%rax, -24(%rbp)
				jmp lbl_12
lbl_13: nop
				movq	$str_0, %rdi
				callq printString
				movq	$3, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				movq	$7, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fn
				addq $16, %rsp
				movq	%rax, -40(%rbp)
				movq	-40(%rbp), %rdi
				callq printInt
				movq	$str_1, %rdi
				callq printString
				movq	$20, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -48(%rbp)
				movq	-48(%rbp), %rdi
				callq printInt
				movq	$str_2, %rdi
				callq printString
				movq	$5, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				movq	$0, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -56(%rbp)
				movq	$0, %rax
				movq	-56(%rbp), %rbx
				orq %rbx, %rax
				movq	%rax, -64(%rbp)
				movq	-64(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				movq	$3, %rax
				movq	-24(%rbp), %rbx
				imulq %rbx
				movq	%rax, -72(%rbp)
				movq	-72(%rbp), %rax
				movq	$12, %rbx
				subq %rbx, %rax
				movq	%rax, -80(%rbp)
				movq	-80(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_recursive
				addq $24, %rsp
				movq	$str_3, %rdi
				callq printString
				movq	gbl_global, %rdi
				callq printInt
				movq	$8, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_b
				addq $8, %rsp
				movq	%rax, -88(%rbp)
				movq	-88(%rbp), %rax
				movq	%rax, gbl_myBool
lbl_11: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
