`timescale 1ns/1ps
module tb_sync_fifo;
    localparam int WIDTH = 32;
    localparam int DEPTH = 4;
    logic clk = 0;
    always #5 clk = ~clk;
    logic rst_n = 0, s_valid = 0, m_ready = 0;
    logic [WIDTH-1:0] s_data = '0, m_data;
    logic s_ready, m_valid;
    logic [$clog2(DEPTH):0] occupancy;
    int unsigned expected[$];
    int unsigned nxt = 1;
    int pushes = 0, pops = 0;

    sync_fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH)) dut (.*);

    initial begin
        repeat (3) @(negedge clk);
        rst_n = 1;
        for (int cycle = 0; cycle < 500; cycle++) begin
            @(negedge clk);
            s_valid = ($urandom_range(0, 3) != 0);
            m_ready = ($urandom_range(0, 3) != 0);
            s_data = nxt;
            @(posedge clk);
            if (m_valid && m_ready) begin
                int unsigned want;
                if (expected.size() == 0) $fatal(1, "Unexpected output");
                want = expected.pop_front();
                if (m_data !== want) $fatal(1, "FIFO mismatch: got %0d expected %0d", m_data, want);
                pops++;
            end
            if (s_valid && s_ready) begin
                expected.push_back(nxt);
                nxt++;
                pushes++;
            end
        end
        @(negedge clk);
        s_valid = 0;
        m_ready = 1;
        while (expected.size() != 0) begin
            @(posedge clk);
            if (m_valid && m_ready) begin
                int unsigned want;
                want = expected.pop_front();
                if (m_data !== want) $fatal(1, "Drain mismatch");
                pops++;
            end
            @(negedge clk);
        end
        $display("PASS: %0d pushes, %0d pops", pushes, pops);
        $finish;
    end
    initial begin #100000; $fatal(1, "Timeout"); end
endmodule
