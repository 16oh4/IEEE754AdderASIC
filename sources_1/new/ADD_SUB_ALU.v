`timescale 1ns / 1ps
module ADD_SUB_ALU(
input [7:0] a,b,
input [1:0] sel,
output reg [7:0] out
);

//0 is B-A
//1 is A-B
//2 is pass A


always@(*) begin
    case(sel)
    2'b00: begin
        out = b-a;  
    end
    2'b01: begin
        out = a-b;
    end
    2'b10: begin
        out = a;
    end
    2'b11: begin
        out = out;
    end    
    endcase
end

/*
CLA #(8) CLA_I(
.A(mux_1),
.B(mux_2),
.Cin(1'b0),

.Sum(m_b),
.Cout(carry)
);
*/

endmodule