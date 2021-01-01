

module cpu15(CLK, RESET_N, IO65_IN, IO65_OUT);
    
    input         CLK;
    input         RESET_N;
    input [15:0]  IO65_IN;
    output [15:0] IO65_OUT;

    wire          CLK_FT;
    wire          CLK_DC;
    wire          CLK_EX;
    wire          CLK_WB;
    wire [7:0]    P_COUNT;
    wire [14:0]   PROM_OUT;
    wire [3:0]    OP_CODE;
    wire [7:0]    OP_DATA;
    wire [15:0]   REG_0;
    wire [15:0]   REG_1;
    wire [15:0]   REG_2;
    wire [15:0]   REG_3;
    wire [15:0]   REG_4;
    wire [15:0]   REG_5;
    wire [15:0]   REG_6;
    wire [15:0]   REG_7;
    wire [2:0]    N_REG_A;
    wire [2:0]    N_REG_B;
    wire [15:0]   REG_A;
    wire [15:0]   REG_B;
    wire [15:0]   RAM_0;
    wire [15:0]   RAM_1;
    wire [15:0]   RAM_2;
    wire [15:0]   RAM_3;
    wire [15:0]   RAM_4;
    wire [15:0]   RAM_5;
    wire [15:0]   RAM_6;
    wire [15:0]   RAM_7;
    wire [7:0]    RAM_ADDR;
    wire [15:0]   RAM_OUT;
    wire [15:0]   REG_IN;
    wire [15:0]   RAM_IN;
    wire          REG_WEN;
    wire          RAM_WEN;
          
    clk_gen C1(CLK, CLK_FT, CLK_DC, CLK_EX, CLK_WB);
    
    fetch C2(CLK_FT, P_COUNT, PROM_OUT);
    
    decode C3(CLK_DC, PROM_OUT, OP_CODE, OP_DATA);
    
    reg_dc C4(CLK_DC, PROM_OUT[10:8], REG_0, REG_1, REG_2, REG_3, REG_4, REG_5, REG_6, REG_7,
              N_REG_A, REG_A);
    
    reg_dc C5(CLK_DC, PROM_OUT[7:5], REG_0, REG_1, REG_2, REG_3, REG_4, REG_5, REG_6, REG_7,
              N_REG_B, REG_B);
    
    ram_dc C6(CLK_DC, PROM_OUT[7:0] RAM_0, RAM_1, RAM_2, RAM_3, RAM_4, RAM_5, RAM_6, RAM_7, 
              IO65_IN, RAM_ADDR, RAM_OUT);
    
    exec C7(CLK_EX, RESET_N, OP_CODE, REG_A, REG_B, OP_DATA, RAM_OUT, P_COUNT, 
            REG_IN, RAM_IN, REG_WEN, RAM_WEN);
    
    reg_wb C8(CLK_WB, RESET_N, N_REG_A, REG_IN, REG_WEN, REG_0, REG_1, REG_2, REG_3, REG_4, 
              REG_5, REG_6, REG_7);
    
    ram_wb C9(CLK_WB, RAM_ADDR, RAM_IN, RAM_WEN, RAM_0, RAM_1, RAM_2, RAM_3, RAM_4, 
              RAM_5, RAM_6, RAM_7, IO64_OUT);

endmodule
    
