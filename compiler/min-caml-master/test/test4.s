.data
.balign	8
.text
f.40:
	addl	$1, %eax
	ret
f.31:
	addl	$5, %eax
	movl	%eax, %ebx
	addl	$5, %ebx
	addl	$3, %ebx
	addl	$2, %ebx
	movl	%eax, %ecx
	addl	$5, %ecx
	addl	$3, %ecx
	addl	$1, %ecx
	movl	$1, %edx
	movl	%ecx, 0(%ebp)
	movl	%ebx, 4(%ebp)
	movl	%eax, 8(%ebp)
	movl	%edx, %eax
	addl	$16, %ebp
	call	f.40
	subl	$16, %ebp
	movl	4(%ebp), %eax
	movl	8(%ebp), %ebx
	movl	%ebx, %ecx
	addl	%eax, %ecx
	movl	%ecx, %edx
	addl	%ecx, %edx
	addl	%ecx, %edx
	addl	%ebx, %edx
	addl	%eax, %edx
	movl	0(%ebp), %eax
	addl	%eax, %edx
	movl	%edx, %eax
	addl	$5, %eax
	ret
.globl	min_caml_start
min_caml_start:
.globl	_min_caml_start
_min_caml_start: # for cygwin
	pushl	%eax
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	%esi
	pushl	%edi
	pushl	%ebp
	movl	32(%esp),%ebp
	movl	36(%esp),%eax
	movl	%eax,min_caml_hp
	movl	$5, %eax
	call	f.31
	call	min_caml_print_int
	popl	%ebp
	popl	%edi
	popl	%esi
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%eax
	ret
