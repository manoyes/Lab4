module CPU(clk);

  input clk;

  reg rst;

  reg [15:0] NewPC;
  reg [15:0] OldPC;
  reg [15:0] PC_4;
  reg [31:0] Instruction;
  reg [15:0] WriteData;
  reg [15:0] ReadData1;
  reg [15:0] ReadData2;

  reg RegDst;
  reg Branch;
  reg MemRead;
  reg MemtoReg;
  reg [1:0] ALUOp;
  reg MemWrite;
  reg ALUSrc;
  reg RegWrite;

  reg [5:0] ALUOperation;
  reg Zero;

  reg mode;

  reg BrancherResult;

  reg [31:0] Prod_reg;

    Program_Counter     PC(.clk           (clk), 
                           .NewAddress    (NewPC),
                           .ReadAddress   (OldPC));
  
    ALU pc_incrementer(.rst       (rst),
                      .ReadData1 (OldPC),
                      .ReadData2 (4),
                      .Control   (6'b000000),
                      .WriteData (PC_4));
                     
    Instruction_memory  IM(.ReadAddress   (OldPC), 
                           .Instruction   (Instruction));
  
    RegFile  RF(.rst           (rst), 
                .ReadRgAddr1   (Instruction[24:21]), 
                .ReadRgAddr2   (Instruction[19-16]), 
                .WriteRgAddr   (Instruction[14-11]), 
                .WriteData     (WriteData), 
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
                     .RegWrite  (RegWrite));              
  
    ALU_Control alu_control (.ALUOp       (ALUOp),
                             .Function    (Instruction[5:0]),
                             .Operation   (ALUOperation));
                
    mux2to1 regfile_to_alu(.in1   (ReadData2),
                           .in2   ({16'b0000000000000000, Instruction[15:0]}),
                           .sel   (ALUSrc),
                           .out   (ALUIn2));
                           
    ALU alu(.in1            (ReadData1), 
            .in2            (ALUIn2), 
            .ALUOperation   (ALUOperation), 
            .Zero           (Zero),
            .ALUResult      (WriteData));
            
    Data_memory DM(.MemRead     (MemRead), 
                   .MemWrite    (MemWrite),
                   .Address     (Address), 
                   .WriteData   (WriteData),
                   .ReadData    (ReadData),
                   .mode        (mode));

    mux2to1 mem_to_regfile(.in1   (Instruction[20:16]),
                           .in2   (Instruction[15:11]),
                           .sel   (RegDst),
                           .out   (WriteData));
                       
    ALU brancher(.rst         (rst),
                .ReadData1    (PC_4),
                .ReadData2    (Instruction[15:0] << 2),
                .ALUOperation (6'b000000),
                .ALUResult    (BrancherResult));
    
    mux3to1 adder_to_pc();
  
endmodule