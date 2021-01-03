#!/bin/bash

iverilog cpu15_sim.v ../verilog/*.v -o cpu15_sim.out
./cpu15_sim.out
gtkwave cpu15_sim.vcd
rm cpu15_sim.vcd

