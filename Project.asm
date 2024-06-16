; tells the assembler we are using x64 assembly
bits 64
; exposes the main function to the linker
global _main
; imports the printf function
extern printf
; imports the getchar function
extern getchar

; defines the data section
section .data use64
	hello_string: db "hello", 0

; defines the text section
section .text use64

; returns the length of the specified string
; int __stdcall string_length(const char* string)
_string_length:
	mov rax, 0
_next_character:
	mov rbx, [rcx+rax]
	inc rax
	cmp rbx, 0
	jne _next_character
	ret

; the main entry point of the program
; int main(int argc, char *argv[])
_main:
	; return string_length(hello_string);
	mov rcx, hello_string
	call _string_length
	mov rcx, hello_string
	sub rsp, 16
	call printf
	call getchar
	ret