

module ram_dc(CLK_DC, RAM_AD_IN, RAM_0, RAM_1, RAM_2, RAM_3, RAM_4, RAM_5,
              RAM_6, RAM_7, IO65_IN, RAM_AD_OUT, RAM_OUT);

    input         CLK_DC;
    input [7:0]   RAM_AD_IN;
    input [15:0]  RAM_0;
    input [15:0]  RAM_1;
    input [15:0]  RAM_2;
    input [15:0]  RAM_3;
    input [15:0]  RAM_4;
    input [15:0]  RAM_5;
    input [15:0]  RAM_6;
    input [15:0]  RAM_7;
    input [15:0]  IO65_IN;
    output [7:0]  RAM_AD_OUT;
    output [15:0] RAM_OUT;

    reg [7:0]     RAM_AD_OUT;
    reg [15:0]    RAM_OUT;

    always@(posedge CLK_DC) begin

        RAM_AD_OUT <= RAM_AD_IN;
        
        case(RAM_AD_IN)
            8'h00: RAM_OUT <= RAM_0;
            8'h01: RAM_OUT <= RAM_1;
            8'h02: RAM_OUT <= RAM_2;
            8'h03: RAM_OUT <= RAM_3;
            8'h04: RAM_OUT <= RAM_4;
            8'h05: RAM_OUT <= RAM_5;
            8'h06: RAM_OUT <= RAM_6;
            8'h07: RAM_OUT <= RAM_7;
            8'h40: RAM_OUT <= IO65_IN;
            default: RAM_OUT <= 16'hFFFF;
        endcase
    end
    

endmodule // ram_dc

