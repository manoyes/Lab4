module CPU(clk);

  input clk;

  reg rst;

  wire [15:0] NewPC;
  wire [15:0] OldPC;
  wire [15:0] PC_4;
  wire [31:0] Instruction;
  wire [15:0] WriteData;
  wire [15:0] ReadData1;
  wire [15:0] ReadData2;
  
  wire [15:0] ReadData;
  
  wire [15:0] ALUResult;
  
  wire [15:0] ALUIn2;

  wire RegDst;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUOp;
  wire MemWrite;
  wire ALUSrc;
  wire RegWrite;
  wire Jump;

  wire [5:0] ALUOperation;
  wire Zero;

  wire mode;

  wire BrancherResult;

  //reg [31:0] Prod_reg; 
  
  initial begin
    rst = 0;
  end  
  
  Program_Counter     PC(.clk           (clk),
                         .rst           (rst),
                         .NewAddress    (NewPC),
                         .ReadAddress   (OldPC));
                         
  mux2to1 pcChange (.in1    (OldPC + 16'b0000000000000100),
                    .in2    ((OldPC + 16'b0000000000000100) + (Instruction[15:0] << 2)),
                    .sel    (Branch & Zero),
                    .out    (NewPC));
                     
  Instruction_memory  IM(.ReadAddress   (OldPC), 
                         .Instruction   (Instruction));
  
  RegFile  RF(.rst           (rst), 
              .ReadRgAddr1   (Instruction[25:21]), 
              .ReadRgAddr2   (Instruction[20:16]), 
              .WriteRgAddr   (RegDst ? Instruction[15:11] : Instruction[20:16]), 
              .WriteData     (MemtoReg ? ReadData : ALUResult), 
              .ReadData1     (ReadData1), 
              .ReadData2     (ReadData2));

  Control control (.Opcode    (Instruction[31:26]), 
                   .RegDst    (RegDst), 
                   .Branch    (Branch), 
                   .MemRead   (MemRead), 
                   .MemtoReg  (MemtoReg), 
                   .ALUOp     (ALUOp), 
                   .MemWrite  (MemWrite), 
                   .ALUSrc    (ALUSrc), 
                   .RegWrite  (RegWrite),
                   .Jump      (Jump));              
  
  ALU_Control alu_control (.ALUOp       (ALUOp),
                           .Function    (Instruction[5:0]),
                           .Operation   (ALUOperation));
  
  ALU alu(.in1            (ReadData1), 
          .in2            (ALUSrc ? Instruction[15-0] : ReadData2), 
          .ALUOperation   (ALUOperation), 
          .Zero           (Zero),
          .ALUResult      (ALUResult));
          
  Data_memory DM(.MemRead     (MemRead), 
                 .MemWrite    (MemWrite),
                 .Address     (ALUResult), 
                 .WriteData   (ReadData2),
                 .ReadData    (ReadData),
                 .mode        (mode));

endmodule