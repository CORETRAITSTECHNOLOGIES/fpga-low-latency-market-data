# FPGA Low-Latency Market Data Processor

An **educational SystemVerilog FPGA portfolio project** exploring deterministic-latency streaming hardware inspired by low-latency market-data processing.

> **Status: Milestone 0 starter.** Currently contains a synchronous FIFO and automated testbench; no market-data parser, order book, trading strategy, exchange connectivity, or measured FPGA timing results yet.

## Goals
- Develop synthesizable RTL and self-checking verification.
- Understand ready/valid handshakes, backpressure, and buffering.
- Measure cycle latency, throughput, and FPGA timing with real evidence.
- Practice FPGA/RTL engineering for high-performance networking.

## Architecture
```text
Synthetic feed (planned)
  -> Stream receiver (planned)
  -> Synchronous FIFO (starter)
  -> Market-data parser (planned)
  -> Top-of-book state (planned)
  -> Simulated output (planned)
```

## Quick start
Install Icarus Verilog (`iverilog` and `vvp`), then run:

```bash
bash sim/run_fifo.sh
```

The testbench is intended to print `PASS`. **Initial simulation has not been independently run**; please check the GitHub Actions results and fix any simulator compatibility issues discovered.

## Files
- `rtl/sync_fifo.sv`: parameterized synchronous ready/valid FIFO
- `tb/tb_sync_fifo.sv`: randomized self-checking testbench
- `sim/run_fifo.sh`: simulation command
- `docs/ROADMAP.md`: development milestones
- `.github/workflows/sim.yml`: continuous integration

## FIFO contract
Input/output transfers happen on rising clock edges only when `valid && ready`. `occupancy` reports queued entries. A full FIFO can accept a new word on the same cycle as a pop. Single-clock only: **not suitable for asynchronous clock-domain crossing**.

## Hardware target
Digilent Arty A7-100T (Artix-7), once an FPGA top-level, constraints and timing reports are added.

**Educational project only:** synthetic messages, no real-money trading.
