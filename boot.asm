// Это boot.asm работает или ннет хз вроде дда 
sectionoot
align 4
    dd 0x1BADB002
    dd 0x03
    dd -(0x1BADB002 + 0x03)

section .text
global _start
extern kmain

_start:
    cli
    lgdt [gdt_desc]
    
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    jmp 0x08:.protected
    
.protected:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    
    mov esp, 0x90000
    call kmain
    
.hang:
    hlt
    jmp .hang

gdt_start:
    dq 0x0
gdt_code:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 0x9A
    db 0xCF
    db 0x0
gdt_data:
    dw 0xFFFF
    dw 0x0
    db 0x0
    db 0x92
    db 0xCF
    db 0x0
gdt_end:

gdt_desc:
    dw gdt_end - gdt_start - 1
    dd 
