
module fetch_sim();

    reg         CLK_FT  = 0;
    reg [7:0]   P_COUNT = 8'b0000_0000;
    wire [14:0] PROM_OUT;

    fetch C0(CLK_FT, P_COUNT, PROM_OUT);

    initial begin
        $monitor("%t: CLK_FT: %b, P_COUNT %d, PROM_OUT %b", 
                 $time, CLK_FT, P_COUNT, PROM_OUT);
        #310 $finish;
    end
    
    always begin
        #10
        CLK_FT <= ~CLK_FT;
    end

    always@(negedge CLK_FT) begin
        P_COUNT <= P_COUNT + 1;
    end

endmodule // fetch_sim


