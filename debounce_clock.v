module debounce_clock(clock, db_clock);
    input clock;
    output db_clock;

    reg[26:0] counter = 0;
    always @(posedge clock) begin
        counter <= (counter >= 249999) ? 0 : counter + 1;
    end
    assign db_clock = (counter == 249999) ? 1'b1 : 1'b0;
endmodule