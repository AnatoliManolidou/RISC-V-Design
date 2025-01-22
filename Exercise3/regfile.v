module regfile #(parameter DATAWIDTH = 32, parameter NumRegs = 32)(
  input clk,
  input [4:0] readReg1,
  input [4:0] readReg2,
  input [4:0] writeReg,
  input [DATAWIDTH - 1:0] writeData,
  input write,
  output reg [DATAWIDTH - 1:0] readData1,
  output reg [DATAWIDTH - 1:0] readData2
); 
  
  reg [DATAWIDTH - 1:0] registers [0:NumRegs - 1]; 
  integer i;
  
  initial begin 
    for (i = 0; i < NumRegs; i++) 
      registers [i] = 0; //Initialize registers to 0 
  end 
  
  always@(posedge clk) begin
    
    //Reading the register values from every output
    readData1 <= registers [readReg1]; 
    readData2 <= registers [readReg2]; 
    
    if(write)begin
      	
      registers [writeReg] <= writeData; //Passing data from writeData to the address that we have 
    
       if(writeReg == readReg1)begin //If write address is the same as read address1
          readData1 <= writeData;
       end if(writeReg == readReg2)begin //If write address is the same as read address2
          readData2 <= writeData;
  	   end
    end 
  end
  
endmodule