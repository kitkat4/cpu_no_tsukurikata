
module clock_gen_sim();

    reg CLK;
    wire CLK_FT;
    wire CLK_DC;
    wire CLK_EX;
    wire CLK_WB;

    clock_gen C0(CLK, CLK_FT, CLK_DC, CLK_EX, CLK_WB);

    initial begin
        $dumpfile("clock_gen_sim.vcd");
        $dumpvars(0, clock_gen_sim.C0);
        CLK <= 0;
        #10000 $finish;
    end

    always begin
        #10 CLK <= ~CLK;
    end
    
endmodule // clock_gen_sim

