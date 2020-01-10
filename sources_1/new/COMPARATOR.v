`timescale 1ns / 1ps
module COMPARATOR(
input [1:0] a, b,
output gt, lt, eq
);
    
assign lt = ~a[1] & b[1] | ~a[1] & ~a[0] & b[0] | ~a[0] & b[1] & b[0];
assign gt = a[1] & ~b[1] | a[0] & ~b[1] & ~b[0] | a[1] & a[0] & ~b[0];
assign eq = ~a[1]&~a[0]&~b[1]&~b[0] | ~a[1] & a[0] & ~b[1] & b[0] | a[1] & a[0] & b[1] & b[0] | a[1] & ~a[0] & b[1] & ~b[0];
    
    
endmodule