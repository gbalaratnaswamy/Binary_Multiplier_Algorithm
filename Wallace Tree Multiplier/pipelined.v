module wallace_multiplier(
    output [15:0] ans,
    input [7:0] A,B,
    input clk, rst
    );
    wire [7:0] p0,p1,p2,p3,p4,p5,p6,p7;
    reg [7:0] pr0,pr1,pr2,pr3,pr4,pr5,pr6,pr7;
    assign  p0 = A & {8{B[0]}};
    assign  p1 = A & {8{B[1]}};
    assign  p2 = A & {8{B[2]}};
    assign  p3 = A & {8{B[3]}};
    assign  p4 = A & {8{B[4]}};
    assign  p5 = A & {8{B[5]}};
    assign  p6 = A & {8{B[6]}};
    assign  p7 = A & {8{B[7]}};

    // layer 1
    wire [16:0] s1,c1;
    reg [16:0] sr1,cr1;

    half_adder h11(s1[1],c1[1],pr0[1],pr1[0]);
    full_adder f11(s1[2],c1[2],pr0[2],pr1[1],pr2[0]);
    full_adder f12(s1[3],c1[3],pr0[3],pr1[2],pr2[1]);
    full_adder f13(s1[4],c1[4],pr0[4],pr1[3],pr2[2]);
    full_adder f14(s1[5],c1[5],pr0[5],pr1[4],pr2[3]);
    full_adder f15(s1[6],c1[6],pr0[6],pr1[5],pr2[4]);
    full_adder f16(s1[7],c1[7],pr0[7],pr1[6],pr2[5]);
    half_adder h12(s1[8],c1[8],      pr1[7],pr2[6]);
    

    half_adder h13 (s1[9], c1[9], pr3[1],pr4[0]);
    full_adder f17 (s1[10],c1[10],pr3[2],pr4[1],pr5[0]);
    full_adder f18 (s1[11],c1[11],pr3[3],pr4[2],pr5[1]);
    full_adder f19 (s1[12],c1[12],pr3[4],pr4[3],pr5[2]);
    full_adder f110(s1[13],c1[13],pr3[5],pr4[4],pr5[3]);
    full_adder f111(s1[14],c1[14],pr3[6],pr4[5],pr5[4]);
    full_adder f112(s1[15],c1[15],pr3[7],pr4[6],pr5[5]);
    half_adder h14 (s1[16],c1[16],      pr4[7],pr5[6]);


    // layer 2
    
    wire [16:0] s2,c2;
    reg [16:0] sr2,cr2;

    half_adder h21(s2[1],c2[1],cr1[1],sr1[2]);
    full_adder f22(s2[2],c2[2],cr1[2],sr1[3],pr3[0]);
    full_adder f23(s2[3],c2[3],cr1[3],sr1[4],sr1[9]);
    full_adder f24(s2[4],c2[4],cr1[4],sr1[5],cr1[9]);
    full_adder f25(s2[5],c2[5],cr1[5],sr1[6],cr1[10]);
    full_adder f26(s2[6],c2[6],cr1[6],sr1[7],cr1[11]);
    full_adder f27(s2[7],c2[7],cr1[7],sr1[8],cr1[12]);
    full_adder f28(s2[8],c2[8],cr1[8],pr2[7],cr1[13]);

    half_adder h22 (s2[9],c2[9],sr1[11],pr6[0]);
    full_adder f29 (s2[10],c2[10],sr1[12],pr6[1],pr7[0]);
    full_adder f210(s2[11],c2[11],sr1[13],pr6[2],pr7[1]);
    full_adder f211(s2[12],c2[12],sr1[14],pr6[3],pr7[2]);
    full_adder f212(s2[13],c2[13],sr1[15],pr6[4],pr7[3]);
    full_adder f213(s2[14],c2[14],sr1[16],pr6[5],pr7[4]);
    full_adder f214(s2[15],c2[15],pr5[7],pr6[6],pr7[5]);
    half_adder h23 (s2[16],c2[16],      pr6[7],pr7[6]);


    // layer 3

    wire [10:0] s3,c3;
    reg [10:0] sr3,cr3;

    half_adder h31(s3[1],c3[1],cr2[1],sr2[2]);
    half_adder h32(s3[2],c3[2],cr2[2],sr2[3]);
    full_adder f31(s3[3],c3[3],cr2[3],sr2[4],sr1[10]);
    full_adder f32(s3[4],c3[4],cr2[4],sr2[5],sr2[9]);
    full_adder f33(s3[5],c3[5],cr2[5],sr2[6],cr2[9]);
    full_adder f34(s3[6],c3[6],cr2[6],sr2[7],cr2[10]);
    full_adder f35(s3[7],c3[7],cr2[7],sr2[8],cr2[11]);
    full_adder f36(s3[8],c3[8],cr2[8],cr1[14],cr2[12]);
    half_adder h33(s3[9],c3[8]     ,cr1[15],cr2[13]);
    half_adder h34(s3[10],c3[8]    ,cr1[16],cr2[14]);

    // layer 4
    wire [11:0] s4,c4;
    reg [11:0] sr4,cr4;

    half_adder h41(s4[1],c4[1],cr3[1],sr3[2]);
    half_adder h42(s4[2],c4[2],cr3[2],sr3[3]);
    half_adder h43(s4[3],c4[3],cr3[3],sr3[4]);
    full_adder f41(s4[4],c4[4],cr3[4],sr3[5],sr2[10]);
    full_adder f42(s4[5],c4[5],cr3[5],sr3[6],sr2[11]);
    full_adder f43(s4[6],c4[6],cr3[6],sr3[7],sr2[12]);
    full_adder f44(s4[7],c4[7],cr3[7],sr3[8],sr2[13]);
    full_adder f45(s4[8],c4[8],cr3[8],sr3[9],sr2[14]);
    full_adder f46(s4[9],c4[9],cr3[9],sr3[10],sr2[15]);
    full_adder f47(s4[10],c4[10],cr3[10],cr2[15],sr2[16]);
    half_adder h44(s4[10],c4[10]       ,cr2[16],pr7[7]);

    // addition layer and assessment

    assign ans[0] = pr0[0];
    assign ans[1] = sr1[1];
    assign ans[2] = sr2[1];
    assign ans[3] = sr3[1];
    assign ans[4] = sr4[1];
    assign ans[15:5] = {cr4[11:1]}+{1'b0,sr4[11:2]};


    always @(posedge clk, negedge rst) begin
        if (!rst) begin 
            pr0<=0;
            pr1<=0;
            pr2<=0;
            pr3<=0;
            pr4<=0;
            pr5<=0;
            pr6<=0;
            pr7<=0;
            sr1<=0;
            cr1<=0;
            sr2<=0;
            cr2<=0;
            sr3<=0;
            cr3<=0;
            sr4<=0;
            cr4<=0;
        end 
        else begin
            pr0<=p0;
            pr1<=p1;
            pr2<=p2;
            pr3<=p3;
            pr4<=p4;
            pr5<=p5;
            pr6<=p6;
            pr7<=p7;

            sr1<=s1;
            cr1<=c1;
            sr2<=s2;
            cr2<=c2;
            sr3<=s3;
            cr3<=c4;
            sr4<=s4;
            cr4<=c4;
        end
    end
endmodule


module half_adder (
    output sum,cout,
    input a,b
);
    xor x1(sum,a,b);
    and a1(cout,a,b);
endmodule


module full_adder (
    output sum,cout,
    input a,b,cin
);
    wire s1,c1,c2;
    half_adder h1(s1,c1,a,b);
    half_adder h2(sum,c2,s1,cin);
    or o1(c1,c2);
endmodule