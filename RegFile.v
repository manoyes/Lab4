module RegFile(rst, ReadRgAddr1, ReadRgAddr2, WriteRgAddr, WriteData, ReadData1, ReadData2);
  
// ===== INPUTS =====
input rst;
input [4:0] ReadRgAddr1;
input [4:0] ReadRgAddr2;
input [4:0] WriteRgAddr;
input [15:0] WriteData;

// ===== OUTPUTS =====  

output ReadData1;
output ReadData2;

reg [15:0] ReadData1;
reg [15:0] ReadData2;

reg [15:0] datastore[15:0]; // Memory storage

  // WRITE TO DATA STORE
  always @ (ReadRgAddr1) begin    
    
    datastore[4'b0000] = 16'b0000000000000000;
    
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
        
    if (WriteRgAddr > 4'b0000) // R0 is hardwired to 0, writing to it discards the value.
        datastore[WriteRgAddr] = WriteData; 
    
    ReadData1 = datastore[ReadRgAddr1];
    ReadData2 = datastore[ReadRgAddr2];
    
  end
  
endmodule
