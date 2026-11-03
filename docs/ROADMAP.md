# Development roadmap

## Milestone 0 — Foundations
- [x] Starter parameterized synchronous ready/valid FIFO
- [x] Starter randomized self-checking testbench
- [ ] Run simulation and resolve any compatibility or verification failures
- [ ] Inspect waveforms for full/empty and simultaneous push/pop

## Milestone 1 — Framed streaming receiver
- [ ] Define a 32-bit stream interface and packet format
- [ ] Implement framing and malformed-frame handling
- [ ] Test backpressure

## Milestone 2 — Educational market-data parser
- [ ] Define synthetic symbol ID, side, price, quantity fields
- [ ] Implement RTL parser
- [ ] Compare with Python reference model

## Milestone 3 — Best-bid/best-ask store
- [ ] Implement fixed-size synthetic top-of-book
- [ ] Handle reset and overflow cases
- [ ] Quantify cycle latency

## Milestone 4 — FPGA implementation
- [ ] Add Arty A7-100T top-level and constraints
- [ ] Synthesize, place and route with Vivado
- [ ] Document frequency, LUT/FF/BRAM use and timing

## Milestone 5 — Portfolio polish
- [ ] Architecture, verification matrix, repeatable benchmarks
- [ ] Compare pipeline variants
- [ ] Document limitations and evidence

Educational simulation only; no exchange connectivity or live orders.
