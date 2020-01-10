`timescale 1ns / 1ps

//Wrapper for Carry-Lookahead-Logic and Partial Full Adders
module CLA #(parameter bits = 8) ( //parameter to specify number of bits for adder
input [bits-1:0] A, B, //augend and addend
input Cin,  //first carry in

output [bits-1:0] Sum, //sum output
output Cout //carry out bit

//output [bits-1:0]carries //for testbench
);

wire [bits-1:0]P_in, G_in; //wire bus for propagate and generate bits
wire [bits-1:0]carries; //wire bus for carry bits

assign Cout = carries[bits-1]; //propagate last carry out from msb of carries bus

//create partial full adder instance for the first bit to incorporate Cin
PFA PFA0(
.A(A[0]),
.B(B[0]),
.Cin(Cin),

.P(P_in[0]),
.G(G_in[0]),
.S(Sum[0])

);

genvar i;
generate //Instantiate N PFA's for bits
    for(i=1; i<bits; i=i+1) begin : PFAS
        PFA PFA_I(
            .A(A[i]),
            .B(B[i]),
            .Cin(carries[i-1]),
            
            .P(P_in[i]),
            .G(G_in[i]),
            .S(Sum[i])        
        );    
    end
endgenerate

//Instantiate Carry-Lookahead-Logic block
CLL #(.bits(bits)) CLL_INST(
.Cin(Cin),
.P(P_in),
.G(G_in),

.Cout(carries)
);

endmodule
//////////////////////////////////////////////////////////
//This module handles the carry outs for each partial full adder
//Acts as a wrapper to individual carry_gen modules
module CLL #(parameter bits = 8) (
    input Cin,
    input [bits-1: 0] P, G, 
    output [bits-1: 0] Cout
);

//Create carry generator block for first bit
CARRY_GEN INST0(
        .G(G[0]),
        .P(P[0]),
        .Cin(Cin),
        
        .Cout(Cout[0])        
);

genvar i;
generate //Create N bits of carry generators
    for(i=1; i < bits; i=i+1) begin : CARRIES
        CARRY_GEN INST_I(
        .G(G[i]),
        .P(P[i]),
        .Cin(Cout[i-1]),
        
        .Cout(Cout[i])        
        );
    
    end
endgenerate
endmodule

//////////////////////////////////////////////////////////
module ADD_HALF(
    output cout,
    output sum,
    input a,
    input b
);
    xor(sum, a, b);
    and(cout, a, b);
endmodule
//////////////////////////////////////////////////////////
//Calculates the propagate, generate, and sum bits
module PFA(
    input A, B, Cin,
    output P, G, S
);
    
    assign P = A ^ B;   //xor gate for propagate
    assign G = A & B;   // and gate for generate
    assign S = Cin ^ P; // xor gate for sum

endmodule
//////////////////////////////////////////////////////////
module FULL_ADDER(
    input a,b,cin,
    output cout,sum

);

wire half1_cout, half1_sum, half2_cout;

ADD_HALF HALF1(
.cout(half1_cout),
.sum(half1_sum),
.a(a),
.b(b)
);

ADD_HALF HALF2(
.cout(half2_cout),
.sum(sum),
.a(cin),
.b(half1_sum)
);

//for the carry out of both half adders
or(cout, half2_cout, half1_cout);

endmodule
//////////////////////////////////////////////////////////
//Calculates the carry using generate, propagate, and carry in bits
module CARRY_GEN(
    input G, P, Cin,
    output Cout    
);

assign Cout = G | P&Cin; //wire out carry calculation

endmodule
//////////////////////////////////////////////////////////
