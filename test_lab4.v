module test_lab4;
reg clk;

CPU cpu(clk);

initial // Clock generator
  begin
    clk = 0;
    forever #40 clk = !clk;
  end
  
endmodule