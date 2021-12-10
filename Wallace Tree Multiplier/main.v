module wallace_multiplier(
    output [15:0] ans,
    input [7:0] A,B
    );
    wire [7:0] p0,p1,p2,p3,p4,p5,p6,p7;
    
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
    half_adder h11(s1[1],c1[1],p0[1],p1[0]);
    full_adder f11(s1[2],c1[2],p0[2],p1[1],p2[0]);
    full_adder f12(s1[3],c1[3],p0[3],p1[2],p2[1]);
    full_adder f13(s1[4],c1[4],p0[4],p1[3],p2[2]);
    full_adder f14(s1[5],c1[5],p0[5],p1[4],p2[3]);
    full_adder f15(s1[6],c1[6],p0[6],p1[5],p2[4]);
    full_adder f16(s1[7],c1[7],p0[7],p1[6],p2[5]);
    half_adder h12(s1[8],c1[8],      p1[7],p2[6]);
    

    half_adder h13 (s1[9], c1[9], p3[1],p4[0]);
    full_adder f17 (s1[10],c1[10],p3[2],p4[1],p5[0]);
    full_adder f18 (s1[11],c1[11],p3[3],p4[2],p5[1]);
    full_adder f19 (s1[12],c1[12],p3[4],p4[3],p5[2]);
    full_adder f110(s1[13],c1[13],p3[5],p4[4],p5[3]);
    full_adder f111(s1[14],c1[14],p3[6],p4[5],p5[4]);
    full_adder f112(s1[15],c1[15],p3[7],p4[6],p5[5]);
    half_adder h14 (s1[16],c1[16],      p4[7],p5[6]);

    // layer 2
    wire [16:0] s2,c2;
    half_adder h21(s2[1],c2[1],c1[1],s1[2]);
    full_adder f22(s2[2],c2[2],c1[2],s1[3],p3[0]);
    full_adder f23(s2[3],c2[3],c1[3],s1[4],s1[9]);
    full_adder f24(s2[4],c2[4],c1[4],s1[5],c1[9]);
    full_adder f25(s2[5],c2[5],c1[5],s1[6],c1[10]);
    full_adder f26(s2[6],c2[6],c1[6],s1[7],c1[11]);
    full_adder f27(s2[7],c2[7],c1[7],s1[8],c1[12]);
    full_adder f28(s2[8],c2[8],c1[8],p2[7],c1[13]);

    half_adder h22 (s2[9],c2[9],s1[11],p6[0]);
    full_adder f29 (s2[10],c2[10],s1[12],p6[1],p7[0]);
    full_adder f210(s2[11],c2[11],s1[13],p6[2],p7[1]);
    full_adder f211(s2[12],c2[12],s1[14],p6[3],p7[2]);
    full_adder f212(s2[13],c2[13],s1[15],p6[4],p7[3]);
    full_adder f213(s2[14],c2[14],s1[16],p6[5],p7[4]);
    full_adder f214(s2[15],c2[15],p5[7],p6[6],p7[5]);
    half_adder h23 (s2[16],c2[16],      p6[7],p7[6]);


    // layer 3

    wire [10:0] s3,c3;
    half_adder h31(s3[1],c3[1],c2[1],s2[2]);
    half_adder h32(s3[2],c3[2],c2[2],s2[3]);
    full_adder f31(s3[3],c3[3],c2[3],s2[4],s1[10]);
    full_adder f32(s3[4],c3[4],c2[4],s2[5],s2[9]);
    full_adder f33(s3[5],c3[5],c2[5],s2[6],c2[9]);
    full_adder f34(s3[6],c3[6],c2[6],s2[7],c2[10]);
    full_adder f35(s3[7],c3[7],c2[7],s2[8],c2[11]);
    full_adder f36(s3[8],c3[8],c2[8],c1[14],c2[12]);
    half_adder h33(s3[9],c3[8]     ,c1[15],c2[13]);
    half_adder h34(s3[10],c3[8]    ,c1[16],c2[14]);

    // layer 4
    wire [11:0] s4,c4;
    half_adder h41(s4[1],c4[1],c3[1],s3[2]);
    half_adder h42(s4[2],c4[2],c3[2],s3[3]);
    half_adder h43(s4[3],c4[3],c3[3],s3[4]);
    full_adder f41(s4[4],c4[4],c3[4],s3[5],s2[10]);
    full_adder f42(s4[5],c4[5],c3[5],s3[6],s2[11]);
    full_adder f43(s4[6],c4[6],c3[6],s3[7],s2[12]);
    full_adder f44(s4[7],c4[7],c3[7],s3[8],s2[13]);
    full_adder f45(s4[8],c4[8],c3[8],s3[9],s2[14]);
    full_adder f46(s4[9],c4[9],c3[9],s3[10],s2[15]);
    full_adder f47(s4[10],c4[10],c3[10],c2[15],s2[16]);
    half_adder h44(s4[10],c4[10]       ,c2[16],p7[7]);

    // addition layer and assessment

    assign ans[0] = p0[0];
    assign ans[1] = s1[1];
    assign ans[2] = s2[1];
    assign ans[3] = s3[1];
    assign ans[4] = s4[1];
    assign ans[15:5] = {c4[11:1]}+{1'b0,s4[11:2]};
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