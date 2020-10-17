#include <stdio.h>

#define REG_SIZE 8
#define RAM_SIZE 256
#define ROM_SIZE 256

#define REG0 0
#define REG1 1
#define REG2 2
#define REG3 3
#define REG4 4
#define REG5 5
#define REG6 6
#define REG7 7

typedef enum{
    MOV,                        /* Move */
    ADD,                        /* Addition */
    SUB,                        /* Subtraction */
    AND,                        /* Logical conjunction */
    OR,                         /* Logical disjunction */
    SL,                         /* Left logical shift */
    SR,                         /* Right logical shift */
    SRA,                        /* Right arithmetic shift */
    LDL,                        /* Load immediate value low */
    LDH,                        /* Load immediate value high */
    CMP,                        /* Comparation */
    JE,                         /* Jump equal */
    JMP,                        /* Unconditional jump */
    LD,                         /* Load memory */
    ST,                         /* Store memory */
    HLT                         /* Halt */
}OpCode;


OpCode opCode(short ir);
unsigned char opRegA(short ir);
unsigned char opRegB(short ir);
unsigned char opData(short ir);
unsigned char opAddr(short ir);

void emulateCPU(short* rom, short* ram);

short mov(unsigned char reg_a, unsigned char reg_b);
short add(unsigned char reg_a, unsigned char reg_b);
short sub(unsigned char reg_a, unsigned char reg_b);
short and(unsigned char reg_a, unsigned char reg_b);
short or(unsigned char reg_a, unsigned char reg_b);
short sl(unsigned char reg_a);
short sr(unsigned char reg_a);
short sra(unsigned char reg_a);
short ldl(unsigned char reg_a, unsigned char data);
short ldh(unsigned char reg_a, unsigned char data);
short cmp(unsigned char reg_a, unsigned char reg_b);
short je(unsigned char addr);
short jmp(unsigned char addr);
short ld(unsigned char reg_a, unsigned char addr);
short st(unsigned char reg_a, unsigned char addr);
short hlt();

void assembler(short* rom);


void showData(short * data, unsigned int begin, unsigned int end){

    unsigned int i;
    for(i = begin; i < end; i++){
        fprintf(stdout, "    [%4u] %d\n", i, data[i]);
    }
}


int main(void){

    short ram[RAM_SIZE];        /* Data segment */
    short rom[ROM_SIZE];        /* Text segment */

    assembler(rom);

    emulateCPU(rom, ram);

    fprintf(stdout, "RAM: \n");
    showData(ram, 0, RAM_SIZE);
    
    return 0;
}

/* Functions used within CPU emulator */

OpCode opCode(short ir){

    return (OpCode)((ir & 0b0111100000000000) >> 11);
}

unsigned char opRegA(short ir){

    return (ir & 0b0000011100000000) >> 8;
}

unsigned char opRegB(short ir){

    return (ir & 0b0000000011100000) >> 5;
}

unsigned char opData(short ir){

    return (unsigned char)(ir & 0b0000000011111111);
}

unsigned char opAddr(short ir){

    return (unsigned char)(ir & 0b0000000011111111);
}


/* Simple CPU emulator */
void emulateCPU(short* rom, short* ram){

    unsigned char pc = 0;       /* Program counter */
    unsigned char flag_eq = 0;

    short reg[REG_SIZE];        /* General purpose register */

    
    short ir = 0;               /* Instruction register */

    unsigned char finish = 0;
    
    while(! finish){
        
        ir = rom[pc];

        pc++;

        OpCode code = opCode(ir);
        switch(code){
        case MOV:
            reg[opRegA(ir)] = reg[opRegB(ir)];
            break;
        case ADD:
            reg[opRegA(ir)] = reg[opRegA(ir)] + reg[opRegB(ir)];
            break;
        case SUB:
            reg[opRegA(ir)] = reg[opRegA(ir)] - reg[opRegB(ir)];
            break;
        case AND:
            reg[opRegA(ir)] = reg[opRegA(ir)] & reg[opRegB(ir)];
            break;
        case OR:
            reg[opRegA(ir)] = reg[opRegA(ir)] | reg[opRegB(ir)];
            break;
        case SL:
            reg[opRegA(ir)] <<= 1;
            break;
        case SR:
            (unsigned short)(reg[opRegA(ir)]) >>= 1;
            break;
        case SRA:
            reg[opRegA(ir)] = (reg[opRegA(ir)] >> 1) | 0x8000;
            break;
        case LDL:
            reg[opRegA(ir)] = (reg[opRegA(ir)] & 0xFF00) + (short)opData(ir);
            break;
        case LDH:
            reg[opRegA(ir)] = (reg[opRegA(ir)] & 0x00FF) + ((short)opData(ir) << 8);
            break;
        case CMP:
            flag_eq = (reg[opRegA(ir)] == reg[opRegB(ir)]) ? 1 : 0;
            break;
        case JE:
            if(flag_eq){
                pc = opAddr(ir);
            }
            break;
        case JMP:
            pc = opAddr(ir);
            break;
        case LD:
            reg[opRegA(ir)] = ram[opAddr(ir)];
            break;
        case ST:
            ram[opAddr(ir)] = reg[opRegA(ir)];
            break;
        case HLT:
            finish = 1;
            break;
        default:
            fprintf(stderr, "[ERROR] Unexpected operation code detected(%d)\n", code);
            finish = 1;
            break;
        }
        
    }

}



/* Functions used within assembler */

short mov(unsigned char reg_a, unsigned char reg_b){
    return (short)0x0000 | (short)reg_a << 8 | (short)reg_b << 5;
}

short add(unsigned char reg_a, unsigned char reg_b){
    return (short)0x0800 | (short)reg_a << 8 | (short)reg_b << 5;
}

short sub(unsigned char reg_a, unsigned char reg_b){
    return (short)0x1000 | (short)reg_a << 8 | (short)reg_b << 5;
}

short and(unsigned char reg_a, unsigned char reg_b){
    return (short)0x1800 | (short)reg_a << 8 | (short)reg_b << 5;
}

short or(unsigned char reg_a, unsigned char reg_b){
    return (short)0x2000 | (short)reg_a << 8 | (short)reg_b << 5;
}

short sl(unsigned char reg_a){
    return (short)0x2800 | (short)reg_a << 8;
}

short sr(unsigned char reg_a){
    return (short)0x3000 | (short)reg_a << 8;
}

short sra(unsigned char reg_a){
    return (short)0x3800 | (short)reg_a << 8;
}

short ldl(unsigned char reg_a, unsigned char data){
    return (short)0x4000 | (short)reg_a << 8 | (short)data;
}

short ldh(unsigned char reg_a, unsigned char data){
    return (short)0x4800 | (short)reg_a << 8 | (short)data;
}

short cmp(unsigned char reg_a, unsigned char reg_b){
    return (short)0x5000 | (short)reg_a << 8 | (short)reg_b << 5;
}

short je(unsigned char addr){
    return (short)0x5800 | (short)addr;
}

short jmp(unsigned char addr){
    return (short)0x6000 | (short)addr;
}

short ld(unsigned char reg_a, unsigned char addr){
    return (short)0x6800 | (short)reg_a << 8 | (short)addr;
}

short st(unsigned char reg_a, unsigned char addr){
    return (short)0x7000 | (short)reg_a << 8 | (short)addr;
}

short hlt(){
    return (short)0x7800;
}


/* Simple assembler */
void assembler(short* rom){

    /* Write assembly program here */

    rom[0] = ldh(REG0, 0);
    rom[1] = ldl(REG0, 0);
    rom[2] = ldh(REG1, 0);
    rom[3] = ldl(REG1, 1);
    rom[4] = ldh(REG2, 0);
    rom[5] = ldl(REG2, 0);
    rom[6] = ldh(REG3, 0);
    rom[7] = ldl(REG3, 10);
    rom[8] = add(REG2, REG1);
    rom[9] = add(REG0, REG2);
    rom[10] = st(REG0, 64);
    rom[11] = cmp(REG2, REG3);
    rom[12] = je(14);
    rom[13] = jmp(8);
    rom[14] = hlt();
    
}

