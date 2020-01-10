
/*
`timescale 1ns / 1ps

////////////////////// NO LESS THAN 4 BITS //////////////////////////
module COMPARATOR_VAR #(parameter bits = 4) ( 
input [bits-1:0] a, b,

output gt,lt,eq
);


//for every 2 bits there is one comparator
wire [bits/2-1:0] gt_in;
wire [bits/2-1:0] lt_in;
wire [bits/2-1:0] eq_in;


//for every two comparators there is one glue ===
//for every 4 bits there is one glue
//dont use MSB
wire [bits/4:0] glue_gt, glue_lt, glue_eq;
//
//0 = 4 bits
1 = 8 bits


//take the i=0 case out of the iteration to save processing

genvar i,j;
generate
    for(i = 0; i <= bits; i = i + 1) begin
        if( i==0 ) begin //if comparator is 2 bits
            COMPARATOR INST_C0(
                .a(a[1:0]),
                .b(b[1:0]),
                
                .gt(gt[0]),
                .lt(lt[0]),
                .eq(eq[0])
            );        
        end
        else if( i==1 ) begin //if comparator is 4 bits
            COMPARATOR INST_C1(
                .a(a[3:2]),
                .b(b[3:2]),
                
                .gt(gt[1]),
                .lt(lt[1]),
                .eq(eq[1])
            );
            
            GLUE INST_G1( //TAKES M1 AND M0
                .gt_in(gt[1:0]),
                .lt_in(lt[1:0]),
                .eq_in(eq[1:0]),
                
                .gt_out(glue_gt[0]), //FIX
                .lt_out(glue_lt[0]), //FIX
                .eq_out(glue_eq[0])  //FIX      
            );          
        end
        
        else begin //i==2 here
            for(j = 0; j < 2**(i-1); j = j + 1) begin
            
                if((j+1)%2 == 0) begin //add glue every two iterations
                    GLUE INST_GJ( //TAKES M3 AND M2
                        .gt_in(gt[3:2]),
                        .lt_in(lt[i*2-1:0]),
                        .eq_in(eq[i*2-1:0]),
                        
                        .gt_out(glue_gt[i-1]), //FIX
                        .lt_out(glue_lt[i-1]), //FIX
                        .eq_out(glue_eq[i-1])  //FIX      
                    );                
                end
                COMPARATOR INST_CJ(
                        .a(a[i*2+1:i*2-1]),
                        .b(b[i*2+1:i*2-1]),
                        
                        .gt(gt[i]),
                        .lt(lt[i]),
                        .eq(eq[i])
                    );
            end
        
        end
       
    
    end



endgenerate
endmodule


*/