
module booth_multiplier(
    output [15:0] ans,
    input [7:0] m1,r,
    input clk,rst,start,
    output reg ready
    );

    wire [8:0] m;
    
    reg [8:0] P_tempH,P_tempL;  
    wire signed[17:0] P;   
    wire signed[8:0] A,S;   
    reg carry;   
    reg [2:0] count;
    reg state;

    assign P={P_tempH[8],P_tempH,P_tempL[8:1]};
    // assign ready=(state==idle);
    assign ans = P[16:1]; 
    assign m = {m1[7],m1[7],m1[6:0]};
    parameter idle = 2'b00,busy = 2'b01;
    assign A = m;    
    assign S = ~m+1'b1;  

    always@(posedge clk, negedge rst)  
        if (!rst) begin
            P_tempH <= 9'b0;
            P_tempL <= 9'b0;
            state <= idle;
            ready<=1'b1;
        end 
        else begin
            case(state)
            idle: begin
                if(start) begin
                    P_tempH <= {8'b0000000,r[7]};
                    P_tempL <= {r[6:0],2'b0};
                    count<=3'd0;
                    state<=busy;
                    ready<=1'b0;
                end
                else begin
                    ready<=1'b1;
                end
            end
            busy: begin
                case(P[1:0])
                    2'b01 : {carry,P_tempH} <= P[17:9]+A;
                    2'b10 : {carry,P_tempH} <= P[17:9]+S;
                    2'b00 : P_tempH <= P[17:9];
                    2'b11 : P_tempH <= P[17:9];
                endcase
                P_tempL<=P[8:0];
                if(count!=3'd7)begin
                    count<=count+1;
                end
                else begin
                    count<=3'b0;
                    state<=idle;
                end
            end
            default: state<=idle;
            endcase
        end
endmodule 

