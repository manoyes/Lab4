module ALU_Control(clk, ALUOp, Function, Opcode, Operation);

  `include "parameters.v"

  input clk;
  input [1:0] ALUOp;  
  input [FUNC_SIZE-1:0] Function;
  input [OP_SIZE-1:0] Opcode;
  
  output [OP_SIZE-1:0] Operation;
  
  reg [OP_SIZE-1:0] Operation;
  
  always @(ALUOp or Function) begin
    case (ALUOp)
      2'b00 : begin // Load/Store
          Operation = ALU_ADD; // ADD
      end
      2'b01 : begin // Branch
          Operation = ALU_SUB; // SUB
      end
      2'b10 : begin // R-type
        case (Function)
            F_ADD : Operation = ALU_ADD;					
            F_SUB : Operation = ALU_SUB; 
            F_AND : Operation = ALU_AND;
            F_NOR : Operation = ALU_NOR;
            F_OR : Operation = ALU_OR;        
            F_SLT : Operation = ALU_SLT;
        
          //F_DIV : Operation = ALU_DIV; // div	
          //F_MULT : Operation = ALU_MULT; // mult       				
          //F_MFHI : Operation = ALU_MFHI; // mfhi
          //F_MFLO : Operation = ALU_MFLO; // mflo
            F_SLL : Operation = ALU_SLL; // sll
            F_SRL : Operation = ALU_SRL; // srl
          //6'b001000 : Operation = 6'b000001; // jr, jal
        endcase
      end
      2'b11 : begin // I-type
        case (Opcode)
            OP_ADDI :  Operation = ALU_ADD;
    		      OP_ORI  :  Operation = ALU_OR;
		        OP_ANDI :  Operation = ALU_AND;
		        OP_SLTI :  Operation = ALU_SLT;
  		        OP_LUI  :  Operation = ALU_LUI;
        endcase
      end
    endcase
  end
endmodule
