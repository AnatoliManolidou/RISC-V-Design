`include "alu.v"
`include "calc_enc.v"

module calc(
  input clk,
  input btnc,
  input btnl,
  input btnu,
  input btnr,
  input btnd,
  input [15:0] sw,
  output reg [15:0] led
);
  
  reg [15:0] accumulator;
  wire [3:0] alu_op;
  wire [31:0] result;
  
  always@(posedge clk) begin //At positive edge of clock for synchronous update of accumulator's value
    led <= accumulator; //Update LED output with accumulator's value
    if(btnu) begin
    	accumulator <= 16'b0;//When pressing btnu accumulator is set to 0
 	end
    if (btnd) begin
      accumulator <= result[15:0];//When pressing btnd accumulator is updated
  	end
  end  
  
  calc_enc calc_enc_instantiation( //calc_enc instant
    .btnc(btnc),
    .btnr(btnr),
    .btnl(btnl),
    .alu_op(alu_op)
  );
  
  alu alu_instantiation( //alu instant
    .op1({{16{accumulator[15]}}, accumulator}),
    .op2({{16{sw[15]}}, sw}),
    .alu_op(alu_op),
    .zero(zero),
    .result(result)
  );
endmodule