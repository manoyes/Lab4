parameter ADDR_WIDTH = 16;
parameter INST_WIDTH = 32;
parameter MEM_WIDTH = 8;
parameter DATA_WIDTH = 16;

parameter REG_ADDR_WIDTH = 5;
parameter REG_SIZE = 16;

parameter OP_SIZE = 6;
parameter FUNC_SIZE = 6;

parameter OP_RTYPE = 6'b000000;
parameter OP_LB = 6'b100000;
parameter OP_LH = 6'b100001;
parameter OP_SB = 6'b101000;
parameter OP_SH = 6'b101001;
parameter OP_BEQ = 6'b000100;
parameter OP_BGEZ = 6'b000001;
parameter OP_ADDI = 6'b001000;
parameter OP_ORI = 6'b001101;
parameter OP_ANDI = 6'b001100;
parameter OP_SLTI = 6'b001010;
parameter OP_LUI = 6'b001111;
parameter OP_J = 	6'b000010;

parameter F_ADD = 6'b100000;					
parameter F_SUB = 6'b100010; 
parameter F_AND = 6'b100100;
parameter F_NOR = 6'b100111;
parameter F_OR  = 6'b100101;        
parameter F_SLT = 6'b101010;
parameter F_SLL = 6'b000000;
parameter F_SRL = 6'b000010;
parameter F_MULT = 6'b011000;
parameter F_DIV = 6'b011010;
parameter F_MFHI = 6'b010000;
parameter F_MFLO = 6'b010010;

parameter ALU_ADD = 6'b000001;
parameter ALU_SUB = 6'b000010;
parameter ALU_AND = 6'b000011;
parameter ALU_NOR = 6'b000100;
parameter ALU_OR  = 6'b000101;
parameter ALU_LUI = 6'b000111;
parameter ALU_SLT = 6'b001000;
parameter ALU_SLL = 6'b001111;
parameter ALU_SRL = 6'b010000;
parameter ALU_BEQ = 6'b001001;
parameter ALU_BGEZ = 6'b001010;
parameter ALU_MULT = 6'b001100;
parameter ALU_DIV = 6'b001011;
parameter ALU_MFHI = 6'b001101;
parameter ALU_MFLO = 6'b001110;