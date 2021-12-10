
module booth_multiplier(
    output [15:0] ans,
    input [7:0] m,r,
    input clk,rst,start,
    output reg ready
    );

    reg signed[16:0] P_temp;  
    wire signed[16:0] P;   
    reg signed[16:0] A,S;   
    reg carry;   
    reg [2:0] count;
    reg state;
    wire most_neg;

    assign P=P_temp>>>1;
    // assign ready=(state==idle);
    assign ans = most_neg?~P[16:1]+1:P[16:1]; 

    parameter idle = 2'b00,busy = 2'b01;

    

    assign most_neg=(m==8'b10000000)&&(r!=8'b0);

    always@(posedge clk, negedge rst)  
        if (!rst) begin 
            A <= 17'b0;
            S <= 17'b0;
            P_temp <= 17'b0;
            state <= idle;
            ready<=1'b1;
        end 
        else begin
            case(state)
            idle: begin
                if(start)begin
                    A <= {m,9'b000000000};    
                    S <= {~m+1'b1,9'b000000000};  
                    P_temp <= {7'b0000000,r,2'b0};
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
                    // P_temp<={P_temp[16],P_temp[15:0]};
                    state<=idle;
                end
            end
            default: state<=idle;
            endcase
        end
endmodule 

