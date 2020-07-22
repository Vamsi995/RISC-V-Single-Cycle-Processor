`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2020 21:14:19
// Design Name: 
// Module Name: WbReg
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


module WbReg(
    input clk,
    input reset,
    input [63:0] write_data,
    input [63:0] alu_data,
    input regwrite,
    input memtoreg,
    input [4:0] rd,
    output reg [63:0] final
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

always@(negedge clk)
begin


    if(memtoreg == 1)
    begin
        
     if(regwrite == 1)
           begin
               
               if(rd != 5'b0)
               begin     
                X[rd] = write_data;
               end
              
               
                fd = $fopen ("C:\\Xilinx\\reg.txt", "w");
                for (i = 0; i <= 31; i = i + 1) 
                begin
             
                  $fwrite (fd,"%b\n" ,X[i]);
                end
                  $fclose(fd);
                  
           end
    
    end
    
    else
    begin
    
        final = alu_data;
    end






end
endmodule
