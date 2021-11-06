module t_booth_multiplier; // module creation 2033
  wire[15:0] t_ans;  //wire for outputs 2033
  reg [7:0] t_m,t_r;   // reg for inputs 2033 
  reg t_clk,t_rst,t_shift_control;  // reg for clk and reset 2033
  reg t_start;
  wire ready;
  booth_multiplier m1(t_ans,t_m,t_r,t_clk,t_rst,t_start,t_ready);  // module instantion 2033
  initial begin  // applying inputs 2033
    t_clk=1'b0;   // 2033
    t_start=1'b0;
    t_shift_control=1'b0;  // 2033
    t_m=8'b0100001;  //33 input 2033
    t_r=8'b0010100;  //20 input 2033
    // reseting so module loads values 2033
    t_rst=1'b0; // 2033
    #5 t_rst=1'b1;  // 2033
    repeat(50) // 2033
    #5 t_clk = ~t_clk;  // 2033
  end // 2033
  initial begin   // shift control high for 8 cycles changes at -ve edge 2033
    #15 t_shift_control = 1'b1;  // 2033
    t_start=1'b1;
    #20 t_start=1'b0;
    #90 $finish;   // 2033
  end  //2033
  initial begin
        //$monitor("a=%b,b=%b,sel=%b,out=%b",ta,tb,tsel,tout);
        $dumpfile("booth_multiplier.vcd"); //Specify the file where all the variables will be dumped.
        $dumpvars;
    end
endmodule //2033