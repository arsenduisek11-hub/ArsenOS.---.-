#define VIDEO 0xB8000
#define WIDTH 80

unsigned short* vid = (unsigned short*)VIDEO;
int x = 0, y = 0;

// если честно хз почему 0xA, но работает
#define GREEN_COLOR 0x0A00

void print(char* s) {
    for(int i = 0; s[i]; i++) {
        if(s[i] == '\n') {
            x = 0;
            y++;
            continue;
        }
        vid[y * WIDTH + x] = GREEN_COLOR | s[i];
        x++;
        if(x >= WIDTH) {
            x = 0;
            y++;
        }
    }
}

void kmain() {
    // чистим экран через пробелы
    for(int i = 0; i < 80 * 25; i++)
        vid[i] = 0x0700 | ' ';
    
    print("ArsenOS v0.1: Hello from kernel!\n");
    
    while(1) {
        __asm__("hlt");
    }
}
