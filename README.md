A very simple low-level x86-64 Assembly Bank Account System leveraging structured memory management, SIMD floating-point arithmetic, and function calls to efficiently handle transactions, update balances, and print account details—demonstrating expertise in assembly programming, memory optimization, and system-level development.
This program demonstrates a basic use of struct function in x86 assembly language to model a simplified bank account system. This program includes a function to update account details called print_update and print statements in main of the information stored in the struct. The structure in this program is defined using NASM istruc directive (domalley istruc Account), which organizes related data fields into a contiguous memory block. This structure is implemented in the .data section, thus allowing for efficient organization of related account data, reducing the complexity of handling separate variables 
The fields in the Account struct include: 
1) s_id: A 64 bit integer storing the account ID 
2) s_name: A 30-byte buffer for the account holder’s name 
3) t_type: A 4-byte field storing the type of transaction (eg: ‘D’ for deposit, ‘W’ for withdrawal) 
4) num_of_trans: A 64 bit integer tracking the number of transactions. 
5) bank_state_arr:  An array of pointers to 5 strings highlighting the bank information (e.g., city,   
state, etc) 
6) trans_amt: A 64-bit floating point value storing the current transaction amount (e.g., 500.83 )
