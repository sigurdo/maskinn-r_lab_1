.global _start
_start:

.section .text
	ldr r1, =a
    ldr r2, =b
	ldr r3, =c
   	ldr r1, [r1]
	ldr r2, [r2]
	add r1, r1, r2
	str r1, [r3]
	
.section .data
a:
	.word 1

b:
	.word 2

c:
	.word 0
	