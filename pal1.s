.section .data

input_x_prompt	:	.asciz	"Please enter x: "
input_y_prompt	:	.asciz	"Please enter y: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"x*y = %d\n"

.section .text

.global main

#main
main:

#create room on stack for x
sub sp, sp, 8
#get x value, input it into x0
ldr x0, = input_x_prompt
bl printf	
# spec input
ldr x0, = input_spec
mov x1, sp
bl scanf
ldrsw x19, [sp]
#x19 = x

#get y input value
# enter y output
ldr x0, = input_y_prompt
bl printf
# spec input
ldr x0, = input_spec
mov x1, sp
bl scanf
ldrsw x20, [sp]
#x20 = y

#make temp var for loop, set to 0 
add x9, xzr, xzr
#make result var, set to 0
add x21, xzr, xzr
#change sign of y and x to properly mutliple the numbers 
sub x13, x20, 0
cbz x13, change_sign 

loop:
	subs x12, x20, x9
	#i < y in loop declaration 
	cbz x12, print_result
	#result += x
	add x21, x21, x19
	#i++ in loop declaration 
	add x9, x9, 1
	#recurse loop 
	b loop

change_sign:
	add x11, xzr, xzr 
	sub x19, x11, x19
	sub x20, x11, x20
	bl loop
	

print_result:
	mov x1, x21
	ldr x0, = result
	bl printf
	b exit

# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret