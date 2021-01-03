

module reg_dc(CLK_DC, N_REG_IN, REG_0, REG_1, REG_2, REG_3, REG_4, REG_5,
              REG_6, REG_7, N_REG_OUT, REG_OUT);

    input         CLK_DC;
    input [2:0]   N_REG_IN;
    input [15:0]  REG_0;
    input [15:0]  REG_1;
    input [15:0]  REG_2;
    input [15:0]  REG_3;
    input [15:0]  REG_4;
    input [15:0]  REG_5;
    input [15:0]  REG_6;
    input [15:0]  REG_7;
    output [2:0]  N_REG_OUT;
    output [15:0] REG_OUT;

    reg [2:0]     N_REG_OUT;
    reg [15:0]    REG_OUT;
    
    always@(posedge CLK_DC) begin

        N_REG_OUT <= N_REG_IN;

        case(N_REG_IN)
            3'b000: REG_OUT <= REG_0;
            3'b001: REG_OUT <= REG_1;
            3'b010: REG_OUT <= REG_2;
            3'b011: REG_OUT <= REG_3;
            3'b100: REG_OUT <= REG_4;
            3'b101: REG_OUT <= REG_5;
            3'b110: REG_OUT <= REG_6;
            3'b111: REG_OUT <= REG_7;
        endcase // case (N_REG_IN)
    end

endmodule // reg_dc

