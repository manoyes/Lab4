module Data_memory(clk, MemRead, MemWrite, Address, WriteData, ReadData, mode);

`include "parameters.v"

input clk;
input [ADDR_WIDTH-1:0] Address;
input [ADDR_WIDTH-1:0] WriteData;
input MemRead, MemWrite;
input mode;

output [ADDR_WIDTH:0] ReadData;

reg [MEM_WIDTH-1:0] Mem[0:2 << ADDR_WIDTH - 1];
reg [MEM_WIDTH-1:0] a1,a2;

initial $readmemb("DataMem.txt",Mem); 

initial begin
  a1 = 0;
  a2 = 0;
end

always @(posedge clk) begin  
  #6 if(Address != 0)begin    
        if(MemRead==1) begin		
          if(mode==MODE_BYTE) begin
            a1 = Mem[Address];
            $display("Byte read from address %d value 0x%h",Address, a1);
          end else if (mode==MODE_HALFWORD) begin
            	a1 = Mem[Address];
             a2 = Mem[Address+1];
             $display("Halfword read from address %d value 0x%h",Address, {a1, a2});
         	end
        end
    
      if (MemWrite==1) begin
        if(mode==MODE_BYTE) begin
          Mem[Address] = WriteData[15:8];
         	$display("Byte write in address %d value 0x%h",Address, WriteData[15:8]);
        end else if (mode==MODE_HALFWORD) begin
          Mem[Address] = WriteData[15:8];
          Mem[Address+1] = WriteData[7:0];
          $display("Memory write in address %d value 0x%h",Address, {WriteData[15:8], WriteData[7:0]});
        end
      end
    end
end

assign ReadData = (mode == MODE_BYTE) ? {a1, 8'b00000000} : {a1, a2};

endmodule