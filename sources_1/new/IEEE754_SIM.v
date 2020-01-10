`timescale 1ns / 1ps
module IEEE754_SIM();

reg [31:0] a,b;
wire [31:0] z;
wire [1:0] comp_w;
wire [7:0] test_alusub, test_mux_great;
wire [22:0] test_mux_least, test_ans_shift, test_mux_high,test_add_ans;

IEEE754 UUT(
.A(a),
.B(b),
.Z(z),
.comp_w(comp_w),
.test_alusub(test_alusub),
.test_mux_least(test_mux_least),
.test_ans_shift(test_ans_shift),
.test_mux_high(test_mux_high),
.test_add_ans(test_add_ans),
.test_mux_great(test_mux_great)
);



initial begin
a = 32'h420F_0000;
b = 32'h41A4_0000;



end
  
endmodule