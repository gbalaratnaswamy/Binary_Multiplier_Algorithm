`include "main.v"

module t_booth_multiplier; 
  wire signed [15:0] t_ans;  
  reg  signed [7:0] t_m,t_r;   
  reg t_clk,t_rst;  
  reg t_start;
  wire ready;
  integer i,j,error;
  booth_multiplier m1(t_ans,t_m,t_r,t_clk,t_rst,t_start,t_ready); 
  initial begin 
    t_clk=1'b0;   
    t_start=1'b0; 
    t_m=8'b0100001;  
    t_r=8'b0010100;  
    t_rst=1'b0; 
    #5 t_rst=1'b1; 
    // t_m <= 8'b10000000;
    // t_r <= 8'b00000001;
    #1;
    // t_start=1'b1;
    // #20 t_start=1'b0;
    // #100;
    // $display("%d %d %d",t_ans,t_m,t_r);
    // #10 $finish;
    // error = error + 1;
  end
  always #5 t_clk=~t_clk;
  initial begin
        error = 0;
        for(i = 0;i <= 255;i = i+1)
            for(j = 0;j <= 255;j = j+1) begin
                t_m <= i;
                t_r <= j;
                #1;
                t_start=1'b1;
                #20 t_start=1'b0;
                #100;
                if (t_ans != t_m*t_r) begin
                    // $display("%d %d %d",t_ans,t_m,t_r);
                    // #10 $finish;
                    error = error + 1;
                end
                    
            end
        $display("%d",error);
        #10 $finish;
    end
    // initial begin
    //     $dumpfile("booth_multiplier3.vcd");
    //     $dumpvars;
    // end
endmodule 
