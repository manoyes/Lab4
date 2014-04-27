module Program_Counter(clk, rst, NewAddress, ReadAddress);
  
  `include "parameters.v"
  
  input clk;
  input rst;
  
  input [ADDR_WIDTH-1:0] NewAddress;
  output [ADDR_WIDTH-1:0] ReadAddress;
  
  reg [ADDR_WIDTH-1:0] ReadAddress;
  reg [INST_WIDTH-1:0] inst_address;
  
  initial begin
    inst_address = 0;
  end
  
  always @(posedge clk) begin
    if (rst)
      inst_address = 0;
    else begin
      ReadAddress = inst_address;
      inst_address = NewAddress;
    end
  end
endmodule