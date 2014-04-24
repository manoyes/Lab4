`timescale 1ps / 1ps
module Instruction_memory(ReadAddress, Instruction);

input [15:0] ReadAddress;

output [31:0] Instruction;

parameter filename = "All_inst.txt";

reg [7:0] Mem[0:65535];
reg [7:0] a1,a2,a3,a4;

initial $readmemb(filename,Mem); 

always @(ReadAddress) begin
  a1 = Mem[ReadAddress];
  a2 = Mem[ReadAddress+1];
  a3 = Mem[ReadAddress+2];
  a4 = Mem[ReadAddress+3];
end

assign #5 Instruction = {a1, a2, a3, a4};

endmodule