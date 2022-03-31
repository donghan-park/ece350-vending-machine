`timescale 1ns / 1ps
module main_module_tb;
    reg clock = 0;
    reg reset = 0;
    reg in2 = 0;
    reg in1 = 0;
    reg in0 = 0;
    wire[7:0] seg_an;
    wire[6:0] seg_cat;
    wire[31:0] current;

    always
		#10 clock = ~clock;
    always
		#10 in2 = ~in2;
    always
		#20 in1 = ~in1;
    always
		#40 in0 = ~in0;
    always
        #400 reset = ~reset;

    main_module tester(seg_an, seg_cat, clock, in2, in1, in0, reset, current);
    
    initial begin
        #400;
        $finish;
    end

    always @(posedge clock) begin
        #1;
        $display("clk: %b) input: %b%b%b --> seg_an: %b, seg_cat: %b => %d", clock, in2, in1, in0, seg_an, seg_cat, current);
    end
endmodule