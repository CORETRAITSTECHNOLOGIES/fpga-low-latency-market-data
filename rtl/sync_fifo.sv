// Synchronous ready/valid FIFO; DEPTH >= 2
module sync_fifo #(
    parameter int WIDTH = 32,
    parameter int DEPTH = 16,
    parameter int ADDR_W = $clog2(DEPTH)
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 s_valid,
    output logic                 s_ready,
    input  logic [WIDTH-1:0]     s_data,
    output logic                 m_valid,
    input  logic                 m_ready,
    output logic [WIDTH-1:0]     m_data,
    output logic [ADDR_W:0]      occupancy
);
    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [ADDR_W-1:0] wr_ptr, rd_ptr;
    logic push, pop;

    function automatic logic [ADDR_W-1:0] next_ptr(input logic [ADDR_W-1:0] ptr);
        if (ptr == ADDR_W'(DEPTH - 1)) return '0;
        return ptr + 1'b1;
    endfunction

    assign m_valid = (occupancy != 0);
    assign s_ready = (occupancy < DEPTH) || (m_valid && m_ready);
    assign push = s_valid && s_ready;
    assign pop  = m_valid && m_ready;
    assign m_data = mem[rd_ptr];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= '0;
            rd_ptr <= '0;
            occupancy <= '0;
        end else begin
            if (push) begin
                mem[wr_ptr] <= s_data;
                wr_ptr <= next_ptr(wr_ptr);
            end
            if (pop) rd_ptr <= next_ptr(rd_ptr);
            case ({push, pop})
                2'b10: occupancy <= occupancy + 1'b1;
                2'b01: occupancy <= occupancy - 1'b1;
                default: occupancy <= occupancy;
            endcase
        end
    end
endmodule
