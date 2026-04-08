#include <stdint.h>
#include <stdio.h>

// Simple VM instruction struct
typedef struct {
    uint8_t opcode;
    uint32_t args[4];
} Instr;

// Execute single instruction (stub for Rust FFI)
uint32_t exec_instr(Instr* i, uint8_t* mem, uint32_t mem_size) {
    switch (i->opcode) {
        case 0x01: // LOAD arg0 <- arg1
            if (i->args[1] < mem_size) {
                mem[i->args[0]] = (uint8_t)i->args[1];
            }
            break;
        case 0x02: // ADD arg0 = arg1 + arg2
            {
                uint32_t v1 = mem[i->args[1]];
                uint32_t v2 = mem[i->args[2]];
                uint32_t sum = v1 + v2;
                // Store back (simplified)
                printf("C: ADD result=%u\\n", sum);
            }
            break;
        case 0xFF: // HALT
            return 0;
        default:
            printf("C: Unknown opcode %u\\n", i->opcode);
    }
    return 1; // Continue
}

