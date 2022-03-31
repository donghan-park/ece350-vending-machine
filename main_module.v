module main_module(seg_an, seg_cat, clock, in2, in1, in0, reset);
    input clock, reset, in2, in1, in0;
    
    reg[31:0] current = 0;
    reg[31:0] current_digit;

    output reg[7:0] seg_an;
    output reg[6:0] seg_cat;
    
    reg[19:0] refresh_counter;
    wire[1:0] stage_counter;

    // button debounce
    wire db_clock;
    wire q1, q2, q0;
    debounce_clock u1(clock, db_clock);
    dffe_ref d0(q0, in2, clock, db_clock, 1'b0);
    dffe_ref d1(q1, q0, clock, db_clock, 1'b0);
    dffe_ref d2(q2, q1, clock, db_clock, 1'b0);
    
    always @(posedge clock) begin
        if(reset) begin
            refresh_counter <= 0;
            current <= 0;
        end else
            refresh_counter <= refresh_counter + 1; 

        if(q1 & ~q2 & db_clock)
            current <= current + 1;
    end
    assign stage_counter = refresh_counter[19:18];
    
    always @(*) begin
        case(stage_counter)
            2'b00: begin
                seg_an = 8'b11110111;
                current_digit = current / 1000;
            end
            2'b01: begin
                seg_an = 8'b11111011;
                current_digit = (current % 1000) / 100;
            end
            2'b10: begin
                seg_an = 8'b11111101;
                current_digit = ((current % 1000) % 100) / 10;
            end
            2'b11: begin
                seg_an = 8'b11111110;
                current_digit = ((current % 1000) % 100) % 10;
            end
        endcase
    end

    always @(*) begin
        case(current_digit)
            0: seg_cat = 7'b0000001;
            1: seg_cat = 7'b1001111;
            2: seg_cat = 7'b0010010;
            3: seg_cat = 7'b0000110;
            4: seg_cat = 7'b1001100;
            5: seg_cat = 7'b0100100;
            6: seg_cat = 7'b0100000;
            7: seg_cat = 7'b0001111; 
            8: seg_cat = 7'b0000000;     
            9: seg_cat = 7'b0000100; 
            default: seg_cat = 7'b0000001;
        endcase
    end
endmodule