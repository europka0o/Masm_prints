.386
.model flat, stdcall
option casemap:none
include kernel32.inc 
include user32.inc 
includelib kernel32.lib 
includelib user32.lib
BSIZE equ 13  

.data
ifmt db "%s", 10, 0 		;Строка формата
buf db BSIZE dup(?) 		;Буфер
msg byte "Hello Wolrd!", 0 ;Строка вывода
stdout dd ?         
cWritten dd ?

.code
start:
	push -11 ;Дискриптор 
	call GetStdHandle ;После своей работы функция возвращает значение потока stdout в регистр eax
	
	mov stdout, eax 

	lea esi, dword ptr [msg]
	push esi

	lea esi, dword ptr [ifmt]
	push esi
	
	lea ebx, dword ptr [buf]
	push ebx
	
	call wsprintf
	
	push 0
	
	lea ebx, [cWritten]
	push ebx
	
	push BSIZE
	
	lea ebx, dword ptr [buf]
	push ebx
	
	push stdout
	
	call WriteConsoleA
	
	push 0
	call ExitProcess
	  
end start