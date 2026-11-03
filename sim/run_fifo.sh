#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p build
iverilog -g2012 -s tb_sync_fifo -o build/tb_sync_fifo rtl/sync_fifo.sv tb/tb_sync_fifo.sv
vvp build/tb_sync_fifo
