`timescale 1ns / 1ps
module COMPARATOR_8(
input [7:0] a, b,
output gt,lt,eq

);

wire [1:0] gt_in, lt_in, eq_in;

COMPARATOR_4 COMP_1(
.a(a[7:4]),
.b(b[7:4]),

.gt(gt_in[1]),
.lt(lt_in[1]),
.eq(eq_in[1])
);

COMPARATOR_4 COMP_2(
.a(a[3:0]),
.b(b[3:0]),

.gt(gt_in[0]),
.lt(lt_in[0]),
.eq(eq_in[0])
);

GLUE GLUE_1(
.gt_in(gt_in),
.lt_in(lt_in),
.eq_in(eq_in),

.gt_out(gt),
.lt_out(lt),
.eq_out(eq)
);

endmodule