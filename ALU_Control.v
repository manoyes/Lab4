// -----------------------------------------------------------------------------
// MODULE: ALU_Control
// -----------------------------------------------------------------------------
// PURPOSE : Converts instructions into simple ALU Operation codes.
// -----------------------------------------------------------------------------
// INPUTS
// clk              : system clock
// ALUOp      [1:0] : Control line, specifies branch, load/store, R-type, or I-type 
// Function   [5:0] : The instruction's function code (R-type, etc.)
// Opcode     [5:0] : The instruction's operation code (I-type, branches, etc.)
// -----------------------------------------------------------------------------
// OUTPUTS
// Operation        : The ALU Operation to perform
// -----------------------------------------------------------------------------
module ALU_Control(clk, ALUOp, Function, Opcode, Operation);

  `include "parameters.v"

  // ===== INPUTS =====
  input clk;
  input [1:0] ALUOp;  
  input [FUNC_SIZE-1:0] Function;
  input [OP_SIZE-1:0] Opcode;
  
  // ===== OUTPUTS =====
  output [OP_SIZE-1:0] Operation;
  
  reg [OP_SIZE-1:0] Operation;
  
  always @(posedge clk) begin
    #3 case (ALUOp)
      2'b00 : begin // Load/Store
          Operation = ALU_ADD; // ADD
      end
      2'b01 : begin // Branch
        case (Opcode)
            OP_BEQ  : Operation = ALU_BEQ; // BEQ
            OP_BGEZ : Operation = ALU_BGEZ; // BEQ
        endcase
      end
      2'b10 : begin // R-type
        case (Function)
            F_ADD  : Operation = ALU_ADD;					
            F_SUB  : Operation = ALU_SUB; 
            F_AND  : Operation = ALU_AND;
            F_NOR  : Operation = ALU_NOR;
            F_OR   : Operation = ALU_OR;        
            F_SLT  : Operation = ALU_SLT;
        
            F_DIV  : Operation = ALU_DIV;
            F_MULT : Operation = ALU_MULT;      				
            F_MFHI : Operation = ALU_MFHI;
            F_MFLO : Operation = ALU_MFLO;
            F_SLL  : Operation = ALU_SLL;
            F_SRL  : Operation = ALU_SRL;
            
            F_JR   : Operation = ALU_ADD;
        endcase
      end
      2'b11 : begin // I-type
        case (Opcode)
            OP_ADDI : Operation = ALU_ADD;
    		      OP_ORI  : Operation = ALU_OR;
		        OP_ANDI : Operation = ALU_AND;
		        OP_SLTI : Operation = ALU_SLT;
  		        OP_LUI  : Operation = ALU_LUI;
        endcase
      end
    endcase
  end
endmodule
