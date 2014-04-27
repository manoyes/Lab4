module MemToRegMux(clk, Opcode, ReadData, ALUResult, MemtoReg, WriteData, LinkAddress);

  `include "parameters.v"

  input clk;

  input [5:0] Opcode;
  input [15:0] ReadData;
  input [15:0] ALUResult;
  input MemtoReg;
  input [15:0] LinkAddress;
  output reg [15:0] WriteData;

  always @(posedge clk) begin
    #8 if(Opcode == OP_JAL) begin
          WriteData = LinkAddress;
       end else begin
          WriteData = MemtoReg ? ReadData : ALUResult;
       end
  end
  
endmodule
