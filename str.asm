extern printf
global main
format_specifier:
    db '%s', 10, 0
format_number: 
    db '%d', 10, 0
format_specifier_float:
    db '%f', 10, 0
newline:  db 10, 0
Name: db "Name:", 10, 0
type: db "Transaction Type:", 10, 0
trans: db "Current number of transactions:", 10, 0
id: db "Account ID:", 10, 0
bank: db "Bank Information:", 10, 0
Amount: db "Current Amount:", 10, 0
Mod: db "Updated Amount: (withdrew 10.00 USD)", 10, 0




ten: dq 10.00 ; constant in memory 
; Individual strings
str1: db "Citi", 0
str2: db "Lynchburg", 0
str3: db "24515", 0
str4: db "VA", 0
str5: db "USA", 0

struc Account
    s_id resq 1              
    s_name resb 30           
    t_type resb 4            
    resb 4                   
    num_of_trans resq 1
    bank_stat_arr resq 5
    trans_amt resq 1         
endstruc

section .data
domalley istruc Account
    at s_id, dd 1234567891
    at s_name, db "Kevin McCallister", 0 
    at t_type, db 'D'     
    at num_of_trans, dd 3
    at bank_stat_arr, dq str1, str2, str3, str4, str5 ; Array of string pointers
    at trans_amt, dq 500.83
iend

section .text

print_update:
   push rbp                ; Save the old base pointer
   mov rbp, rsp 
   
   movsd xmm0, [domalley + trans_amt] 
   movsd xmm1, [ten]
   subsd xmm0, xmm1
   movsd [domalley + trans_amt], xmm0

    ; Print updated trans_amt
   mov rdi, format_specifier_float
   movsd xmm0, [domalley + trans_amt]
   mov rax,1
   call printf
   

    ; Update t_type to 'W'
   mov byte [domalley + 24], 'W' ; Set t_type to 'W'

    ; Print updated t_type
   mov rdi, format_specifier         ; Format specifier for strings
   lea rsi, [domalley + 24] ; Load updated t_type
   xor rax, rax                      ; Clear rax for printf
   call printf

   pop rbp
   ret

main:
   push rbp
   mov rbp, rsp
   ; print statement: Name
    mov rdi, Name                  
    xor rax, rax                      
    call printf 

     mov rdi, format_specifier
     mov rsi, domalley + s_name
     xor rax, rax
     call printf
   ; new line
   mov rdi, newline
   xor rax, rax
   call printf

   
   ; print statement: current transaction type
    mov rdi, type                 
    xor rax, rax                      
    call printf 

     mov rdi, format_specifier
     mov rsi, domalley + t_type
     xor rax, rax
     call printf
   ; new line
   mov rdi, newline
   xor rax, rax
   call printf
   
   ; print statement: total number of transactions
   mov rdi, trans                
   xor rax, rax                      
   call printf 
     mov rdi, format_number
     mov rsi, [domalley + num_of_trans]
     xor rax, rax
     call printf
   ; newline
   mov rdi, newline
   xor rax, rax
   call printf

   ;print statement: Account ID
   mov rdi, id                
   xor rax, rax                      
   call printf
     mov rdi, format_number
     mov rsi, [domalley + s_id]
     xor rax, rax
     call printf

   mov rdi, newline
   xor rax, rax
   call printf
   
   
  ; print statement: Bank information
   mov rdi, bank                
   xor rax, rax                      
   call printf
  ; Loop to print strings in bank_stat_arr
     mov rcx, 5                     ; Counter for 5 strings
     lea rbx, [domalley + bank_stat_arr] ; Address of bank_stat_arr

   begin_loop:
     push rbx
     push rcx
     mov rdi, format_specifier      
     mov rsi, [rbx]                 
     xor rax, rax                   
     call printf
     pop rcx
     pop rbx

     add rbx, 8                     
     dec rcx
     cmp rcx, 0              
     jg begin_loop           
   
   ;newline
   mov rdi, newline
   xor rax, rax
   call printf
   
   ; print statement: current amount
   mov rdi, Amount                
   xor rax, rax                      
   call printf

   mov rdi, format_specifier_float 
   movsd xmm0, [domalley + trans_amt] 
   mov rax,1                  
   call printf

   ; newline
   mov rdi, newline
   xor rax, rax
   call printf

  ; print statement: updated transaction
   mov rdi, Mod                
   xor rax, rax                      
   call printf
  call print_update
   

   mov rax, 60
   xor rdi, rdi                ; Set exit code to 0
   syscall