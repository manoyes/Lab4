module Program_Counter(clk, rst, NewAddress, ReadAddress);
  
  `include "parameters.v"
  
  input clk;
  input rst;
  
  input [ADDR_WIDTH-1:0] NewAddress;
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
    
    $display("ReadAddress is: %d, New Address is: %d", ReadAddress, NewAddress);
  end
endmodule