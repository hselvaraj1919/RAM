module sync_ram #(
    parameter ADDR_WIDTH = 4,   // 4-bit address -> 16 locations
    parameter DATA_WIDTH = 8    // 8-bit data
)(
    input wire clk,             // Clock signal
    input wire we,              // Write Enable: 1 for write, 0 for read
    input wire [ADDR_WIDTH-1:0] addr, // Address bus
    input wire [DATA_WIDTH-1:0] din,  // Data input (for write)
    output reg [DATA_WIDTH-1:0] dout  // Data output (for read)
);

    // Declare memory array
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    always @(posedge clk) begin
        if (we) begin
            // Write operation
            mem[addr] <= din;
        end else begin
            // Read operation
            dout <= mem[addr];
        end
    end

endmodule
