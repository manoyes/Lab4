module ALU(clk, in1, in2, ALUOperation, Zero, ALUResult, shamt);

 `include "parameters.v"
 
  // ===== INPUTS =====
  input clk;
  input signed [ADDR_WIDTH-1:0] in1;
  input signed [ADDR_WIDTH-1:0] in2;
  input [OP_SIZE-1:0] ALUOperation;
  input [4:0] shamt;

  // ===== OUTPUTS =====
  output Zero;
  output signed [ADDR_WIDTH-1:0] ALUResult;

  reg Zero;
  reg [ADDR_WIDTH-1:0] ALUResult;
  reg [(ADDR_WIDTH*2)-1:0] Prod_reg;

  always @(posedge clk) begin

    #5 case (ALUOperation)
      ALU_ADD : ALUResult = in1 + in2; // ADD, ADDI, LB, LH, SB, SH
      ALU_SUB : ALUResult = in1 - in2; // SUB
      ALU_AND : ALUResult = in1 & in2; // AND, ANDI
      ALU_NOR : ALUResult = ~(in1 | in2); // NOR
      ALU_OR : ALUResult = in1 | in2; // OR, ORI
      ALU_LUI : ALUResult = in2; // LUI
      ALU_SLT : ALUResult = (in1 < in2)? 1 : 0; // SLT, SLTI
      ALU_BEQ : Zero = (in1 == in2) ? 1 : 0; // BEQ
      ALU_BGEZ : Zero = (in1 >= 0) ? 1 : 0; // BGEZ
      ALU_DIV : Prod_reg = in1 / in2; // DIV
      ALU_MULT : Prod_reg = in1 * in2; // MULT
      ALU_MFHI : ALUResult = Prod_reg[31:16]; // MFHI
      ALU_MFLO : ALUResult = Prod_reg[15:0]; // MFLO
      ALU_SLL : ALUResult = in2 << shamt; // SLL
      ALU_SRL : ALUResult = in2 >> shamt; // SRL
  
    endcase
  
    $display("in1: %d in2: %d shamt: %d ALUResult=%d",in1, in2, shamt,$signed(ALUResult));
  end
endmodule