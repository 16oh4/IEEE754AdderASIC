`timescale 1ns / 1ps
module COMPARATOR_4(
    input [3:0] a, b,
    output gt,lt,eq
);
    
wire [1:0] gt_in, lt_in, eq_in;
    
COMPARATOR HI(
.a(a[3:2]),
.b(b[3:2]),

.gt(gt_in[1]),
.lt(lt_in[1]),
.eq(eq_in[1])
);

COMPARATOR LO(
.a(a[1:0]),
.b(b[1:0]),

.gt(gt_in[0]),
.lt(lt_in[0]),
.eq(eq_in[0])
);

GLUE GLUE_I(
.gt_in(gt_in),
.lt_in(lt_in),
.eq_in(eq_in),

.gt_out(gt),
.lt_out(lt),
.eq_out(eq)
);


endmodule

module GLUE (
    input [1:0] gt_in, lt_in, eq_in,
    output gt_out, lt_out, eq_out
);

wire [1:0] and_w;

//lvl 1
and(and_w[1], eq_in[1], gt_in[0]);
and(and_w[0], eq_in[1], lt_in[0]);

//lvl 2
or(gt_out, gt_in[1], and_w[1]);
or(lt_out, lt_in[1], and_w[0]);
and(eq_out, eq_in[1], eq_in[0]);

endmodule
