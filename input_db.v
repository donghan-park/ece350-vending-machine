module input_db(out, in, clock, db_clock);
    input in, clock, db_clock;
    output out;

    wire q2, q1, q0;
    dffe_ref d0(q0, in, clock, db_clock, 1'b0);
    dffe_ref d1(q1, q0, clock, db_clock, 1'b0);
    dffe_ref d2(q2, q1, clock, db_clock, 1'b0);

    assign out = q1 & ~q2 & db_clock;
endmodule