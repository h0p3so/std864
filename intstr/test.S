.section .bss
	.length: .zero 8
.section .text
.globl _start

_start:
	movq	$1234, %rdi
	movq	$2, %rsi
	leaq	.length(%rip), %rdx
	call	intstr

	movq	%rax, %rsi
	movq	.length(%rip), %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall

	movq	$60, %rax
	movq	$0, %rdi
	syscall
