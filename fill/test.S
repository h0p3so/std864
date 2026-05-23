#define size 16


.section .bss
	.buffer: .zero size

.section .text
.globl _start

_start:
	leaq	.buffer(%rip), %rdi
	movq	$size, %rsi
	movq	$'z', %rdx
	call	fill

	movq	%rax, %rdx
	leaq	.buffer(%rip), %rsi
	movq	$1, %rax
	movq	$1, %rdi
	syscall

	movq	$60, %rax
	movq	$0, %rdi
	syscall
