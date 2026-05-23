# ---------------------------------------------------------------------------
# strlen.S -- return the length of a null-terminated string
#
# SYNOPSIS
#   Computes the number of bytes in a null-terminated string,
#   excluding the terminating null byte.
#
# PARAMETERS
#   %rdi  - pointer to the string  (const char*)
#
# RETURN VALUE
#   %rax  - length of the string (number of bytes before the first '\0')
#
# CLOBBERS
#   %rax, %rbp
# ---------------------------------------------------------------------------

.globl strlen

.section .text

strlen:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, -16(%rbp)
	jmp	.__strlen_condition
.__strlen_loop:
	addq	$1, -8(%rbp)
	addq	$1, -16(%rbp)
.__strlen_condition:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.__strlen_loop
	movq	-16(%rbp), %rax
	leave
	ret
