`timescale 1ns / 1ps
module COMPARATOR_4_SIM();

reg [3:0] a,b;
wire gt,lt,eq;
wire [1:0] gt_in, lt_in, eq_in;


COMPARATOR_4 UUT(
.a(a),
.b(b),

.gt(gt),
.lt(lt),
.eq(eq)
);

initial begin
a = 4'hA;
b = 4'hB;

#5;

a = 4'hC;
b = 4'hC;

#5;

a= 4'h2;
b= 4'h1;

end

endmodule