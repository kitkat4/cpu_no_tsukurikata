

module exec(CLK_EX, RESET_N, OP_CODE, REG_A, REG_B, OP_DATA, RAM_OUT, P_COUNT,
            REG_IN, RAM_IN, REG_WEN, RAM_WEN);

    input         CLK_EX;
    input         RESET_N;
    input [3:0]   OP_CODE;
    input [15:0]  REG_A;
    input [15:0]  REG_B;
    input [7:0]   OP_DATA;
    input [15:0]  RAM_OUT;
    output [7:0]  P_COUNT;
    output [15:0] REG_IN;
    output [15:0] RAM_IN;
    output        REG_WEN;
    output        RAM_WEN;

    reg [7:0]     P_COUNT = 0;
    reg [15:0]    REG_IN = 0;
    reg [15:0]    RAM_IN = 0;
    reg           REG_WEN = 0;
    reg           RAM_WEN = 0;
    reg           CMP_FLAG = 0;
    
    always@(posedge CLK_EX) begin

        if(RESET_N == 1'b0) begin
            P_COUNT <= 0;
            CMP_FLAG <= 0;
        end else begin
            
            case(OP_CODE)
                
                4'h0: begin     // MOV
                    REG_IN  <= REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h1: begin     // ADD
                    REG_IN  <= REG_A + REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h2: begin     // SUB
                    REG_IN  <= REG_A - REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h3: begin     // AND
                    REG_IN  <= REG_A & REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h4: begin     // OR
                    REG_IN  <= REG_A | REG_B;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h5: begin     // SL
                    REG_IN  <= (REG_A << 1);
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h6: begin     // SR
                    REG_IN  <= (REG_A >> 1);
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h7: begin     // SRA
                    REG_IN  <= ((REG_A >> 1) | REG_A & 16'h8000);
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end 

                4'h8: begin     // LDL
                    REG_IN  <= {REG_A[15:8], OP_DATA};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'h9: begin     // LDH
                    REG_IN  <= {OP_DATA, REG_A[7:0]};
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'hA: begin     // CMP
                    CMP_FLAG <= REG_A == REG_B ? 1'b1 : 1'b0;
                    REG_WEN  <= 0;
                    RAM_WEN  <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'hB: begin     // JE
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                    P_COUNT <= CMP_FLAG ? OP_DATA : P_COUNT + 8'h01;
                end

                4'hC: begin     // JMP
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                    P_COUNT <= OP_DATA;
                end

                4'hD: begin     // LD
                    REG_IN  <= RAM_OUT;
                    REG_WEN <= 1;
                    RAM_WEN <= 0;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'hE: begin     // ST
                    RAM_IN  <= REG_A;
                    REG_WEN <= 0;
                    RAM_WEN <= 1;
                    P_COUNT <= P_COUNT + 8'h01;
                end

                4'hF: begin     // HLT
                    REG_WEN <= 0;
                    RAM_WEN <= 0;
                end
                
            endcase // case (OP_CODE)

        end // else: !if(RESET_N)
        
    end // always@ (posedge CLK_EX)

endmodule // exec


