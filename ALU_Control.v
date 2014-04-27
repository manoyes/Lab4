module ALU_Control(clk, ALUOp, Function, Operation);

  `include "parameters.v"

  input clk;
  input [1:0] ALUOp;  
  input [FUNC_SIZE-1:0] Function;
  
  output [OP_SIZE-1:0] Operation;
  
  reg [OP_SIZE-1:0] Operation;
  
  always @(ALUOp or Function) begin
    #3 case (ALUOp)
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
        
          //6'b011010 : Operation = 6'b001011; // div	
          //6'b011000 : Operation = 6'b001100; // mult       				
          //6'b010000 : Operation = 6'b001101; // mfhi
          //6'b010010 : Operation = 6'b001110; // mflo
          //6'b000000 : Operation = 6'b001111; // sll
          //6'b000010 : Operation = 6'b010000; // srl
          //6'b001000 : Operation = 6'b000001; // jr, jal
        endcase
      end
    endcase
  end
endmodule
