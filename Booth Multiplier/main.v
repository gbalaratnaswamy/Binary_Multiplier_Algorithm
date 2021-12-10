
module booth_multiplier(
    output [15:0] ans,
    input [7:0] m,r,
    input clk,rst,start,
    output reg ready
    );

    reg signed[17:0] P_temp;  
    wire signed[17:0] P;   
    reg signed[17:0] A,S;   
    reg carry;   
    reg [2:0] count;
    reg state;
    wire c;
    wire [7:0] t;

    assign P=P_temp>>>1;
    // assign ready=(state==idle);
    assign ans = P[16:1]; 
    assign {c,t}= ~m+1'b1;
    wire most_neg;

    assign most_neg=(m==8'b10000000)&&(r!=8'b0);

    parameter idle = 2'b00,busy = 2'b01;

    always@(posedge clk, negedge rst)  
        if (!rst) begin 
            A <= 18'b0;
            S <= 18'b0;
            P_temp <= 18'b0;
            state <= idle;
            ready<=1'b1;
        end 
        else begin
            case(state)
            idle: begin
                if(start) begin
                    // TODO: correction for most negative number
                    A <= {m[7],m,9'b000000000};    
                    S <= {most_neg?1'b0:t[7],t,9'b000000000};  
                    P_temp <= {1'b0,7'b0000000,r,2'b0};
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
                    2'b01 : {carry,P_temp} <= (P+A);
                    2'b10 : {carry,P_temp} <= (P+S);
                    2'b00 : P_temp <= P;
                    2'b11 : P_temp <= P;
                endcase
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

