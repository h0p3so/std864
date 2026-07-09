# ---------------------------------------------------------------------------
# intstr.S -- convert a signed integer to its decimal string representation
#
# SYNOPSIS
#   Converts a signed 64-bit integer to a null-terminated decimal string
#   written into an internal static buffer.  A pointer to the resulting
#   string is returned, and the string's length (excluding the terminator)
#   is stored in the location pointed to by `len_ptr`.
#
#   Negative numbers are prefixed with '-'.
#
# PARAMETERS
#   %rdi  - the integer to convert  (int64_t)
#   %rsi  - numeric base
#   %rdx  - pointer to a 64-bit location that receives the string length  (size_t*)
#
# RETURN VALUE
#   %rax  - pointer to the resulting string (internal static buffer)
#
# CLOBBERS
#   %rax, %rbx, %rdx, %rbp
# ---------------------------------------------------------------------------

.equ INTSTR_BUFFER_CAPACITY, 32

.globl intstr

.section .bss
	.__intstr_buffer: .zero INTSTR_BUFFER_CAPACITY

.section .text

intstr:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movq	%rdx, -20(%rbp)
	movw	$0, -30(%rbp)
	leaq	.__intstr_buffer(%rip), %rax
	addq	$INTSTR_BUFFER_CAPACITY, %rax
	decq	%rax
	movq	%rax, -28(%rbp)
	movq	-20(%rbp), %rax
	movq	$0, (%rax)
.__intstr_init:
	movq	-8(%rbp), %rax
	cmpq	$0, %rax
	je	.__intstr_init_trivial
	jg	.__intstr_loop
	movq	-8(%rbp), %rax
	movq	$-1, %rbx
	imulq	%rbx
	movq	%rax, -8(%rbp)
	movw	$1, -30(%rbp)
	jmp	.__intstr_loop
.__intstr_init_trivial:
	movq	-28(%rbp), %rax
	movb	$'0', (%rax)
	decq	%rax
	movq	%rax, -28(%rbp)
	movq	-20(%rbp), %rax
	movq	$1, (%rax)
	jmp	.__intstr_fini_ret
.__intstr_loop:
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %ebx
	xorq	%rdx, %rdx
	divq	%rbx
	movq	%rax, -8(%rbp)
	addq	$48, %rdx
	movq	-28(%rbp), %rax
	movb	%dl, (%rax)
	decq	%rax
	movq	%rax, -28(%rbp)
	movq	-20(%rbp), %rax
	incq	(%rax)
	cmpq	$0, -8(%rbp)
	je	.__intstr_fini
	jmp	.__intstr_loop
.__intstr_fini:
	cmpw	$1, -30(%rbp)
	jne	.__intstr_fini_ret
	movq	-28(%rbp), %rax
	movb	$'-', (%rax)
	decq	%rax
	movq	%rax, -28(%rbp)
	movq	-20(%rbp), %rax
	incq	(%rax)
.__intstr_fini_ret:
	movq	-28(%rbp), %rax
	incq	%rax
	leave
	ret
