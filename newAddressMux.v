// -----------------------------------------------------------------------------
// MODULE: newAddressMux
// -----------------------------------------------------------------------------
// PURPOSE : Multiplexor, decides what the next instruction address should be.
//           Accounts for jumps, branches, and sequential increments.
// -----------------------------------------------------------------------------
// INPUTS
// clk                 : system clock
// Jump                : Whether the current instruction is a jump
// OldPC        [15:0] : The address of the currently executing instruction
// JumpOffset   [25:0] : The instruction memory offset from the current address to 
//                       jump to
// Branch              : Whether the current instruction is a branch
// Zero                : Whether the result of an ALU Operation was zero
// BranchOffset [15:0] : The instruction memory offset from the current address to 
//                       branch to
// JumpFromReg         : Whether or not the instruction calls for a jump to a 
//                       register value
// ReadData1    [15:0] : The value from the first specified register (rs)
// -----------------------------------------------------------------------------
// OUTPUTS
// NewPC        [31:0] : The address of the next instruction to execute
// -----------------------------------------------------------------------------

module newAddressMux (clk, Jump, OldPC, JumpOffset, Branch, Zero, BranchOffset, NewPC, JumpFromReg, ReadData1);
  
  `include "parameters.v"
  
  // ===== INPUTS =====
  input clk;
  
  input Jump;
  input [15:0] OldPC;
  input [25:0] JumpOffset;
  input Branch;
  input Zero;
  input [15:0] BranchOffset;
  input JumpFromReg;
  input [15:0] ReadData1;
  
  // ===== OUTPUTS =====
  output [15:0] NewPC;
  
  reg [15:0] NewPC;
  
  always @(posedge clk) begin 
    #9 if (Jump) begin
          if (JumpFromReg) begin
            NewPC = ReadData1; // jr
          end else begin
            NewPC = {JumpOffset << 2}; // j or jal
          end
       end else if (Branch & Zero) begin
          NewPC = (OldPC + 4) + (BranchOffset << 2); // branches
       end else begin
          NewPC = (OldPC + 4); // sequential increment
       end    
  end
endmodule
