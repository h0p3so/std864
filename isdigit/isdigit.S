# ---------------------------------------------------------------------------
# isdigit.S -- check whether a byte is an ASCII decimal digit
#
# SYNOPSIS
#   Returns 1 if the given byte is in the range '0'–'9' (ASCII 48–57),
#   and 0 otherwise.
#
# PARAMETERS
#   %dil  - byte to test  (unsigned char)
#
# RETURN VALUE
#   %rax  - 1 if digit, 0 otherwise
#
# CLOBBERS
#   %rax
# ---------------------------------------------------------------------------

.globl isdigit

.section .text

isdigit:
	cmpb	$48, %dil
	jb	.__isdigit_no
	cmpb	$57, %dil
	ja	.__isdigit_no
	movq	$1, %rax
	jmp	.__isdigit_fini
.__isdigit_no:
	movq	$0, %rax
.__isdigit_fini:
	ret
