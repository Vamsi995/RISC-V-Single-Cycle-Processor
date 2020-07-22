`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2020 04:48:38
// Design Name: 
// Module Name: RegFile
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



module RegFile(
    input clk,
    input reset,
    input [31:0] ins,
    output reg [4:0] rs1,rs2,rd,
    output reg [6:0] funct7,
    output reg [6:0] opcode,
    output reg [2:0] funct3, 
    output reg [63:0] op1,op2
    

    );
    
    reg [63:0] X [0:31];  
    integer i,j,dest,temp,data_file,scan_file,fd,k;    
    reg [63:0] captured_data; 

    
    
`define NULL 0    
initial begin
         data_file = $fopen("C:\\Xilinx\\reg.txt", "r");
          if (data_file == `NULL) begin
            $finish;
          end
          
        for(temp = 0;temp<=31;temp = temp + 1)
            begin
                scan_file = $fscanf(data_file, "%b", captured_data);
                X[temp] = captured_data;
            
            end
      
      
end
    
   
always@(posedge clk)
    begin
    
    
                funct7 = temp[31:25]; 
                rs2 = temp[24:20];
                rs1 = temp[19:15];
                funct3 = temp[14:12];
                rd = temp[11:7];
                opcode = temp[6:0];       
    

            i = rs1;
            j = rs2;
            dest = rd;    
            op1 = X[i];
            op2 = X[j];
   
       
    end
    


    

endmodule
