.data
.globl	main
gbl_global:	.quad 0
gbl_myBool:	.quad 0
str_7: 	.asciz "\n"
str_8: 	.asciz "\n"
str_6: 	.asciz "The 20th term of the series is: "
str_1: 	.asciz "FizzBuzz"
str_0: 	.asciz "\n"
str_2: 	.asciz "Fizz"
str_4: 	.asciz "\n"
str_3: 	.asciz "Buzz"
str_5: 	.asciz "\n"
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
fun_fizzbuzz:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$192, %rsp
				movq	$str_0, %rdi
				callq printString
				movq	$0, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -56(%rbp)
				movq	-56(%rbp), %rax
				movq	%rax, -24(%rbp)
				movq	$0, %rax
				movq	%rax, -32(%rbp)
				movq	$0, %rax
				movq	%rax, -40(%rbp)
				movq	$1, %rax
				movq	%rax, -48(%rbp)
lbl_4: nop
				movq	-48(%rbp), %rax
				movq	$100, %rbx
				cmpq %rbx, %rax
				setle %al
				movq	%rax, -64(%rbp)
				movq	-64(%rbp), %rax
				cmpq $1, %rax
				jne lbl_5
				movq	$1, %rax
				imulq $-1, %rax
				movq	%rax, -72(%rbp)
				movq	-32(%rbp), %rax
				movq	-72(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -80(%rbp)
				movq	-80(%rbp), %rax
				movq	%rax, -32(%rbp)
				movq	$1, %rax
				imulq $-1, %rax
				movq	%rax, -88(%rbp)
				movq	-40(%rbp), %rax
				movq	-88(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -96(%rbp)
				movq	-96(%rbp), %rax
				movq	%rax, -40(%rbp)
				movq	-32(%rbp), %rax
				movq	$3, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -104(%rbp)
				movq	-104(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -112(%rbp)
				movq	-40(%rbp), %rax
				movq	$5, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -120(%rbp)
				movq	-120(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -128(%rbp)
				movq	-112(%rbp), %rax
				movq	-128(%rbp), %rbx
				andq %rbx, %rax
				movq	%rax, -136(%rbp)
				movq	-136(%rbp), %rax
				cmpq $1, %rax
				jne lbl_6
				movq	$str_1, %rdi
				callq printString
				movq	$0, %rax
				movq	%rax, -32(%rbp)
				movq	$0, %rax
				movq	%rax, -40(%rbp)
				movq	$0, %rax
				movq	%rax, -24(%rbp)
lbl_6: nop
				movq	-32(%rbp), %rax
				movq	$3, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -144(%rbp)
				movq	-144(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -152(%rbp)
				movq	-152(%rbp), %rax
				movq	-24(%rbp), %rbx
				andq %rbx, %rax
				movq	%rax, -160(%rbp)
				movq	-160(%rbp), %rax
				cmpq $1, %rax
				jne lbl_7
				movq	$str_2, %rdi
				callq printString
				movq	$0, %rax
				movq	%rax, -32(%rbp)
				movq	$0, %rax
				movq	%rax, -24(%rbp)
lbl_7: nop
				movq	-40(%rbp), %rax
				movq	$5, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -168(%rbp)
				movq	-168(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -176(%rbp)
				movq	-176(%rbp), %rax
				movq	-24(%rbp), %rbx
				andq %rbx, %rax
				movq	%rax, -184(%rbp)
				movq	-184(%rbp), %rax
				cmpq $1, %rax
				jne lbl_8
				movq	$str_3, %rdi
				callq printString
				movq	$0, %rax
				movq	%rax, -40(%rbp)
				movq	$0, %rax
				movq	%rax, -24(%rbp)
lbl_8: nop
				movq	-24(%rbp), %rax
				cmpq $1, %rax
				jne lbl_9
				movq	-48(%rbp), %rdi
				callq printInt
lbl_9: nop
				movq	$0, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -192(%rbp)
				movq	-192(%rbp), %rax
				movq	%rax, -24(%rbp)
				movq	$1, %rax
				imulq $-1, %rax
				movq	%rax, -200(%rbp)
				movq	-48(%rbp), %rax
				movq	-200(%rbp), %rbx
				subq %rbx, %rax
				movq	%rax, -208(%rbp)
				movq	-208(%rbp), %rax
				movq	%rax, -48(%rbp)
				movq	$str_4, %rdi
				callq printString
				jmp lbl_4
lbl_5: nop
lbl_3: 	addq $192, %rsp
				popq %rbp
				retq
fun_whileLoop:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$32, %rsp
lbl_11: nop
				movq	8(%rbp), %rax
				cmpq $1, %rax
				jne lbl_12
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
				jne lbl_13
				movq	$0, %rax
				movq	%rax, 8(%rbp)
				jmp lbl_14
lbl_13: nop
				movq	16(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -48(%rbp)
				movq	-48(%rbp), %rdi
				callq printInt
lbl_14: nop
				jmp lbl_11
lbl_12: nop
lbl_10: 	addq $32, %rsp
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
				jne lbl_16
				movq	$0, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -56(%rbp)
				movq	-56(%rbp), %rax
				jmp lbl_15
				jmp lbl_17
lbl_16: nop
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
				jmp lbl_15
lbl_17: nop
lbl_15: 	addq $88, %rsp
				popq %rbp
				retq
fun_rec:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$24, %rsp
				movq	0(%rbp), %rax
				movq	$0, %rbx
				cmpq %rbx, %rax
				setl %al
				movq	%rax, -24(%rbp)
				movq	-24(%rbp), %rax
				cmpq $1, %rax
				jne lbl_19
				movq	0(%rbp), %rax
				jmp lbl_18
lbl_19: nop
				movq	0(%rbp), %rax
				movq	$1, %rbx
				subq %rbx, %rax
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_rec
				addq $8, %rsp
lbl_18: 	addq $24, %rsp
				popq %rbp
				retq
main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$96, %rsp
				movq	$6, %rax
				movq	%rax, -24(%rbp)
lbl_21: nop
				movq	-24(%rbp), %rax
				movq	$0, %rbx
				cmpq %rbx, %rax
				setne %al
				movq	%rax, -32(%rbp)
				movq	-32(%rbp), %rax
				cmpq $1, %rax
				jne lbl_22
				movq	-24(%rbp), %rdi
				callq printInt
				movq	-24(%rbp), %rax
				movq	$1, %rbx
				subq %rbx, %rax
				movq	%rax, -24(%rbp)
				jmp lbl_21
lbl_22: nop
				movq	$str_5, %rdi
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
				movq	$str_6, %rdi
				callq printString
				movq	$20, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_fib
				addq $8, %rsp
				movq	%rax, -48(%rbp)
				movq	-48(%rbp), %rdi
				callq printInt
				movq	$str_7, %rdi
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
				callq fun_whileLoop
				addq $24, %rsp
				movq	$str_8, %rdi
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
				movq	gbl_myBool, %rdi
				callq printInt
				movq	gbl_myBool, %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -96(%rbp)
				movq	-96(%rbp), %rdi
				callq printInt
				movq	$12, %rax
				subq $8, %rsp
				movq %rax, (%rsp)
				callq fun_b
				addq $8, %rsp
				movq	%rax, -104(%rbp)
				movq	-104(%rbp), %rax
				cmpq $1, %rax
				setne %al
				movq	%rax, -112(%rbp)
				movq	-112(%rbp), %rdi
				callq printInt
				callq fun_fizzbuzz
				addq $0, %rsp
lbl_20: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
