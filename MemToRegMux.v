// -----------------------------------------------------------------------------
// MODULE: MemToRegMux
// -----------------------------------------------------------------------------
// PURPOSE : Multiplexor, decides data written to the register file should come
//           from the next instruction address (JAL), a value read from memory
//           (lb, lh, etc.) or from the result of an ALU operation (R-type, etc.) 
// -----------------------------------------------------------------------------
// INPUTS
// clk                : system clock
// Opcode      [5:0]  : The operational code of the executing instruction
// ReadData    [15:0] : The value read from the data memory
// ALUResult   [15:0] : The result of an ALU operation
// MemtoReg           : Control line, whether ALUResult or a memory read should be 
//                      written to a register
// LinkAddress [15:0] : The address of the next instruction to execute
// -----------------------------------------------------------------------------
// OUTPUTS
// WriteData   [15:0] : Data to write to the register file
// -----------------------------------------------------------------------------
module MemToRegMux(clk, Opcode, ReadData, ALUResult, MemtoReg, WriteData, LinkAddress);

  `include "parameters.v"

  // ===== INPUTS =====
  input clk;

  input [OP_SIZE-1:0] Opcode;
  input [ADDR_WIDTH-1:0] ReadData;
  input [ADDR_WIDTH-1:0] ALUResult;
  input MemtoReg;
  input [ADDR_WIDTH-1:0] LinkAddress;
  
  // ===== OUTPUTS =====
  output reg [ADDR_WIDTH-1:0] WriteData;

  always @(posedge clk) begin
    #8 if(Opcode == OP_JAL) begin
          WriteData = LinkAddress;
       end else begin
          WriteData = MemtoReg ? ReadData : ALUResult;
       end
  end
  
endmodule
