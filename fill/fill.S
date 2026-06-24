# ---------------------------------------------------------------------------
# fill.S -- fill a buffer with a repeated byte value
#
# SYNOPSIS
#   Writes `count` bytes of `value` into the buffer pointed to by `dest`.
#   Analogous to memset(3).
#
# PARAMETERS
#   %rdi  - pointer to destination buffer  (void*)
#   %rsi  - number of bytes to fill  (size_t)
#   %rdx  - fill value (byte, ASCII character)
#
# RETURN VALUE
#   %rax  - number of bytes written (always equals `count`)
#
# CLOBBERS
#   %rax, %rbx, %rcx, %rbp
# ---------------------------------------------------------------------------
.section .text
.globl fill

fill:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%rdi,  -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	$0,   -32(%rbp)
.__fill_loop:
	movq	-32(%rbp), %rcx
	cmpq	-16(%rbp), %rcx
	jae	.__fill_fini
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rbx
	movb	%bl, (%rax, %rcx)
	incq	-32(%rbp)
	jmp	.__fill_loop
.__fill_fini:
	movq	-32(%rbp), %rax
	leave
	ret
