module CPU;
  
  `include "parameters.v"

  reg clk;

  reg rst;

  wire [ADDR_WIDTH-1:0] NewPC;
  wire [ADDR_WIDTH-1:0] OldPC;
  wire [ADDR_WIDTH-1:0] PC_4;
  wire [INST_WIDTH-1:0] Instruction;
  wire [ADDR_WIDTH-1:0] WriteData;
  wire [ADDR_WIDTH-1:0] ReadData1;
  wire [ADDR_WIDTH-1:0] ReadData2;
  
  wire [ADDR_WIDTH-1:0] ReadData;
  
  wire [ADDR_WIDTH-1:0] ALUResult;
  
  wire [ADDR_WIDTH-1:0] ALUIn2;

  wire RegDst;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUOp;
  wire MemWrite;
  wire ALUSrc;
  wire RegWrite;
  wire Jump;

  wire [OP_SIZE-1:0] ALUOperation;
  wire Zero;

  wire mode;

  wire BrancherResult;

  //reg [31:0] Prod_reg; 
  
  initial begin
    rst = 0;
    clk = 0;
  end  
  
  always
    #10 clk = !clk;
  
  Program_Counter     PC(.clk           (clk),
                         .rst           (rst),
                         .NewAddress    (NewPC),
                         .ReadAddress   (OldPC));

  newAddressMux       NAM(.clk          (clk),
                          .Jump         (Jump),
                          .OldPC        (OldPC),
                          .JumpOffset   (Instruction[25:0]),
                          .Branch       (Branch),
                          .Zero         (Zero),
                          .BranchOffset (Instruction[15:0]),
                          .NewPC        (NewPC));
                                                   
                     
  Instruction_memory  IM(.clk           (clk),
                         .ReadAddress   (OldPC), 
                         .Instruction   (Instruction));
  
  RegFile  RF(.clk           (clk),
              .rst           (rst), 
              .ReadRgAddr1   (Instruction[25:21]), 
              .ReadRgAddr2   (Instruction[20:16]), 
              .WriteRgAddr   (RegDst ? Instruction[15:11] : Instruction[20:16]), 
              .WriteData     (WriteData), 
              .ReadData1     (ReadData1), 
              .ReadData2     (ReadData2));

  MemToRegMux M2RM(.clk       (clk),
                   .ReadData  (ReadData),
                   .ALUResult (ALUResult),
                   .MemtoReg  (MemtoReg),
                   .WriteData (WriteData));

  Control control (.clk       (clk),
                   .Opcode    (Instruction[31:26]), 
                   .RegDst    (RegDst), 
                   .Branch    (Branch), 
                   .MemRead   (MemRead), 
                   .MemtoReg  (MemtoReg), 
                   .ALUOp     (ALUOp), 
                   .MemWrite  (MemWrite), 
                   .ALUSrc    (ALUSrc), 
                   .RegWrite  (RegWrite),
                   .Jump      (Jump),
                   .mode      (mode));              
  
  ALU_Control alu_control (.clk         (clk),
                           .ALUOp       (ALUOp),
                           .Function    (Instruction[5:0]),
                           .Opcode      (Instruction[31:26]),
                           .Operation   (ALUOperation));
  
  ALU alu(.clk             (clk),
          .in1            (ReadData1), 
          .in2            (ALUSrc ? Instruction[15:0] : ReadData2), 
          .ALUOperation   (ALUOperation), 
          .Zero           (Zero),
          .ALUResult      (ALUResult));
          
  Data_memory DM(.clk         (clk),
                 .MemRead     (MemRead), 
                 .MemWrite    (MemWrite),
                 .Address     (ALUResult), 
                 .WriteData   (ReadData2),
                 .ReadData    (ReadData),
                 .mode        (mode));

//initial
  //$monitor($time, "PC=%b ALUResult=%b Instruction=%b ALUResult=%b", OldPC, ALUResult, Instruction, ALUResult);

endmodule