module Control(clk, Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump);

 `include "parameters.v"
 
 input clk;
input [OP_SIZE-1:0] Opcode;

output RegDst;
output Branch;
output MemRead;
output MemtoReg;
output [1:0]ALUOp;
output MemWrite;
output ALUSrc;
output RegWrite;
output Jump;

reg [0:9] control_bits;

initial
control_bits = 10'b0000000000;

always @(Opcode) begin
  case (Opcode)
    OP_RTYPE: control_bits = 10'b1001000010; // R-type (Do I need 10'b1001000110 for jr?)
   	
   	OP_LB:    control_bits = 10'b0111100000;	//lb
		OP_LH:    control_bits = 10'b0111100000;	//lh

		OP_SB:    control_bits = 10'b0100010000;	//sb
		OP_SH:    control_bits = 10'b0100010000;	//sh

		OP_BEQ:   control_bits = 10'b0000001001;	//beq
		OP_BGEZ:  control_bits = 10'b0000001001;	//bgez
    
    OP_ADDI:  control_bits = 10'b0101000011;	//I-type addi
		OP_ORI:   control_bits = 10'b0101000011; //I-type ORi
		OP_ANDI:  control_bits = 10'b0101000011;	//I-type andi
		OP_SLTI:  control_bits = 10'b0101000011;	//I-type slti
		OP_LUI:   control_bits = 10'b0101000011;	//I-type lui
    
  		OP_J:     control_bits = 10'b0000000100;	//j
		//6'b000011: control_bits = 10'b0000000100;	//jal
  endcase
end

assign #2 RegDst   = control_bits[0];
assign ALUSrc   = control_bits[1];
assign MemtoReg = control_bits[2];
assign RegWrite = control_bits[3];
assign MemRead  = control_bits[4];
assign MemWrite = control_bits[5];
assign Branch   = control_bits[6];
assign Jump     = control_bits[7];
assign ALUOp    = control_bits[8:9];

endmodule
