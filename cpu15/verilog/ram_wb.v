

module ram_wb(CLK_WB, RAM_ADDR, RAM_IN, RAM_WEN, RAM_0, RAM_1, RAM_2, RAM_3,
              RAM_4, RAM_5, RAM_6, RAM_7, IO64_OUT);

    input         CLK_WB;
    input [7:0]   RAM_ADDR;
    input [15:0]  RAM_IN;
    input         RAM_WEN;
    output [15:0] RAM_0;
    output [15:0] RAM_1;
    output [15:0] RAM_2;
    output [15:0] RAM_3;
    output [15:0] RAM_4;
    output [15:0] RAM_5;
    output [15:0] RAM_6;
    output [15:0] RAM_7;
    output [15:0] IO64_OUT;

    reg [15:0]    RAM_0 = 0;
    reg [15:0]    RAM_1 = 0;
    reg [15:0]    RAM_2 = 0;
    reg [15:0]    RAM_3 = 0;
    reg [15:0]    RAM_4 = 0;
    reg [15:0]    RAM_5 = 0;
    reg [15:0]    RAM_6 = 0;
    reg [15:0]    RAM_7 = 0;
    reg [15:0]    IO64_OUT = 0;

    always@(posedge CLK_WB) begin

        if(RAM_WEN) begin

            case(RAM_ADDR)
                8'h0: RAM_0 <= RAM_IN;
                8'h1: RAM_1 <= RAM_IN;
                8'h2: RAM_2 <= RAM_IN;
                8'h3: RAM_3 <= RAM_IN;
                8'h4: RAM_4 <= RAM_IN;
                8'h5: RAM_5 <= RAM_IN;
                8'h6: RAM_6 <= RAM_IN;
                8'h7: RAM_7 <= RAM_IN;
                8'h40: IO64_OUT <= RAM_IN;
            endcase // case (N_RAM)
            
        end // if (RAM_WEN)
        
    end // always@ (posedge CLK_WB)

endmodule // ram_wb
