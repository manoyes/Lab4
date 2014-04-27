module Control(Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump);

input [5:0] Opcode;

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
    6'b000000: control_bits = 10'b1001000010; // R-type (Do I need 10'b1001000110 for jr?)
   	
   	6'b100000: control_bits = 10'b0111100000;	//lb
		6'b100001: control_bits = 10'b0111100000;	//lh

		6'b101000: control_bits = 10'b0100010000;	//sb
		6'b101001: control_bits = 10'b0100010000;	//sh

		6'b000100: control_bits = 10'b0000001001;	//beq
		6'b000001: control_bits = 10'b0000001001;	//bgez
    
    6'b001000: control_bits = 10'b0101000011;	//I-type addi
		6'b001101: control_bits = 10'b0101000011;	//I-type ORi
		6'b001100: control_bits = 10'b0101000011;	//I-type andi
		6'b001010: control_bits = 10'b0101000011;	//I-type slti
		6'b001111: control_bits = 10'b0101000011;	//I-type lui
    
  		6'b000010: control_bits = 10'b0000000100;	//j
		6'b000011: control_bits = 10'b0000000100;	//jal
  endcase
end

assign RegDst   = control_bits[0];
assign ALUSrc   = control_bits[1];
assign MemtoReg = control_bits[2];
assign RegWrite = control_bits[3];
assign MemRead  = control_bits[4];
assign MemWrite = control_bits[5];
assign Branch   = control_bits[6];
assign Jump     = control_bits[7];
assign ALUOp    = control_bits[8:9];

endmodule
