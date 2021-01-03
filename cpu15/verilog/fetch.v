

module fetch(CLK_FT, P_COUNT, PROM_OUT);

    input         CLK_FT;
    input [7:0]   P_COUNT;
    output [14:0] PROM_OUT;
    
    reg [14:0]    PROM_OUT;
    reg [15*16-1:0] mem = {15'b1001_0000_0000_000, // ldh Reg0, 0
                           15'b1000_0000_0000_000, // ldl Reg0, 0
                           15'b1001_0010_0000_000, // ldh Reg1, 0
                           15'b1000_0010_0000_001, // ldl Reg1, 1
                           15'b1001_0100_0000_000, // ldh Reg2, 0
                           15'b1000_0100_0000_000, // ldl Reg2, 0
                           15'b1001_0110_0000_000, // ldh Reg3, 0
                           15'b1000_0110_0001_010, // ldl Reg3, 10
                           15'b0001_0100_0100_000, // add Reg2, Reg1
                           15'b0001_0000_1000_000, // add Reg0, Reg2
                           15'b1110_0000_1000_000, // st Reg0, 64
                           15'b1010_0100_1100_000, // cmp Reg2, Reg3
                           15'b1011_0000_0001_110, // je 14
                           15'b1100_0000_0001_000, // jmp 8
                           15'b1111_0000_0000_000, // hlt
                           15'b0000_0000_0000_000  // nop
                           };

    always@(posedge CLK_FT) begin
        PROM_OUT <= mem[(15-P_COUNT[3:0]) * 15 +: 15];
        // PROM_OUT <= mem[(8'h10 - (P_COUNT & 8'h0F)) * 15 - 1:
        //                 (8'hF - (P_COUNT & 8'h0F)) * 15];
    end

endmodule // fetch

