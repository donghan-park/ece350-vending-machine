module main_module(seg_an, seg_cat, clock, in2, in1, in0, reset, buy1_in, buy0_in, is_insufficient, cost_in3, cost_in2, cost_in1, cost_in0, motor_in1, motor_in0, motor_out);
    input clock, reset, in2, in1, in0, buy1_in, buy0_in, cost_in3, cost_in2, cost_in1, cost_in0;
    
    reg[31:0] current = 0;
    reg[31:0] cost1_current, cost0_current;
    reg[31:0] current_digit;

    reg[31:0] nickel_change = 1;
    reg[31:0] dime_change = 2;
    reg[31:0] quarter_change = 3;

    output reg[15:0] seg_an;
    output reg[6:0] seg_cat;
    
    reg[20:0] refresh_counter;
    wire[3:0] stage_counter;
    
    output motor_out;
    input motor_in1, motor_in0;
    
    // debounce logic for coin inputs
    wire db_clock;
    debounce_clock db_clock_module(clock, db_clock);

    wire is_nickel, is_dime, is_quarter, buy1_attempted, buy0_attempted, step_motor1, step_motor2;
    wire cost1_inc, cost1_dec, cost0_inc, cost0_dec;
    input_db nickel_db(is_nickel, in2, clock, db_clock);
    input_db dime_db(is_dime, in1, clock, db_clock);
    input_db quarter_db(is_quarter, in0, clock, db_clock);
    input_db buy1_db(buy1_attempted, buy1_in, clock, db_clock);
    input_db buy0_db(buy0_attempted, buy0_in, clock, db_clock);
    input_db cost1_inc_db(cost1_inc, cost_in3, clock, db_clock);
    input_db cost1_dec_db(cost1_dec, cost_in2, clock, db_clock);
    input_db cost0_inc_db(cost0_inc, cost_in1, clock, db_clock);
    input_db cost0_dec_db(cost0_dec, cost_in0, clock, db_clock);
    input_db inc_m_db(step_motor1, motor_in1, clock, db_clock);
    input_db dec_m_db(step_motor2, motor_in0, clock, db_clock);

    // motor control
    reg[1:0] motor_position;
    reg[26:0] sec_counter;
    
    always @(posedge clock) begin
        if(buy0_attempted & current >= cost0_current) begin
            sec_counter <= 0;
            motor_position <= 2'b01;
        end else begin
            if(sec_counter>=49999999) begin
                sec_counter <= 0;
                motor_position <= 2'b00;
            end else
                sec_counter <= sec_counter + 1;
        end
    end
    servo_controller s_control(clock, motor_position, motor_out);

    // buy modules
    wire[31:0] cost = 100;
    output reg is_insufficient;
    
    always @(posedge clock) begin
        if(reset) begin
            refresh_counter <= 0;
            current <= 0;
            is_insufficient <= 1'b0;
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

        if(buy1_attempted & current < cost1_current)
            is_insufficient <= 1'b1;
        if(buy1_attempted & current >= cost1_current) begin
            is_insufficient <= 1'b0;
            current <= current - cost1_current; // update current change
        end

        if(buy0_attempted & current < cost0_current)
            is_insufficient <= 1'b1;
        if(buy0_attempted & current >= cost0_current) begin
            is_insufficient <= 1'b0;
            current <= current - cost0_current; // update current change
        end

        if(cost1_inc)
            cost1_current <= cost1_current + 5;
        if(cost1_dec && cost1_current >= 5)
            cost1_current <= cost1_current - 5;
        if(cost0_inc)
            cost0_current <= cost0_current + 5;
        if(cost0_dec && cost0_current >= 5)
            cost0_current <= cost0_current - 5;
    end
    assign stage_counter = refresh_counter[20:17];
    
    always @(*) begin
        case(stage_counter)
            // segment 1
            4'b0000: begin
                seg_an = 16'b1111111111110111;
                current_digit = current / 1000;
            end
            4'b0001: begin
                seg_an = 16'b1111111111111011;
                current_digit = (current % 1000) / 100;
            end
            4'b0010: begin
                seg_an = 16'b1111111111111101;
                current_digit = ((current % 1000) % 100) / 10;
            end
            4'b0011: begin
                seg_an = 16'b1111111111111110;
                current_digit = ((current % 1000) % 100) % 10;
            end

            // segment 2
            4'b0100: begin
                seg_an = 16'b1111111101111111;
                current_digit = current / 1000;
            end
            4'b0101: begin
                seg_an = 16'b1111111110111111;
                current_digit = (current % 1000) / 100;
            end
            4'b0110: begin
                seg_an = 16'b1111111111011111;
                current_digit = ((current % 1000) % 100) / 10;
            end
            4'b0111: begin
                seg_an = 16'b1111111111101111;
                current_digit = ((current % 1000) % 100) % 10;
            end

            // segment 3
            4'b1000: begin
                seg_an = 16'b1111011111111111;
                current_digit = cost0_current / 1000;
            end
            4'b1001: begin
                seg_an = 16'b1111101111111111;
                current_digit = (cost0_current % 1000) / 100;
            end
            4'b1010: begin
                seg_an = 16'b1111110111111111;
                current_digit = ((cost0_current % 1000) % 100) / 10;
            end
            4'b1011: begin
                seg_an = 16'b1111111011111111;
                current_digit = ((cost0_current % 1000) % 100) % 10;
            end


            // segment 4
            4'b1100: begin
                seg_an = 16'b0111111111111111;
                current_digit = cost1_current / 1000;
            end
            4'b1101: begin
                seg_an = 16'b1011111111111111;
                current_digit = (cost1_current % 1000) / 100;
            end
            4'b1110: begin
                seg_an = 16'b1101111111111111;
                current_digit = ((cost1_current % 1000) % 100) / 10;
            end
            4'b1111: begin
                seg_an = 16'b1110111111111111;
                current_digit = ((cost1_current % 1000) % 100) % 10;
            end
        endcase
    end

    always @(*) begin
        case(current_digit)
            0: seg_cat = 7'b1111110;
            1: seg_cat = 7'b0110000;
            2: seg_cat = 7'b1101101;
            3: seg_cat = 7'b1111001;
            4: seg_cat = 7'b0110011;
            5: seg_cat = 7'b1011011;
            6: seg_cat = 7'b1011111;
            7: seg_cat = 7'b1110000; 
            8: seg_cat = 7'b1111111;     
            9: seg_cat = 7'b1111011;
            default: seg_cat = 7'b0000001;
        endcase
    end
endmodule