// -----------------------------------------------------------------------------
// MODULE: Program_Counter
// -----------------------------------------------------------------------------
// PURPOSE : Stores the address of the currently executing instruction and 
//           passes it to instruction memory.
// -----------------------------------------------------------------------------
// INPUTS
// clk                : system clock
// rst                : Code to reset instruction address to 0.
// NewAddress  [15:0] : The address of the next instruction to execute.
// -----------------------------------------------------------------------------
// OUTPUTS
// ReadAddress [15:0] : The address of the next instruction to execute, sent to 
//                      instruction memory.
// -----------------------------------------------------------------------------
module Program_Counter(clk, rst, NewAddress, ReadAddress);
  
  `include "parameters.v"
  
  // ===== INPUTS =====
  input clk;
  input rst;
    
  input [ADDR_WIDTH-1:0] NewAddress;
  
  // ===== OUTPUTS =====
  output [ADDR_WIDTH-1:0] ReadAddress;
  
  reg [ADDR_WIDTH-1:0] ReadAddress;
  reg [INST_WIDTH-1:0] inst_address;
    
  always @(posedge clk) begin
    if (rst)
      inst_address = 0;
    else begin
      if (NewAddress)
        inst_address = NewAddress;
      else
        inst_address = 0;
        
      ReadAddress = inst_address;
    end
    
    $display("==============================");
    $display("ReadAddress is: %d", ReadAddress);
  end
endmodule