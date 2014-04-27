module Instruction_memory(clk, ReadAddress, Instruction);

`include "parameters.v"

input clk;
input [ADDR_WIDTH-1:0] ReadAddress;

output [INST_WIDTH-1:0] Instruction;

//parameter filename = "All_inst.txt";
parameter filename  = "test_fact.txt";

reg [MEM_WIDTH-1:0] Mem[0:65535];
reg [MEM_WIDTH-1:0] a1,a2,a3,a4;

initial $readmemb(filename,Mem); 

always @(posedge clk) begin
  
  a1 = Mem[ReadAddress];
  a2 = Mem[ReadAddress+1];
  a3 = Mem[ReadAddress+2];
  a4 = Mem[ReadAddress+3];
    $display("Instruction is: %b", {a1, a2, a3, a4});
end

assign #1 Instruction = {a1, a2, a3, a4};

endmodule