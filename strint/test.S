.section .data
	.input: .string "-42"

.section .bss
	.str_ptr: .zero 8
	.length:  .zero 8

.section .text
.globl _start

_start:
	leaq	.input(%rip), %rax
	movq	%rax, .str_ptr(%rip)
	leaq	.str_ptr(%rip), %rdi
	movq	$10, %rsi
	call	strint

	movq	%rax, %rdi
	movq	$2, %rsi
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
