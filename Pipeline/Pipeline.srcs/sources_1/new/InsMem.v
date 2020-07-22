`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2020 04:47:22
// Design Name: 
// Module Name: InsMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InsMem(
    input clk,
    input reset,
    input [63:0] pc,
    output reg [31:0] out
    );
    
integer  data_file    ; // file handler
integer  scan_file    ; // file handler
reg [31:0] captured_data;
reg [31:0] I [0:100];
integer i;
reg [63:0] temp;

`define NULL 0    
initial begin
  data_file = $fopen("C:\\Xilinx\\ins.txt", "r");
  if (data_file == `NULL) begin
    $finish;
  end
  
      for(i = 0;i<=12;i = i + 1)
            begin
                scan_file = $fscanf(data_file, "%b", captured_data);
                I[i] = captured_data;            
            end
  
  
end
      
       
always@(posedge clk)
    begin    
 
            
            temp = pc >> 2;
            
            out = I[temp];
            
          
    end            
endmodule
