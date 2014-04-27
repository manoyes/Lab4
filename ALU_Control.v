module ALU_Control(ALUOp, Function, Operation);
  input [1:0] ALUOp;  
  input [5:0] Function;
  
  output [5:0] Operation;
  
  reg [5:0] Operation;
  
  always @(ALUOp or Function) begin
    case (ALUOp)
      2'b00 : begin // Load/Store
        Operation = 6'b000001; // ADD
      end
      2'b01 : begin // Branch
        Operation = 6'b000010; // SUB
      end
      2'b10 : begin // R-type
        case (Function)
          6'b100000 : Operation = 6'b000001; // ADD					
          6'b100010 : Operation = 6'b000010; // SUB
          6'b100100 : Operation = 6'b000011; // AND
          6'b100111 : Operation = 6'b000100; // NOR
          6'b100101 : Operation = 6'b000101; // OR        
          6'b101010 : Operation = 6'b001000; // SLT
        
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
