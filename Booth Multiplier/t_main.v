`include "main.v"

module t_booth_multiplier; 
  wire[15:0] t_ans;  
  reg [7:0] t_m,t_r;   
  reg t_clk,t_rst,t_shift_control;  
  reg t_start;
  wire ready;
  booth_multiplier m1(t_ans,t_m,t_r,t_clk,t_rst,t_start,t_ready); 
  initial begin 
    t_clk=1'b0;   
    t_start=1'b0;
    t_shift_control=1'b0;  
    t_m=8'b0100001;  
    t_r=8'b0010100;  
    t_rst=1'b0; 
    #5 t_rst=1'b1; 
    repeat(50) 
    #5 t_clk = ~t_clk;  
  end 
  initial begin   
    #15 t_shift_control = 1'b1;
    t_start=1'b1;
    #20 t_start=1'b0;
    #90 $finish; 
  end 
  initial begin
        $dumpfile("booth_multiplier.vcd");
        $dumpvars;
    end
endmodule //2033
