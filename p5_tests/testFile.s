.data
.globl	main
gbl_a:	.quad 0
str_0: 	.asciz "hello world"
.align 8

.text

main:
				pushq	%rbp
				movq	%rsp, %rbp
				addq	$16, %rbp
				subq	$0, %rsp
				movq	$str_0, %rdi
				callq printString
				movq	$12, %rax
jmp lbl_0
lbl_0: 
				movq	%rax, %rdi
				movq $60, %rax
				syscall
