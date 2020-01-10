`timescale 1ns / 1ps
module SRL(
input [23:0] a,
input [4:0] shift, //5 bits to represent up to 32... need only 23 for mantissa
output [23:0] ans
);

assign ans = a >> shift;

endmodule