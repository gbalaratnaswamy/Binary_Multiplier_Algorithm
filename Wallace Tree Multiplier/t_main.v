`include "main.v"

module tb();
    reg [7:0] A;
    reg [7:0] B;
    
    wire [15:0] prod;
    integer i,j,error;
    
    wallace_multiplier m1 (prod,A,B);
    initial begin
        error = 0;
        for(i = 0;i <= 255;i = i+1)
            for(j = 0;j <= 255;j = j+1) begin
                A <= i;
                B <= j;
                #1;
                if (prod != A*B)
                    error = error + 1;
            end
        $display("%d",error);
    end
endmodule
