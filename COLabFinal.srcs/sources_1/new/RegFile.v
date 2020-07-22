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
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    output reg [63:0] op1,
    output reg [63:0] op2,
    input [2:0] state,
    input [63:0] data_out,
    input [6:0] opcode,
    input regwrite
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
    
       
       if(state == 3'b101)
       begin
       
           
           
           if(regwrite == 1)
           begin
               
               if(rd != 5'b0)
               begin     
                X[rd] = data_out;
               end
              
               
                fd = $fopen ("C:\\Xilinx\\reg.txt", "w");
                for (i = 0; i <= 31; i = i + 1) 
                begin
             
                  $fwrite (fd,"%b\n" ,X[i]);
                end
                  $fclose(fd);
                  
           end
           
        end
      
    
    
        if(state == 3'b011)
        begin
    
                i = rs1;
                j = rs2;
                dest = rd;    
                op1 = X[i];
                op2 = X[j];
                
                     
        end
       
    end
endmodule
