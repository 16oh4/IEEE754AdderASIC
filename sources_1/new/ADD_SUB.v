`timescale 1ns / 1ps

//if sel ==0  subtract A-B
//if sel ==1 add A+B
module ADD_SUB(
input [7:0] a, b,
input sel,

output [7:0] ans,
output carry

);
wire [7:0] add, sub;
wire [7:0] b_cla;

//(8'h7F)
assign b_cla = sel ? b : (~b + 1);


CLA #(8) CLA_I(
.A(a),
.B(b_cla),
.Cin(1'b0),

.Sum(ans),
.Cout(carry)
);



endmodule
