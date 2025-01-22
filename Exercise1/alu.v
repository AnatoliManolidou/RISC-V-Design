module alu(
  input [31:0] op1, //Input port op1
  input [31:0] op2, //Input port op2
  input [3:0] alu_op, //Input port alu_op
  output zero, //Output port zero
  output reg [31:0] result //Output port result
);
  
  parameter[3:0] ALUOP_SUB = 4'b0110;//Subtraction
  parameter[3:0] ALUOP_ADD = 4'b0010;//Addition
  parameter[3:0] ALUOP_AND = 4'b0000;//Logical AND
  parameter[3:0] ALUOP_OR = 4'b0001;//Logical OR
  parameter[3:0] ALUOP_LSR = 4'b1000;//Logical Shift Right
  parameter[3:0] ALUOP_LSL = 4'b1001;//Logical Shift Left
  parameter[3:0] ALUOP_ASR = 4'b1010;//Arithmetic Shit Right
  parameter[3:0] ALUOP_LN = 4'b0100;//Less than
  parameter[3:0] ALUOP_XOR = 4'b0101;//XOR
  
  always @ (*) begin
    
    case(alu_op)
	ALUOP_AND:
      result = (op1 & op2);
	ALUOP_OR:
      result = (op1 | op2);
    ALUOP_ADD:
      result = (op1 + op2);
	ALUOP_SUB:
      result = (op1 - op2);
    ALUOP_LN:
      result = (($signed(op1)) < ($signed(op2)));
	ALUOP_LSR:
      result = (op1 >> op2[4:0]);
    ALUOP_LSL:
      result = (op1 << op2[4:0]);
	ALUOP_ASR:
      result = $unsigned((($signed(op1)) >>> (op2[4:0])));  
    ALUOP_XOR:
      result = (op1 ^ op2);   
    endcase
  end  
endmodule  