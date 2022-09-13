	.file	"find_max_template.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"The length of the array is %d\n"
	.text
	.globl	Find_Max
	.type	Find_Max, @function
Find_Max:
// prologue - write code for the prologue here
	endbr64 	   	   	#security thing that needs to go at start of prologue
	pushq	%rbp 	   	   	#push the base pointer
	movq	%rsp, %rbp 	   	#move the stack pointer to the base pointer
	subq	$32, %rsp  	   	#reserve 32 space for code

//reserve space for n and a to use it in the next print block
	movl	%edi, -4(%rbp)     	#store n at -4(%rbp)
	movq	%rsi, -32(%rbp)    	#store a at -32(%rbp)

// printf("The length of the array is %d\n", n);
// update this code if necessary to print the length of the array
// this block prints the value of register %edi
// initially the parameter n
	movl	%edi, %eax 	   	#move n into %eax
	movl	%eax, %esi 	   	#move n into %esi
	leaq	.LC0(%rip), %rdi   	#store in %rdi for printing
	movl	$0, %eax 	   	#clear %eax
	call	printf@PLT 	   	#print the length of the array

// reserve space for local variables
/* make a table here the variables from 
 * your c code and the addresses used in assembly 
 * n - address of n
 * a - address of a
 * i - address of i
 * ....
*/
//reserve i and max_index
	movl	$1, -8(%rbp) 	   	#store 1 in -8(%rbp) for i
	movl	$0, -12(%rbp)      	#store 0 in -12(%rbp) for max_index 

// this code calls Print_One_Number to 
// print the number found in register %eax - use this code to debug 
// replace $999 with a register or memory address you wish to print
//        movl    -4(%rbp), %eax		#store n in %eax
//	movl	%eax, %edi		#store n in %edi for printing
//	call	Print_One_Number@PLT	#Print n

// write your code to find the index of the maximum value here
TOP_OF_LOOP:
//compare i to n in for statment
	movl	-8(%rbp), %eax		#store i in %eax
	cmpl	-4(%rbp), %eax		#compare i and n
	jz	END_OF_LOOP		#if i - n = 0, jump to end of loop

//print one number
//	movl	-8(%rbp), %eax		#store i in %eax
//	leaq	(,%eax,4), %rdx		#moves address of i times 4 into %rdx
//	movq	-32(%rbp), %rax		#moves top of array a into %rax
//	addq	%rdx, %rax		#adds %rdx and %rax to get address of a[i]
//	movl	(%rax), %edi		#stores value of a[i] into %edi
//	call	Print_One_Number@PLT	#Prints a[i]

//find a[max_index}
	movl	-12(%rbp), %eax		#store max_index in %eax
	leaq	(,%eax,4), %rdx		#moves address of max_index times 4 into %rdx
	movq	-32(%rbp), %rax		#moves top of array a into %rax
	addq	%rdx, %rax		#adds %rdx and %rax to get address of a[max_index]
	movl	(%rax), %edx		#stores value of a[max_index] into %edx

//find a[i]
	movl	-8(%rbp), %eax		#store i in %eax
	leaq	(,%eax,4), %rcx		#moves address of i times 4 into %rcx
	movq	-32(%rbp), %rax		#moves top of array a into %rax
	addq	%rcx, %rax		#adds %rcx and %rax to get address of a[i]
	movl	(%rax), %eax		#stores value of a[i] into %eax

//if statement check
	cmpl	%eax, %edx		#compares a[i] to a[max_index]
	jge	NOT_EQUAL		#jumps if a[max_index] is greater than or equal to a[i]

//store i into max_index
	movl	-8(%rbp), %eax		#store i into %eax
	movl	%eax, -12(%rbp)		#store %eax(i) into max_index

//increment i and jump to start of for loop
NOT_EQUAL:
	addl    $1, -8(%rbp)		#increment i by 1
	jmp	TOP_OF_LOOP		#jump to the top of the for loop

//end of loop
END_OF_LOOP:

// prepare the return value
// the template returns -1, you will need to update this
	movl	-12(%rbp), %eax		#move max_index into %eax

// epilogue - complete the epilogue below
	leave				#cleans
	ret				#returns %eax
.LFE0:
	.size	Find_Max, .-Find_Max
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
