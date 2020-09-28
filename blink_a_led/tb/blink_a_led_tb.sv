//------------------------------------------------------
//------------------------------------------------------
// FILENAME : blink_a_led_tb.sv
// TESTBENCH FOR BLINK LED 
//-----------------------------------------------------
//-----------------------------------------------------
`include "paramters.svh"
timeunit 1ns;
timeprecision 1ps;


module blink_a_led_tb;

// testbench variables
bit   clk   ='b0;
bit   rst_n ='b0;
logic led_status; //

//clock system generation
always #(`PERIOD/2) clk=~clk;

//task
task reset_task();
    $info ("reset_task:: the testbench is reseting");
    rst_n <=1'b0;
    #(10*`PERIOD);
    rst_n <=1'b1;
endtask:reset_task;

// Procedure
initial begin
    rst_n = 1'b1;
    forever begin
        reset_task();
        //#(100*`PERIOD);
    end
end

//instatiation of Device Under the Test
blink_a_led_rtl Blinker (
                        .clk_sys(clk),
                        .rst_n(rst_n),
                        .Led(led_status)
                        );

endmodule:blink_a_led_tb