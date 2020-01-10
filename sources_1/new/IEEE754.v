`timescale 1ns / 1ps
module IEEE754(
input [31:0] A,B,

output [31:0] Z,
output [1:0] comp_w,
output [7:0] test_alusub, test_mux_great,
output [22:0] test_mux_least, test_ans_shift, test_mux_high, test_add_ans
);

wire [7:0] x_exp, y_exp;

ADD_SUB INST1(
.a(A[30:23]),
.b(8'd127),
.sel(A[31]),

.ans(x_exp),
.carry()
);

ADD_SUB INST2(
.a(B[30:23]),
.b(8'd127),
.sel(B[31]),

.ans(y_exp),
.carry()
);
wire gt,lt,eq;
wire [1:0] comp;

COMPARATOR_8 INST3(
.a(x_exp),
.b(y_exp),

.gt(gt),
.lt(lt),
.eq(eq)
);

assign comp = {eq,gt};
assign comp_w = comp;

wire [7:0] addsubalu;
assign test_alusub = addsubalu;

ADD_SUB_ALU INST4(
.a(x_exp),
.b(y_exp),
.sel(comp),

.out(addsubalu)
);

wire [22:0] mux_least;
wire [22:0] ans_shift;

assign mux_least = comp ? {~B[31], B[22:1]} : {~A[31], A[22:1]};
assign test_mux_least = mux_least;

assign ans_shift = mux_least >> addsubalu;
assign test_ans_shift = ans_shift;

wire [22:0] mux_high;
assign mux_high = comp ? {~A[31], A[22:1]} : {~B[31], B[22:1]};
assign test_mux_high = mux_high;

wire [22:0] add_ans;
assign test_add_ans = add_ans;

CLA #(23) CLA_I(
.A(mux_high),
.B(ans_shift),
.Cin(1'b0),

.Sum(add_ans),
.Cout()
);

wire [7:0] mux_great;
assign mux_great = comp ? A[30:23] : B[30:23];
assign test_mux_great = mux_great;

assign Z = ({~add_ans[22], mux_great, {add_ans[21:0], 1'b0}});

endmodule