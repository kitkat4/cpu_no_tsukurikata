
module cpu15_sim();

    reg         CLK     = 0;
    reg         RESET_N = 0;
    reg [15:0]  IO65_IN = 16'h0000;
    wire [15:0] IO64_OUT;

    cpu15 C0(CLK, RESET_N, IO65_IN, IO64_OUT);

    initial begin
        $dumpfile("cpu15_sim.vcd");
        $dumpvars(0, cpu15_sim.C0);
        #100 RESET_N <= 1'b1;
        #10000 $finish;
    end

    always begin
        # 10 CLK <= ~CLK;
    end

endmodule // cpu15_sim


