`timescale 1ns / 1ps
module ADD_SUB_ALU_SIM();

reg [7:0] a,b;
reg [1:0] sel;

wire [7:0] out;


ADD_SUB_ALU UUT(
.a(a),
.b(b),
.sel(sel),

.out(out)
);

initial begin
a = 8'h7;
b = 8'h8;

sel = 0;

#5;
a = 8'h4;
b = 8'h1;

sel = 1;

#5;
a = 8'h7;
b = 8'h8;

sel = 2;

end

endmodule