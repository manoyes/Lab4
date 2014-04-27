module Control(clk, Opcode, Function, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, JumpFromReg, mode);

 `include "parameters.v"
 
 input clk;
input [OP_SIZE-1:0] Opcode;
input [5:0] Function;

output RegDst;
output Branch;
output MemRead;
output MemtoReg;
output [1:0]ALUOp;
output MemWrite;
output ALUSrc;
output RegWrite;
output Jump;
output JumpFromReg;
output mode;

reg [0:11] control_bits;

initial
  control_bits = 12'b000000000000;

always @(posedge clk) begin
  #2 case (Opcode)
    OP_RTYPE: control_bits = 12'b100100001000; // R-type
   	
   	OP_LB   :   control_bits = 12'b011110000000;	//lb
		OP_LH   :   control_bits = 12'b011110000001;	//lh

		OP_SB   :   control_bits = 12'b010001000000;	//sb
		OP_SH   :   control_bits = 12'b010001000001;	//sh

		OP_BEQ  :   control_bits = 12'b000000100100;	//beq
		OP_BGEZ :   control_bits = 12'b000000100100;	//bgez
    
    OP_ADDI :   control_bits = 12'b010100001100;	//I-type addi
		OP_ORI  :   control_bits = 12'b010100001100; //I-type ORi
		OP_ANDI :   control_bits = 12'b010100001100;	//I-type andi
		OP_SLTI :   control_bits = 12'b010100001100;	//I-type slti
		OP_LUI  :   control_bits = 12'b010100001100;	//I-type lui		
    
  		OP_J    :   control_bits = 12'b000000010000;	//j
		OP_JAL  :   control_bits = 12'b000100010000;	//jal
  endcase  
  
  case (Function)
    F_JR   :   control_bits = 12'b100100011010; //jr
  endcase
end

assign RegDst      = control_bits[0];
assign ALUSrc      = control_bits[1];
assign MemtoReg    = control_bits[2];
assign RegWrite    = control_bits[3];
assign MemRead     = control_bits[4];
assign MemWrite    = control_bits[5];
assign Branch      = control_bits[6];
assign Jump        = control_bits[7];
assign ALUOp       = control_bits[8:9];
assign JumpFromReg = control_bits[10];
assign mode        = control_bits[11];

endmodule
