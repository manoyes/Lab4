module MemToRegMux(clk, ReadData, ALUResult, MemtoReg, WriteData);

  input clk;

  input [15:0] ReadData;
  input [15:0] ALUResult;
  input MemtoReg;

  output reg [15:0] WriteData;

  always @(posedge clk) begin
    #8 WriteData = MemtoReg ? ReadData : ALUResult;
  end
  
endmodule
