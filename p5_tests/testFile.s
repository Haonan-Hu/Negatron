.data
.globl	main
str_1: 	.asciz "\n"
str_0: 	.asciz "The 20th term of the series is: "
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
main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$8, %rsp
				movq	$str_0, %rdi
				callq printString
				movq	$20, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rdi
				callq printInt
				movq	$str_1, %rdi
				callq printString
				movq	$0, %rax
				jmp lbl_2
lbl_2: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
