`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2020 05:57:47
// Design Name: 
// Module Name: dataMem
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



module DataMem(
    input clk,
    input reset,
    input [63:0] final,
    input memwrite,
    input memread,
    input memtoreg,
    input [2:0] state,
    input [63:0] op2,
    output reg [63:0] data
    );
    
    reg [63:0] M [0:100];
    reg [63:0] ind;
    integer data_file;
    integer scan_file;
    integer i,fd;
    reg [63:0] captured_data;
    
    `define NULL 0 
    initial 
    begin
        
          data_file = $fopen("C:\\Xilinx\\sample.txt", "r");
          if (data_file == `NULL) begin
            $finish;
          end
          
        for(i = 0;i<=99;i = i + 1)
            begin
                scan_file = $fscanf(data_file, "%b", captured_data);
                M[i] = captured_data;            
            end
    
    end
    
    
    
always@(posedge clk)
begin

    if(state == 3'b100)
    begin
            if(memread == 1)
            begin
               data = M[final];        
            end

            if(memwrite == 1)
            begin
                M[final] = op2;
                fd = $fopen ("C:\\Xilinx\\sample.txt", "w");
                for (i = 0; i <= 99; i = i + 1) begin
                  $fwrite (fd,"%b\n" ,M[i]);
                end
                $fclose(fd); 
            end
          //MUX
              if(memtoreg == 0)
              begin
                data = final;
              end
     end
 end    
endmodule
