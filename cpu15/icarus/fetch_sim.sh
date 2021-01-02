#!/bin/bash

iverilog fetch_sim.v ../verilog/fetch.v -o fetch.out
./fetch.out
