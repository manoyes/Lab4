module ALU(clk, in1, in2, ALUOperation, Zero, ALUResult);

 `include "parameters.v"
 
  // ===== INPUTS =====
  input clk;
  input signed [ADDR_WIDTH-1:0] in1;
  input signed [ADDR_WIDTH-1:0] in2;
  input [OP_SIZE-1:0] ALUOperation;

  // ===== OUTPUTS =====
  output Zero;
  output signed [ADDR_WIDTH-1:0] ALUResult;

  reg Zero;
  reg [ADDR_WIDTH-1:0] ALUResult;

  always @(posedge clk) begin

    #4 case (ALUOperation)
      ALU_ADD : ALUResult = in1 + in2; // ADD, ADDI, LB, LH, SB, SH
      ALU_SUB : ALUResult = in1 - in2; // SUB, BEQ, BGEZ
      ALU_AND : ALUResult = in1 & in2; // AND, ANDI
      ALU_NOR : ALUResult = ~(in1 | in2); // NOR
      ALU_OR : ALUResult = in1 | in2; // OR, ORI
      ALU_LUI : ALUResult = in2; // LUI
      ALU_SLT : ALUResult = (in1 < in2)? 1 : 0; // SLT, SLTI
      //6'b001001 : ALUResult = (in1 == in2) ? 1 : 0; // BEQ
      //6'b001010 : Zero = (in1 >= in2) ? 1 : 0; // BGEZ
      //6'b001011 : ALUResult = in1 / in2; // DIV
      //6'b001100 : ALUResult = in1 * in2; // MULT
      //6'b001101 : ALUResult = Prod_reg[31:16]; // MFHI
      //6'b001110 : ALUResult = Prod_reg[15:0]; // MFLO
      //6'b001111 : ALUResult = in1 << in2; // SLL
      //6'b010000 : ALUResult = in1 >> in2; // SRL
      //6'b000000 : ALUResult = in1 + in2; // JR
     //6'b000000 : ALUResult = in1 + in2; // JAL
  
    endcase 
    
    Zero = (ALUResult == 0) ? 1 : 0; // BEQ, BEGZ
  
    $display("in1: %d in2: %d ALUResult=%d",in1, in2,ALUResult);
  end
endmodule


/*
always @(INST) begin

if ({ALUOp1, ALUOp0}==2'b00) begin
  Alu_output = ReadData1 + Alu_operand2;
if(Jump==1'b0) //is it a Jump 
begin
	case (op_code) // load or store
		6'b100000: //lb
			begin
				mode = 0;
				Effective_address = Alu_output;
			end
		6'b100001: //lh
			begin
				mode = 1;
				Effective_address = Alu_output;
			end

		6'b101000: //sb
			begin
				mode = 0;
				DataMemory_WriteData = ReadData2;
				Effective_address = Alu_output;
			end
		6'b101001: //sh
			begin
				mode = 1;
				DataMemory_WriteData = ReadData2;
				Effective_address = Alu_output;
			end
	endcase
#6 Effective_address = 0; //wait until memory data is ready
end
else  //Jump type
	begin
		case (op_code) 
		6'b000011: // jal
			begin
				Registers[4'b1111] = PC_4; //save the next address in register 15 ($ra)
			end
		endcase
	end
end
else if ({ALUOp1, ALUOp0}==2'b01) // beq instruction
begin
		case (op_code) 
			6'b000100 : 
				begin
					Alu_output = ReadData1 - Alu_operand2; // beq
					ALU_op_zero = Alu_output==0?1:0;
				end
			6'b000001 : 
				begin
					Alu_output = ReadData1; // bgez
					ALU_op_zero = (Alu_output[15]==1'b0)?1:0;
				end
		endcase
end
if ({ALUOp1, ALUOp0}==2'b11) //I-type as addi, ori, ..
begin
case (op_code) // which I-type instruction
			6'b001100 : Alu_output = ReadData1 & Alu_operand2; // ANDi
			6'b001101 : Alu_output = ReadData1 | Alu_operand2; // ORi
			6'b001000 : 
					begin
						Alu_output = ReadData1 + Alu_operand2; // ADDi
						if((ReadData1[15]==Alu_operand2[15])&&(Alu_output[15]==~ReadData1[15])) //check for over flow
							OF = 1;
					end
			6'b001010 : Alu_output = (ReadData1<Alu_operand2)? 1 : 0; // SLTi
			6'b001111 : Alu_output = Alu_operand2; // lui
		endcase
end
else if ({ALUOp1, ALUOp0}==2'b10)  //R-Type, op_code is 0
	begin
#2  case (funct) //
			6'b100100 : Alu_output = ReadData1 & Alu_operand2; // AND
			6'b100101 : Alu_output = ReadData1 | Alu_operand2; // OR
			6'b100000 : 
					begin
						Alu_output = ReadData1 + Alu_operand2; // ADD
						if((ReadData1[15]==Alu_operand2[15])&&(Alu_output[15]==~ReadData1[15])) //check for over flow
							OF = 1;
					end
			6'b100010 : 
					begin 	
						Alu_output = ReadData1 - Alu_operand2; // SUB
					  if((ReadData1[15]==~Alu_operand2[15])&&(Alu_output[15]!=ReadData1[15])) //check for over flow
							OF = 1;
					end
			6'b101010 : Alu_output = (ReadData1<Alu_operand2)? 1 : 0; // SLT
			6'b100111 : Alu_output = ~(ReadData1 | Alu_operand2); // NOR
			6'b011000 : Prod_reg = ReadData1 * Alu_operand2; // mult
			6'b011010 : 
				begin
					Prod_reg[31:16] = ReadData1 % Alu_operand2; // div
					Prod_reg[15:0] = ReadData1 / Alu_operand2;
				end
			6'b010000 : Alu_output = Prod_reg[31:16]; // mfhi
			6'b010010 : Alu_output = Prod_reg[15:0]; // mflo

			6'b000000 : Alu_output = Alu_operand2<<shamt; // sll
			6'b000010 : Alu_output = Alu_operand2>>shamt; // srl

			6'b001000 : Jump_target = ReadData1; // jr
		endcase
	end 
if((RegWrite==1)&(op3_addr!=0))
	begin
	  #2 Registers[op3_addr] = MemtoReg==0?Alu_output:DataMemory_ReadData;
		$display("Register %d written by a value of %d --- (%h)H",op3_addr, MemtoReg==0?Alu_output:DataMemory_ReadData,MemtoReg==0?Alu_output:DataMemory_ReadData);
	end

$display("Old_PC = %h, INST = %h, ALU Output = %d --- (%h)H",Old_PC, INST,D_out,D_out);
end

assign New_PC = Jump? Jump_target : ((ALU_op_zero&Branch)? PC_immediate:PC_4);
assign {D_out, Over_Flow} = {MemtoReg==0?Alu_output:DataMemory_ReadData , OF}; 
endmodule
*/