`include "alu.v"
`include "regfile.v"

module datapath #(parameter [31:0] INITIAL_PC = 32'h00400000, parameter [6:0] OP_I = 7'b0010011, parameter [6:0] OP_S = 7'b0100011, parameter [6:0] OP_B = 7'b1100011, parameter [6:0] OP_R = 7'b0110011)(
 input clk,
 input rst,
 input wire [31:0] instr,
 input PCSrc,
 input ALUSrc,
 input RegWrite,
 input MemToReg,
 input wire [3:0] ALUCtrl,
 input loadPC,
 output reg [31:0] PC,
 output Zero,
 output reg [31:0] dAddress,
 output reg [31:0] dWriteData,
 input wire [31:0] dReadData,
 output reg [31:0] WriteBackData
);
  
  reg [31:0] writeData;
  wire [31:0] readData1;
  wire [31:0] readData2;
  wire [31:0] alu_result;
  
  wire branch_offset = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; //Branch Target implementation
  
//PC
  
  always @(posedge clk) begin
    if(rst) begin
      PC <= INITIAL_PC;
    end else if (loadPC) begin
      if(PCSrc) begin 
      	PC <= PC + branch_offset;
  	  end else begin
        PC <= PC + 4;
      end
  	end
  end
  
//RegisterFile
  
  regfile regfile_datapath_inst
  (
    .clk(clk),
    .readReg1(instr[19:15]),
    .readReg2(instr[24:20]),
    .writeReg(instr[11:7]),
    .write(RegWrite),
    .writeData(writeData),
    .readData1(readData1),
    .readData2(readData2)
  );
    
//ImmediateGeneration
    
  wire [31:0] immediate_I = {{20{instr[31]}}, instr[31:20]};
  wire [31:0] immediate_S = {{20{instr[31]}}, instr[31:25], instr[11:7]};
  wire [31:0] immediate_B = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
  wire [31:0] immediate_R = 32'b0; //No immediate field for R-types
  
//ALU
    
  assign dAddress = alu_result;
  assign dWriteData = readData2;
  wire [6:0] opcode = instr[6:0];
  reg [31:0] alu_op2;
    
  alu alu_datapath_inst
  (
    .op1(readData1),
    .op2(alu_op2),                                          
    .alu_op(ALUCtrl),
    .zero(Zero),
    .result(alu_result)
  );
                                                               
    always @(*) begin
      if(ALUSrc) begin 
        case(opcode) //from immediate Generation
            OP_I: alu_op2 = immediate_I; //I-type
            OP_S: alu_op2 = immediate_S; //S-type
            OP_B: alu_op2 = immediate_B; //B -type
            OP_R: alu_op2 = immediate_R; //R-type
        endcase
      end else begin
        alu_op2 = readData2; 
      end
    end      
                                                                 
//WriteBack
  
  always @(*) begin
    
     if(MemToReg) begin
        writeData = dReadData;
     end else begin
        writeData = alu_result;
     end
    
     assign WriteBackData = writeData;
  end 
  
endmodule