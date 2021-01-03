

module reg_wb(CLK_WB, RESET_N, N_REG, REG_IN, REG_WEN, REG_0, REG_1, REG_2,
              REG_3, REG_4, REG_5, REG_6, REG_7);

    input         CLK_WB;
    input         RESET_N;
    input [2:0]   N_REG;
    input [15:0]  REG_IN;
    input         REG_WEN;
    output [15:0] REG_0;
    output [15:0] REG_1;
    output [15:0] REG_2;
    output [15:0] REG_3;
    output [15:0] REG_4;
    output [15:0] REG_5;
    output [15:0] REG_6;
    output [15:0] REG_7;

    reg [15:0]    REG_0;
    reg [15:0]    REG_1;
    reg [15:0]    REG_2;
    reg [15:0]    REG_3;
    reg [15:0]    REG_4;
    reg [15:0]    REG_5;
    reg [15:0]    REG_6;
    reg [15:0]    REG_7;

    always@(posedge CLK_WB) begin

        if(RESET_N == 1'b0) begin
            REG_0 <= 0;
            REG_1 <= 0;
            REG_2 <= 0;
            REG_3 <= 0;
            REG_4 <= 0;
            REG_5 <= 0;
            REG_6 <= 0;
            REG_7 <= 0;
        end else begin

            if(REG_WEN) begin

                case(N_REG)
                    3'h0: REG_0 <= REG_IN;
                    3'h1: REG_1 <= REG_IN;
                    3'h2: REG_2 <= REG_IN;
                    3'h3: REG_3 <= REG_IN;
                    3'h4: REG_4 <= REG_IN;
                    3'h5: REG_5 <= REG_IN;
                    3'h6: REG_6 <= REG_IN;
                    3'h7: REG_7 <= REG_IN;
                endcase // case (N_REG)
                
            end // if (REG_WEN)

        end // else: !if(RESET_N)
        
    end // always@ (posedge CLK_WB)
    
endmodule // reg_wb

