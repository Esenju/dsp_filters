// Peter Mbua
// Project: DSP Filters
// Module: testbench of dsp_fir

`timescale 1ns/1ps

module tb_fir_filter();

    // Parameters
    parameter N = 4;
    parameter DATA_WIDTH = 16;
    parameter COEFF_WIDTH = 16;

    // Signals
    logic clk;
    logic rst;
    logic [DATA_WIDTH-1:0] x_in;
    logic [DATA_WIDTH-1:0] y_out;

    // DUT Instance
    fir_filter #(
        .N(N),
        .DATA_WIDTH(DATA_WIDTH),
        .COEFF_WIDTH(COEFF_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10 ns clock period

    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        x_in = 0;

        // Apply reset
        #20 rst = 0;

        // Apply input samples
        #10 x_in = 1;  // First sample
        #10 x_in = 2;  // Second sample
        #10 x_in = 3;  // Third sample
        #10 x_in = 4;  // Fourth sample
        #10 x_in = 0;  // Reset input
        #50 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %t | x_in: %d | y_out: %d", $time, x_in, y_out);
    end

endmodule
