module tb();
    reg [3:0] A;
    reg [3:0] B;
    
    wire [7:0] prod;
    integer i,j,error;
    
    // wallace m1 (.A(A),.B(B),.prod(prod));
    initial begin
        error = 0;
        for(i = 0;i <= 15;i = i+1)
            for(j = 0;j <= 15;j = j+1) begin
                A <= i;
                B <= j;
                #1;
                if (prod != A*B)
                    error = error + 1;
            end
        $display("%d",error);
    end
endmodule
