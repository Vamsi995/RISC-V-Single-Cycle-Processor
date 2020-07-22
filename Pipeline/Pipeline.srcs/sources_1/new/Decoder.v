`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2020 04:48:02
// Design Name: 
// Module Name: Decoder
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


module Decoder(
        input [31:0] ins,
        output reg [4:0] rs1,rs2,rd,
        output reg [6:0] funct7,
        output reg [6:0] opcode,
        output reg [2:0] funct3 
    );
    
    wire [31:0] temp = ins;

    
always@(ins)
    begin

              
                funct7 = temp[31:25]; 
                rs2 = temp[24:20];
                rs1 = temp[19:15];
                funct3 = temp[14:12];
                rd = temp[11:7];
                opcode = temp[6:0];                     
      
          

    end  
     
endmodule

