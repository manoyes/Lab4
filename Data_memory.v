`timescale 1ps / 1ps
module Data_memory(MemRead, MemWrite, Address, WriteData, ReadData, mode);

input [15:0] Address;
input [15:0] WriteData;
input MemRead, MemWrite;
input mode;

output [15:0] ReadData;

reg [7:0] Mem[0:65535];
reg [7:0] a1,a2;

initial $readmemb("DataMem.txt",Mem); 

initial begin
  a1 = 0;
  a2 = 0;
end

always @(Address) begin
if(Address!=0)
	if(MemRead==1)
	begin
		
		if(mode==0)
			begin
			#5 a1 = Mem[Address];
			$display("Memory read from address %h value %h",Address, a1);
			end
		else
		begin
			#5 a1 = Mem[Address];
			a2 = Mem[Address+1];
			$display("Memory read from address %h value %h",Address, {a1, a2});
		end
	end
	else if (MemWrite==1)
	begin
		if(mode==0)
			begin
			#5 Mem[Address] = WriteData[15:8];
			$display("Memory write in address %h value %h",Address, WriteData[15:8]);
			end
		else
		begin
			#5 Mem[Address] = WriteData[15:8];
			Mem[Address+1] = WriteData[7:0];
			$display("Memory write in address %h value %h",Address, {WriteData[15:8], WriteData[7:0]});
		end
	end
end
assign ReadData = mode==0? {a1, 8'b00000000} : {a1, a2};

endmodule