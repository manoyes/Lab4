module newAddressMux (clk, Jump, OldPC, JumpOffset, Branch, Zero, BranchOffset, NewPC, JumpFromReg, ReadData1);
  
  `include "parameters.v"
  
  input clk;
  
  input Jump;
  input [15:0] OldPC;
  input [25:0] JumpOffset;
  input Branch;
  input Zero;
  input [15:0] BranchOffset;
  input JumpFromReg;
  input [15:0] ReadData1;
  
  output [31:0] NewPC;
  
  reg [31:0] NewPC;
  
  always @(posedge clk) begin 
    #9 if (Jump) begin
          if (JumpFromReg) begin
            NewPC = ReadData1; // jr
          end else begin
            NewPC = {OldPC + 4, JumpOffset << 2}; // j or jal
          end
       end else if (Branch & Zero) begin
          NewPC = (OldPC + 4) + (BranchOffset << 2); // branches
       end else begin
          NewPC = (OldPC + 4); // sequential increment
       end
    
    //NewPC = Jump ? {OldPC + 4, JumpOffset << 2} : 
    //                  ((Branch & Zero) ? (OldPC + 4) + (BranchOffset << 2) :
    //                                     (OldPC + 4));
  end
endmodule
