`include "pipelined.v"

module tb();
    reg [7:0] A;
    reg [7:0] B;
    reg t_clk,t_rst;  
    wire [15:0] prod;
    integer i,j,error;
    
    wallace_multiplier m1 (prod,A,B,t_clk,t_rst);
    always #5 t_clk=~t_clk;

    initial begin 
        t_clk=1'b0; 
        A=8'b0100001;  
        B=8'b0010100;  
        t_rst=1'b0; 
        #5 t_rst=1'b1;
        
    end

    initial begin
        #2;
        error = 0;
        for(i = 0;i <= 255;i = i+1)
            for(j = 0;j <= 255;j = j+1) begin
                A <= i;
                B <= j;
                #100;
                if (prod != A*B) begin
                    error = error + 1;
                end
                    
            end
        $display("%d",error);
        #10 $finish;
    end
endmodule
