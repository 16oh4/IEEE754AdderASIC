`timescale 1ns / 1ps
module ADD_SUB_SIM();

reg [7:0] a,b;
reg sel;

wire [7:0] ans;
wire carry;


ADD_SUB UUT(
.a(a),
.b(b),
.sel(sel),

.ans(ans),
.carry(carry)
);

initial begin
a = 8'd132;
b = 8'd127;
sel = 0;

#5;

a = 8'h0B;
b = 8'h04;
sel = 1;




end


endmodule