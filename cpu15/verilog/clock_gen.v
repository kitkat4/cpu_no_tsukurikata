

module clock_gen(CLK, CLK_FT, CLK_DC, CLK_EX, CLK_WB);

    input          CLK;
    output         CLK_FT;
    output         CLK_DC;
    output         CLK_EX;
    output         CLK_WB;

    reg            CLK_FT = 0;
    reg            CLK_DC = 0;
    reg            CLK_EX = 0;
    reg            CLK_WB = 0;
    reg [1:0]      COUNT = 2'b00;

    always@(posedge CLK) begin

        COUNT <= COUNT + 1;
        
        if(COUNT == 2'b00) begin
            CLK_FT <= 1;
            CLK_DC <= 0;
            CLK_EX <= 0;
            CLK_WB <= 0;
        end 
        else if(COUNT == 2'b01) begin
            CLK_FT <= 0;
            CLK_DC <= 1;
            CLK_EX <= 0;
            CLK_WB <= 0;
        end 
        else if(COUNT == 2'b10) begin
            CLK_FT <= 0;
            CLK_DC <= 0;
            CLK_EX <= 1;
            CLK_WB <= 0;
        end 
        else if(COUNT == 2'b11) begin
            CLK_FT <= 0;
            CLK_DC <= 0;
            CLK_EX <= 0;
            CLK_WB <= 1;
        end
        
    end

endmodule

