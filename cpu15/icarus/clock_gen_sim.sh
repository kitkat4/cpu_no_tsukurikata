#!/bin/bash

iverilog clock_gen_sim.v ../verilog/clock_gen.v -o bin/clock_gen_sim.out
./bin/clock_gen_sim.out
gtkwave clock_gen_sim.vcd
rm clock_gen_sim.vcd

