# ---------------------------------------------------------------------------
# strint.S -- parse an unsigned decimal integer from a string
#
# SYNOPSIS
#   Reads consecutive ASCII decimal digits starting at the address
#   pointed to by `*str_ptr`, advances `*str_ptr` past the digits,
#   and returns the parsed value.  If no digit is found, zero is
#   returned and `*str_ptr` is not advanced.
#
# PARAMETERS
#   %rdi  - pointer to a mutable pointer to the string  (char**)
#           On entry:  *str_ptr points to the first character to try
#           On return: *str_ptr points to the first non-digit character
#
# RETURN VALUE
#   %rax  - the parsed integer (0 if no digits found)
#
# CLOBBERS
#   %rax, %rdi, %rsi, %rdx, %rbp
#
# DEPENDS ON
#   isdigit  (external, see ../isdigit/isdigit.S)
# ---------------------------------------------------------------------------

.globl strint

.section .text

strint:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, -20(%rbp)
	movw	$0, -22(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %edi
	cmpb	$'-', %dil
	jne	.__strint_parse
	movw	$1, -22(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
.__strint_parse:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %edi
	call	isdigit
	cmpq	$0, %rax
	je	.__strint_fini
	subb	$48, %dil
	movq	-20(%rbp), %rax
	movl	$10, %esi
	mulq	%rsi
	addq	%rdi, %rax
	movq	%rax, -20(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	leaq	1(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	jmp	.__strint_parse
.__strint_fini:
	cmpw	$1, -22(%rbp)
	jne	.__strint_fini_ret
	movq	-20(%rbp), %rax
	movq	$-1, %rbx
	imulq	%rbx
	movq	%rax, -20(%rbp)
.__strint_fini_ret:
	movq	-20(%rbp), %rax
	leave
	ret
