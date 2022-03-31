module main_module(seg_an, seg_cat, clock, in2, in1, in0, reset, in_buy, is_insufficient);
    input clock, reset, in2, in1, in0, in_buy;
    
    reg[31:0] current = 0;
    reg[31:0] current_digit;

    reg[31:0] nickel_change = 1;
    reg[31:0] dime_change = 2;
    reg[31:0] quarter_change = 3;

    output reg[7:0] seg_an;
    output reg[6:0] seg_cat;
    
    reg[19:0] refresh_counter;
    wire[1:0] stage_counter;
    
    // debounce logic for coin inputs
    wire db_clock;
    debounce_clock db_clock_module(clock, db_clock);

    wire is_nickel, is_dime, is_quarter, buy_attempted;
    input_db nickel_db(is_nickel, in2, clock, db_clock);
    input_db dime_db(is_dime, in1, clock, db_clock);
    input_db quarter_db(is_quarter, in0, clock, db_clock);
    input_db buy_db(buy_attempted, in_buy, clock, db_clock);

    // buy modules
    wire[31:0] cost = 100;
    output reg is_insufficient;
    
    always @(posedge clock) begin
        if(reset) begin
            refresh_counter <= 0;
            current <= 0;
        end else
            refresh_counter <= refresh_counter + 1; 
            
        if(is_nickel)
            current <= current + 5;
        if(is_dime)
            current <= current + 10;
        if(is_quarter)
            current <= current + 25;
        if(is_nickel | is_dime | is_quarter)
            is_insufficient <= 1'b0; // reset insufficient funds notification if more coins inputted
        if(buy_attempted & current < cost)
            is_insufficient <= 1'b1;
        if(buy_attempted & current >= cost) begin
            is_insufficient <= 1'b0;
            current <= current - cost; // update current change
        end
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