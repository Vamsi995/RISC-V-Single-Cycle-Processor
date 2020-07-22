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
        input clk,
        input reset,
        output reg [4:0] rs1,rs2,rd,
        output reg [6:0] funct7,
        output reg [6:0] opcode,
        output reg [2:0] funct3,
        input [2:0] state
      
    );
    
    wire [31:0] temp = ins;

    
always@(posedge clk)
    begin
    if(state == 3'b010)
    begin
    
        if(reset)
        begin           
            funct7 = 7'b0;
            rs1 = 5'b0;
            rs2 = 5'b0;
            rd = 5'b0;
            funct3 = 3'b0;
            opcode = 7'b0;        
        end
        
        else
        begin            
                funct7 = temp[31:25]; 
                rs2 = temp[24:20];
                rs1 = temp[19:15];
                funct3 = temp[14:12];
                rd = temp[11:7];
                opcode = temp[6:0];                     
        end 
        
          
    end
end  
     
endmodule

