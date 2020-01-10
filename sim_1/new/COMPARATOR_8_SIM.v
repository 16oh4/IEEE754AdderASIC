`timescale 1ns / 1ps
module COMPARATOR_8_SIM();

reg [7:0] a,b;
wire gt,lt,eq;

COMPARATOR_8 UUT(
.a(a),
.b(b),

.gt(gt),
.lt(lt),
.eq(eq)
);

initial begin
a = 8'hAA;
b = 8'hBB;

#5;

a = 8'hCC;
b = 8'hCC;

#5;

a= 8'h22;
b= 8'h11;

end


endmodule