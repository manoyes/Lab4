module Program_Counter(clk, rst, NewAddress, ReadAddress);
  input clk;
  input rst;
  
  input [15:0] NewAddress;
  output [15:0] ReadAddress;
  
  reg [15:0] ReadAddress;
  reg [31:0] inst_address;
  
  
  always @(posedge clk) begin
    if (rst)
      inst_address = 0;
    else begin
      ReadAddress = inst_address;
      inst_address = NewAddress;
    end
  end
endmodule