module newAddressMux (clk, Jump, OldPC, JumpOffset, Branch, Zero, BranchOffset, NewPC);
  input clk;
  
  input Jump;
  input [15:0] OldPC;
  input [25:0] JumpOffset;
  input Branch;
  input Zero;
  input [15:0] BranchOffset;
  
  output [31:0] NewPC;
  
  reg [31:0] NewPC;
  
  always @(posedge clk) begin 
    #9 NewPC = Jump ? {OldPC + 4, JumpOffset << 2} : 
                      ((Branch & Zero) ? (OldPC + 4) + (BranchOffset << 2) :
                                         (OldPC + 4));
  end
endmodule
