.section .data
	.input: .string "hello"

.section .bss
	.length: .zero 8

.section .text
.globl _start

_start:
	leaq	.input(%rip), %rdi
	call	strlen

	movq	%rax, %rdi
	movq	$10, %rsi
	leaq	.length(%rip), %rdx
	call	intstr

	movq	%rax, %rsi
	movq	.length(%rip), %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall

	movq	$60, %rax
	xorq	%rdi, %rdi
	syscall
