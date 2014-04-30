// -----------------------------------------------------------------------------
// MODULE: Instruction_memory
// -----------------------------------------------------------------------------
// PURPOSE : Memory storage for instructions
// -----------------------------------------------------------------------------
// INPUTS
// clk          : system clock
// ReadAddress  : The address of the instruction to be executed
// -----------------------------------------------------------------------------
// OUTPUTS
// Instruction  : The instruction to execute this cycle
// -----------------------------------------------------------------------------
module Instruction_memory(clk, ReadAddress, Instruction);

`include "parameters.v"

// ===== INPUTS =====
input clk;
input [ADDR_WIDTH-1:0] ReadAddress;

// ===== OUTPUTS =====
output [INST_WIDTH-1:0] Instruction;

// ***** CHANGE FILENAME TO SEE BONUS 2. *************** //
// ***** SET CLOCK TO 20 NS ************************ //
// ***** SET SIM TIME TO 1760 NS FOR FACTORIAL ***** //

parameter filename = "All_inst.txt";
//parameter filename  = "factorial.txt";

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