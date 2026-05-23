.section .text
.globl _start

_start:
	mov	$'5', %dil
	call	isdigit
	add	$48, %al
	pushq	%rax
	movq	%rsp, %rsi
	movq	$1, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	addq	$8, %rsp

	mov	$'A', %dil
	call	isdigit
	add	$48, %al
	pushq	%rax
	movq	%rsp, %rsi
	movq	$1, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	addq	$8, %rsp

	mov	$'0', %dil
	call	isdigit
	add	$48, %al
	pushq	%rax
	movq	%rsp, %rsi
	movq	$1, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	addq	$8, %rsp

	mov	$'/', %dil
	call	isdigit
	add	$48, %al
	pushq	%rax
	movq	%rsp, %rsi
	movq	$1, %rdx
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	addq	$8, %rsp

	movq	$60, %rax
	movq	$0, %rdi
	syscall
