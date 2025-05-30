`timescale 1ns / 1ps

module sync_ram_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    // Inputs
    reg clk;
    reg we;
    reg re;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;

    // Output
    wire [DATA_WIDTH-1:0] data_out;

    // Instantiate the RAM
    sync_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .we(we),
        .re(re),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10 ns clock period

    initial begin
        // Initialize inputs
        clk = 0;
        we = 0;
        re = 0;
        addr = 0;
        data_in = 0;

        // Wait for global reset
        #10;

        // Write to address 0
        addr = 4'd0;
        data_in = 8'hAA;
        we = 1;
        re = 0;
        #10;

        // Write to address 1
        addr = 4'd1;
        data_in = 8'hBB;
        #10;

        // Disable write
        we = 0;

        // Read from address 0
        addr = 4'd0;
        re = 1;
        #10;

        // Read from address 1
        addr = 4'd1;
        #10;

        // Finish simulation
        $display("Read Data @ addr 0: %h", data_out);
        #10;
        $display("Read Data @ addr 1: %h", data_out);

        #10;
        $stop;
    end

endmodule
