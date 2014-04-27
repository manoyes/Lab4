module RegFile(clk, rst, ReadRgAddr1, ReadRgAddr2, WriteRgAddr, WriteData, ReadData1, ReadData2, RegWrite, Opcode);
  
  `include "parameters.v"
  
// ===== INPUTS =====
input clk;
input rst;
input [REG_ADDR_WIDTH-1:0] ReadRgAddr1;
input [REG_ADDR_WIDTH-1:0] ReadRgAddr2;
input [REG_ADDR_WIDTH-1:0] WriteRgAddr;
input [ADDR_WIDTH-1:0] WriteData;
input RegWrite;
input [5:0] Opcode;

// ===== OUTPUTS =====  

output ReadData1;
output ReadData2;

reg [ADDR_WIDTH-1:0] ReadData1;
reg [ADDR_WIDTH-1:0] ReadData2;

reg [REG_SIZE-1:0] datastore[ADDR_WIDTH-1:0]; // Memory storage

initial // we will put some values in the registers to test the ALU
begin
datastore[4'b0000] = 0;
datastore[4'b0001] = 10;
datastore[4'b0010] = 20;
datastore[4'b0011] = 30;
datastore[4'b0100] = 40;
datastore[4'b0101] = 50;
datastore[4'b0110] = 60;
datastore[4'b0111] = 70;
datastore[4'b1000] = 80;
datastore[4'b1001] = 90;
datastore[4'b1010] = 100;
datastore[4'b1011] = 110;
datastore[4'b1100] = 120;
datastore[4'b1101] = 500;
datastore[4'b1110] = 140;
datastore[4'b1111] = 9999;
end

  // WRITE TO DATA STORE
  always @ (posedge clk) begin    
    
    datastore[4'b0000] = 16'b0000000000000000;
    //$display("ReadRgAddr1=%b ReadRgAddr2=%b WriteRgAddr=%b",ReadRgAddr1,ReadRgAddr2,WriteRgAddr); 
    //$display("Register 0110 is: %b",datastore[4'b0110]);    
        
    if (rst) begin
      datastore[1] = 16'b0000000000000000;
      datastore[2] = 16'b0000000000000000;
      datastore[3] = 16'b0000000000000000;
      datastore[4] = 16'b0000000000000000;
      datastore[5] = 16'b0000000000000000;
      datastore[6] = 16'b0000000000000000;
      datastore[7] = 16'b0000000000000000;
      datastore[8] = 16'b0000000000000000;            
      datastore[9] = 16'b0000000000000000;
      datastore[10] = 16'b0000000000000000;
      datastore[11] = 16'b0000000000000000;
      datastore[12] = 16'b0000000000000000;
      datastore[13] = 16'b0000000000000000;
      datastore[14] = 16'b0000000000000000;
      datastore[15] = 16'b0000000000000000;
    end
    
    #4 ReadData1 = datastore[ReadRgAddr1];
    ReadData2 = datastore[ReadRgAddr2];  
    $display("Reading register %d is: %d, register %d is: %d", ReadRgAddr1, ReadData1, ReadRgAddr2, ReadData2);  
    
    if (WriteRgAddr > 4'b0000 && RegWrite) // R0 is hardwired to 0, writing to it discards the value.
        #5 if (Opcode == OP_JAL)
            datastore[RETURN_REGISTER] = WriteData;
        else
              datastore[WriteRgAddr] = WriteData; 
        $display("Updated register %d is: %d", WriteRgAddr, datastore[WriteRgAddr]);
    
  end
endmodule
