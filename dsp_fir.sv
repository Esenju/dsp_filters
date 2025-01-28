// Peter MBua
// Project: DSP filters
// Module: simple FIR (Finite Impulse Response), with no feedback.
//         Simple 4-tap FIR with coefficients h=[1,2,3,4]

`timescale 1ns/1ps

module fir_filter #(
    parameter N = 4                           // Number of filter taps
    ,parameter DATA_WIDTH = 16                // Width of input and output data
    ,parameter COEFF_WIDTH = 16               // Width of filter coefficients
) (
    input logic clk                           // Clock
    ,input logic rst                          // Synchronous reset
    ,input logic [DATA_WIDTH-1:0] x_in        // Input sample
    ,output logic [DATA_WIDTH-1:0] y_out      // Filtered output
);

    // Filter coefficients (constant values)
    logic signed [COEFF_WIDTH-1:0] h [0:N-1] = '{1, 2, 3, 4};

    // Input shift register
    logic signed [DATA_WIDTH-1:0] x_reg [0:N-1];

    // Accumulator for the filter output
    logic signed [DATA_WIDTH+COEFF_WIDTH-1:0] acc;

    // Initialize shift register and accumulator
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            x_reg <= '{default: 0};
            acc <= 0;
            y_out <= 0;
        end else begin
            // Shift the input samples in the register
            x_reg <= '{x_in, x_reg[0:N-2]};
            
            // Compute the FIR filter output
            acc = 0;
            for (int i = 0; i < N; i++) begin
                acc += x_reg[i] * h[i];
            end
            
            // Assign the filtered output
            y_out <= acc[DATA_WIDTH-1:0]; // Truncate or scale as needed
        end
    end

endmodule
