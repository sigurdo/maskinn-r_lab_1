.global _start

.section .text

_start:
	// Here your execution starts
	// b exit
	b check_input

	
check_input:
	// You could use this symbol to check for your input length
	// you can assume that your input string is at least 2 characters 
	// long and ends with a null byte

	ldr r1, =input // input base address
	mov r2, #0 // counter
	mov r3, #0 // string terminator
	mov r4, #1 // increment

check_input_loop:
	ldrb r9, [r1, r2]
	cmp r9, r3
	beq check_input_loop_end
	add r2, r2, r4
	b check_input_loop

check_input_loop_end:
	mov r1, r2 // r1 now contains the length of input
	
check_palindrome:
	// Here you could check whether input is a palindrome or not
	ldr r2, =input // input base address
	mov r3, #0 // left counter
	mov r8, r1
	sub r8, r8, #1 // right counter (counting down)
	mov r4, #1 // increment
	mov r5, #0x20 // whitespace
	mov r6, #0x1f // case-insensitivity mask
	lsr r7, r1, #1 // half length

check_palindrome_loop:
	ldrb r9, [r2, r3]  // Left character
	ldrb r10, [r2, r8] // Right character

	cmp r9, r5         // Check for whitespace left
	beq check_palindrome_loop_whitespace_left

	cmp r10, r5        // Check for whitespace right
	beq check_palindrome_loop_whitespace_right

	and r9, r9, r6     // Left character case insensitive
	and r10, r10, r6   // Right character case insensitive
	
	cmp r9, r10        // Check if left == right
	bne palindrome_not_found

	add r3, r3, r4     // Increment left counter
	sub r8, r8, r4     // Decrement right counter

	// Check if finished
	// Simple way: break out of loop if left counter == length
	// cmp r3, r1
	// beq check_palindrome_loop_end
	// Complicated way: break out of loop if left counter >= half length and right counter < half length
	mov r11, #0    // Initialize not_finished flag (1 means not finished)
	cmp r3, r7
	movlt r11, #1  // Raise not_finished flag if left counter < half length
	cmp r8, r7
	movge r11, #1  // Raise not_finished flag if right counter >= half length
	cmp r11, #0
	beq check_palindrome_loop_end

	b check_palindrome_loop

check_palindrome_loop_whitespace_left:
	add r3, r3, r4
	b check_palindrome_loop

check_palindrome_loop_whitespace_right:
	sub r8, r8, r4
	b check_palindrome_loop


check_palindrome_loop_end:
	b palindrome_found
	
palindrome_found:
	// Switch on only the 5 rightmost LEDs
	ldr r1, =0xff200000
	mov r2, #0b0000011111
	str r2, [r1]

	// Write 'Palindrome detected' to UART
	ldr r1, =0xff201000
	ldr r2, =text_is_palindrome
	mov r3, #0 // counter

palindrome_found_loop:
	ldrb r4, [r2, r3]
	cmp r4, #0
	str r4, [r1]
	beq palindrome_found_loop_end
	add r3, r3, #1
	b palindrome_found_loop
palindrome_found_loop_end:

	b exit
	
palindrome_not_found:
	// Switch on only the 5 leftmost LEDs
	ldr r1, =0xff200000
	mov r2, #0b1111100000
	str r2, [r1]

	// Write 'Not a palindrome' to UART
	ldr r1, =0xff201000
	ldr r2, =text_not_palindrome
	mov r3, #0 // counter

palindrome_not_found_loop:
	ldrb r4, [r2, r3]
	cmp r4, #0
	str r4, [r1]
	beq palindrome_not_found_loop_end
	add r3, r3, #1
	b palindrome_not_found_loop
palindrome_not_found_loop_end:

	b exit
	
exit:
	// Branch here for exit
	b exit
	

.section .data
.align
	// This is the input you are supposed to check for a palindrome
	// You can modify the string during development, however you
	// are not allowed to change the label 'input'!
	input: .asciz "level"
	// input: .asciz "8448"
    // input: .asciz "KayAk"
    // input: .asciz "step on no pets"
    // input: .asciz "Never odd or even"

	text_is_palindrome: .asciz "Palindrome detected\r\n"
	text_not_palindrome: .asciz "Not a palindrome\r\n"


.end


