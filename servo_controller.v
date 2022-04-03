module servo_controller (
  input clock,  //base on 100MHZ clock
    input [1:0] position, //left(10), right(01), neutral(00,11)
    output pwm_out
    );
    
    localparam MS_20 = 24'h1e8480;      //20ms from 100MHZ clock
    localparam MIDDLE = 24'h24f90;      // 1.5 ms  middle
    localparam ALLRIGHT = 24'h30d40;    // 2ms all the way right
    localparam ALLLEFT = 24'h186a0;     //1 ms all the way left

    reg [23:0] count;
    reg pulse;

    initial count = 0;
    assign pwm_out = pulse;

    always@(posedge clock) begin
        count <= (count == MS_20) ? 0 : count + 1'b1; /* 20 ms period */
    end    

    always@(*) begin
        case(position)
            2'b01: pulse = (count <= ALLRIGHT); //right all the way
            2'b00: pulse = (count <= ALLLEFT); //left all the way
            default: pulse = (count <= MIDDLE);  //center 
        endcase
    end
endmodule