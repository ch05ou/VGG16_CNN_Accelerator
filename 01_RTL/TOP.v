module TOP (
    input clk,reset,
    input [8:0]pix_ch1,pix_ch2,pix_ch3,pix_ch4,

    input signed[15:0]g1c1_kernel0,g1c1_kernel1,g1c1_kernel2,g1c1_kernel3,g1c1_kernel4,g1c1_kernel5,g1c1_kernel6,g1c1_kernel7,g1c1_kernel8,
    input signed[15:0]g1c2_kernel0,g1c2_kernel1,g1c2_kernel2,g1c2_kernel3,g1c2_kernel4,g1c2_kernel5,g1c2_kernel6,g1c2_kernel7,g1c2_kernel8,
    input signed[15:0]g1c3_kernel0,g1c3_kernel1,g1c3_kernel2,g1c3_kernel3,g1c3_kernel4,g1c3_kernel5,g1c3_kernel6,g1c3_kernel7,g1c3_kernel8,
    input signed[15:0]g1c4_kernel0,g1c4_kernel1,g1c4_kernel2,g1c4_kernel3,g1c4_kernel4,g1c4_kernel5,g1c4_kernel6,g1c4_kernel7,g1c4_kernel8,

    input signed[15:0]g2c1_kernel0,g2c1_kernel1,g2c1_kernel2,g2c1_kernel3,g2c1_kernel4,g2c1_kernel5,g2c1_kernel6,g2c1_kernel7,g2c1_kernel8,
    input signed[15:0]g2c2_kernel0,g2c2_kernel1,g2c2_kernel2,g2c2_kernel3,g2c2_kernel4,g2c2_kernel5,g2c2_kernel6,g2c2_kernel7,g2c2_kernel8,
    input signed[15:0]g2c3_kernel0,g2c3_kernel1,g2c3_kernel2,g2c3_kernel3,g2c3_kernel4,g2c3_kernel5,g2c3_kernel6,g2c3_kernel7,g2c3_kernel8,
    input signed[15:0]g2c4_kernel0,g2c4_kernel1,g2c4_kernel2,g2c4_kernel3,g2c4_kernel4,g2c4_kernel5,g2c4_kernel6,g2c4_kernel7,g2c4_kernel8,

    input signed[15:0]g3c1_kernel0,g3c1_kernel1,g3c1_kernel2,g3c1_kernel3,g3c1_kernel4,g3c1_kernel5,g3c1_kernel6,g3c1_kernel7,g3c1_kernel8,
    input signed[15:0]g3c2_kernel0,g3c2_kernel1,g3c2_kernel2,g3c2_kernel3,g3c2_kernel4,g3c2_kernel5,g3c2_kernel6,g3c2_kernel7,g3c2_kernel8,
    input signed[15:0]g3c3_kernel0,g3c3_kernel1,g3c3_kernel2,g3c3_kernel3,g3c3_kernel4,g3c3_kernel5,g3c3_kernel6,g3c3_kernel7,g3c3_kernel8,
    input signed[15:0]g3c4_kernel0,g3c4_kernel1,g3c4_kernel2,g3c4_kernel3,g3c4_kernel4,g3c4_kernel5,g3c4_kernel6,g3c4_kernel7,g3c4_kernel8,

    input signed[15:0]g4c1_kernel0,g4c1_kernel1,g4c1_kernel2,g4c1_kernel3,g4c1_kernel4,g4c1_kernel5,g4c1_kernel6,g4c1_kernel7,g4c1_kernel8,
    input signed[15:0]g4c2_kernel0,g4c2_kernel1,g4c2_kernel2,g4c2_kernel3,g4c2_kernel4,g4c2_kernel5,g4c2_kernel6,g4c2_kernel7,g4c2_kernel8,
    input signed[15:0]g4c3_kernel0,g4c3_kernel1,g4c3_kernel2,g4c3_kernel3,g4c3_kernel4,g4c3_kernel5,g4c3_kernel6,g4c3_kernel7,g4c3_kernel8,
    input signed[15:0]g4c4_kernel0,g4c4_kernel1,g4c4_kernel2,g4c4_kernel3,g4c4_kernel4,g4c4_kernel5,g4c4_kernel6,g4c4_kernel7,g4c4_kernel8,
    
    input signed[35:0]g1_ps_data1,g1_ps_data2,g1_ps_data3,g1_ps_data4,
                      g1_ps_data5,g1_ps_data6,g1_ps_data7,g1_ps_data8,
                      g1_ps_data9,g1_ps_data10,g1_ps_data11,g1_ps_data12,
                      g1_ps_data13,g1_ps_data14,g1_ps_data15,g1_ps_data16,
    input signed[15:0]g1_bias,

    input signed[35:0]g2_ps_data1,g2_ps_data2,g2_ps_data3,g2_ps_data4,
                      g2_ps_data5,g2_ps_data6,g2_ps_data7,g2_ps_data8,
                      g2_ps_data9,g2_ps_data10,g2_ps_data11,g2_ps_data12,
                      g2_ps_data13,g2_ps_data14,g2_ps_data15,g2_ps_data16,
    input signed[15:0]g2_bias,

    
    input signed[35:0]g3_ps_data1,g3_ps_data2,g3_ps_data3,g3_ps_data4,
                      g3_ps_data5,g3_ps_data6,g3_ps_data7,g3_ps_data8,
                      g3_ps_data9,g3_ps_data10,g3_ps_data11,g3_ps_data12,
                      g3_ps_data13,g3_ps_data14,g3_ps_data15,g3_ps_data16,
    input signed[15:0]g3_bias,
    
    input signed[35:0]g4_ps_data1,g4_ps_data2,g4_ps_data3,g4_ps_data4,
                      g4_ps_data5,g4_ps_data6,g4_ps_data7,g4_ps_data8,
                      g4_ps_data9,g4_ps_data10,g4_ps_data11,g4_ps_data12,
                      g4_ps_data13,g4_ps_data14,g4_ps_data15,g4_ps_data16,
    input signed[15:0]g4_bias,

    output lb_en1,lb_en2,lb_en3,lb_en4,
    output signed[35:0]g1_sum,g2_sum,g3_sum,g4_sum,
    output [35:0]img1_res,img2_res,img3_res,img4_res
);
    
    wire signed[8:0]LB1_R0,LB1_R1,LB1_R2,LB1_R3,LB1_R4,LB1_R5,LB1_R6,LB1_R7,LB1_R8;
    wire signed[8:0]LB2_R0,LB2_R1,LB2_R2,LB2_R3,LB2_R4,LB2_R5,LB2_R6,LB2_R7,LB2_R8;
    wire signed[8:0]LB3_R0,LB3_R1,LB3_R2,LB3_R3,LB3_R4,LB3_R5,LB3_R6,LB3_R7,LB3_R8;
    wire signed[8:0]LB4_R0,LB4_R1,LB4_R2,LB4_R3,LB4_R4,LB4_R5,LB4_R6,LB4_R7,LB4_R8;

    wire signed[28:0]g1c1_sum,g1c2_sum,g1c3_sum,g1c4_sum;
    wire signed[28:0]g2c1_sum,g2c2_sum,g2c3_sum,g2c4_sum;
    wire signed[28:0]g3c1_sum,g3c2_sum,g3c3_sum,g3c4_sum;
    wire signed[28:0]g4c1_sum,g4c2_sum,g4c3_sum,g4c4_sum;

    LineBuffer LB1(.clk(clk),.rst(reset),.Y(pix_ch1),.cal_en(lb_en1),
                    .R0(LB1_R0),.R1(LB1_R1),.R2(LB1_R2),
                    .R3(LB1_R3),.R4(LB1_R4),.R5(LB1_R5),
                    .R6(LB1_R6),.R7(LB1_R7),.R8(LB1_R8));

    LineBuffer LB2(.clk(clk),.rst(reset),.Y(pix_ch2),.cal_en(lb_en2),
                    .R0(LB2_R0),.R1(LB2_R1),.R2(LB2_R2),
                    .R3(LB2_R3),.R4(LB2_R4),.R5(LB2_R5),
                    .R6(LB2_R6),.R7(LB2_R7),.R8(LB2_R8));

    LineBuffer LB3(.clk(clk),.rst(reset),.Y(pix_ch3),.cal_en(lb_en3),
                    .R0(LB3_R0),.R1(LB3_R1),.R2(LB3_R2),
                    .R3(LB3_R3),.R4(LB3_R4),.R5(LB3_R5),
                    .R6(LB3_R6),.R7(LB3_R7),.R8(LB3_R8));

    LineBuffer LB4(.clk(clk),.rst(reset),.Y(pix_ch4),.cal_en(lb_en4),
                    .R0(LB4_R0),.R1(LB4_R1),.R2(LB4_R2),
                    .R3(LB4_R3),.R4(LB4_R4),.R5(LB4_R5),
                    .R6(LB4_R6),.R7(LB4_R7),.R8(LB4_R8));
                    
    PE_group G1(.clk(clk),.reset(reset),
                .c1_data0(LB1_R0),.c1_data1(LB1_R1),.c1_data2(LB1_R2),
                .c1_data3(LB1_R3),.c1_data4(LB1_R4),.c1_data5(LB1_R5),
                .c1_data6(LB1_R6),.c1_data7(LB1_R7),.c1_data8(LB1_R8),

                .c2_data0(LB2_R0),.c2_data1(LB2_R1),.c2_data2(LB2_R2),
                .c2_data3(LB2_R3),.c2_data4(LB2_R4),.c2_data5(LB2_R5),
                .c2_data6(LB2_R6),.c2_data7(LB2_R7),.c2_data8(LB2_R8),

                .c3_data0(LB3_R0),.c3_data1(LB3_R1),.c3_data2(LB3_R2),
                .c3_data3(LB3_R3),.c3_data4(LB3_R4),.c3_data5(LB3_R5),
                .c3_data6(LB3_R6),.c3_data7(LB3_R7),.c3_data8(LB3_R8),
                
                .c4_data0(LB4_R0),.c4_data1(LB4_R1),.c4_data2(LB4_R2),
                .c4_data3(LB4_R3),.c4_data4(LB4_R4),.c4_data5(LB4_R5),
                .c4_data6(LB4_R6),.c4_data7(LB4_R7),.c4_data8(LB4_R8),
                .c1_kernel0(g1c1_kernel0),.c1_kernel1(g1c1_kernel1),.c1_kernel2(g1c1_kernel2),
                .c1_kernel3(g1c1_kernel3),.c1_kernel4(g1c1_kernel4),.c1_kernel5(g1c1_kernel5),
                .c1_kernel6(g1c1_kernel6),.c1_kernel7(g1c1_kernel7),.c1_kernel8(g1c1_kernel8),
                .c2_kernel0(g1c2_kernel0),.c2_kernel1(g1c2_kernel1),.c2_kernel2(g1c2_kernel2),
                .c2_kernel3(g1c2_kernel3),.c2_kernel4(g1c2_kernel4),.c2_kernel5(g1c2_kernel5),
                .c2_kernel6(g1c2_kernel6),.c2_kernel7(g1c2_kernel7),.c2_kernel8(g1c2_kernel8),
                .c3_kernel0(g1c3_kernel0),.c3_kernel1(g1c3_kernel1),.c3_kernel2(g1c3_kernel2),
                .c3_kernel3(g1c3_kernel3),.c3_kernel4(g1c3_kernel4),.c3_kernel5(g1c3_kernel5),
                .c3_kernel6(g1c3_kernel6),.c3_kernel7(g1c3_kernel7),.c3_kernel8(g1c3_kernel8),
                .c4_kernel0(g1c4_kernel0),.c4_kernel1(g1c4_kernel1),.c4_kernel2(g1c4_kernel2),
                .c4_kernel3(g1c4_kernel3),.c4_kernel4(g1c4_kernel4),.c4_kernel5(g1c4_kernel5),
                .c4_kernel6(g1c4_kernel6),.c4_kernel7(g1c4_kernel7),.c4_kernel8(g1c4_kernel8),
                .c1_sum(g1c1_sum),.c2_sum(g1c2_sum),.c3_sum(g1c3_sum),.c4_sum(g1c4_sum));

    PE_group G2(.clk(clk),.reset(reset),
                .c1_data0(LB1_R0),.c1_data1(LB1_R1),.c1_data2(LB1_R2),
                .c1_data3(LB1_R3),.c1_data4(LB1_R4),.c1_data5(LB1_R5),
                .c1_data6(LB1_R6),.c1_data7(LB1_R7),.c1_data8(LB1_R8),

                .c2_data0(LB2_R0),.c2_data1(LB2_R1),.c2_data2(LB2_R2),
                .c2_data3(LB2_R3),.c2_data4(LB2_R4),.c2_data5(LB2_R5),
                .c2_data6(LB2_R6),.c2_data7(LB2_R7),.c2_data8(LB2_R8),

                .c3_data0(LB3_R0),.c3_data1(LB3_R1),.c3_data2(LB3_R2),
                .c3_data3(LB3_R3),.c3_data4(LB3_R4),.c3_data5(LB3_R5),
                .c3_data6(LB3_R6),.c3_data7(LB3_R7),.c3_data8(LB3_R8),
                
                .c4_data0(LB4_R0),.c4_data1(LB4_R1),.c4_data2(LB4_R2),
                .c4_data3(LB4_R3),.c4_data4(LB4_R4),.c4_data5(LB4_R5),
                .c4_data6(LB4_R6),.c4_data7(LB4_R7),.c4_data8(LB4_R8),
                .c1_kernel0(g2c1_kernel0),.c1_kernel1(g2c1_kernel1),.c1_kernel2(g2c1_kernel2),
                .c1_kernel3(g2c1_kernel3),.c1_kernel4(g2c1_kernel4),.c1_kernel5(g2c1_kernel5),
                .c1_kernel6(g2c1_kernel6),.c1_kernel7(g2c1_kernel7),.c1_kernel8(g2c1_kernel8),
                .c2_kernel0(g2c2_kernel0),.c2_kernel1(g2c2_kernel1),.c2_kernel2(g2c2_kernel2),
                .c2_kernel3(g2c2_kernel3),.c2_kernel4(g2c2_kernel4),.c2_kernel5(g2c2_kernel5),
                .c2_kernel6(g2c2_kernel6),.c2_kernel7(g2c2_kernel7),.c2_kernel8(g2c2_kernel8),
                .c3_kernel0(g2c3_kernel0),.c3_kernel1(g2c3_kernel1),.c3_kernel2(g2c3_kernel2),
                .c3_kernel3(g2c3_kernel3),.c3_kernel4(g2c3_kernel4),.c3_kernel5(g2c3_kernel5),
                .c3_kernel6(g2c3_kernel6),.c3_kernel7(g2c3_kernel7),.c3_kernel8(g2c3_kernel8),
                .c4_kernel0(g2c4_kernel0),.c4_kernel1(g2c4_kernel1),.c4_kernel2(g2c4_kernel2),
                .c4_kernel3(g2c4_kernel3),.c4_kernel4(g2c4_kernel4),.c4_kernel5(g2c4_kernel5),
                .c4_kernel6(g2c4_kernel6),.c4_kernel7(g2c4_kernel7),.c4_kernel8(g2c4_kernel8),
                .c1_sum(g2c1_sum),.c2_sum(g2c2_sum),.c3_sum(g2c3_sum),.c4_sum(g2c4_sum));

    PE_group G3(.clk(clk),.reset(reset),
                .c1_data0(LB1_R0),.c1_data1(LB1_R1),.c1_data2(LB1_R2),
                .c1_data3(LB1_R3),.c1_data4(LB1_R4),.c1_data5(LB1_R5),
                .c1_data6(LB1_R6),.c1_data7(LB1_R7),.c1_data8(LB1_R8),

                .c2_data0(LB2_R0),.c2_data1(LB2_R1),.c2_data2(LB2_R2),
                .c2_data3(LB2_R3),.c2_data4(LB2_R4),.c2_data5(LB2_R5),
                .c2_data6(LB2_R6),.c2_data7(LB2_R7),.c2_data8(LB2_R8),

                .c3_data0(LB3_R0),.c3_data1(LB3_R1),.c3_data2(LB3_R2),
                .c3_data3(LB3_R3),.c3_data4(LB3_R4),.c3_data5(LB3_R5),
                .c3_data6(LB3_R6),.c3_data7(LB3_R7),.c3_data8(LB3_R8),
                
                .c4_data0(LB4_R0),.c4_data1(LB4_R1),.c4_data2(LB4_R2),
                .c4_data3(LB4_R3),.c4_data4(LB4_R4),.c4_data5(LB4_R5),
                .c4_data6(LB4_R6),.c4_data7(LB4_R7),.c4_data8(LB4_R8),
                .c1_kernel0(g3c1_kernel0),.c1_kernel1(g3c1_kernel1),.c1_kernel2(g3c1_kernel2),
                .c1_kernel3(g3c1_kernel3),.c1_kernel4(g3c1_kernel4),.c1_kernel5(g3c1_kernel5),
                .c1_kernel6(g3c1_kernel6),.c1_kernel7(g3c1_kernel7),.c1_kernel8(g3c1_kernel8),
                .c2_kernel0(g3c2_kernel0),.c2_kernel1(g3c2_kernel1),.c2_kernel2(g3c2_kernel2),
                .c2_kernel3(g3c2_kernel3),.c2_kernel4(g3c2_kernel4),.c2_kernel5(g3c2_kernel5),
                .c2_kernel6(g3c2_kernel6),.c2_kernel7(g3c2_kernel7),.c2_kernel8(g3c2_kernel8),
                .c3_kernel0(g3c3_kernel0),.c3_kernel1(g3c3_kernel1),.c3_kernel2(g3c3_kernel2),
                .c3_kernel3(g3c3_kernel3),.c3_kernel4(g3c3_kernel4),.c3_kernel5(g3c3_kernel5),
                .c3_kernel6(g3c3_kernel6),.c3_kernel7(g3c3_kernel7),.c3_kernel8(g3c3_kernel8),
                .c4_kernel0(g3c4_kernel0),.c4_kernel1(g3c4_kernel1),.c4_kernel2(g3c4_kernel2),
                .c4_kernel3(g3c4_kernel3),.c4_kernel4(g3c4_kernel4),.c4_kernel5(g3c4_kernel5),
                .c4_kernel6(g3c4_kernel6),.c4_kernel7(g3c4_kernel7),.c4_kernel8(g3c4_kernel8),
                .c1_sum(g3c1_sum),.c2_sum(g3c2_sum),.c3_sum(g3c3_sum),.c4_sum(g3c4_sum));

    PE_group G4(.clk(clk),.reset(reset),
                .c1_data0(LB1_R0),.c1_data1(LB1_R1),.c1_data2(LB1_R2),
                .c1_data3(LB1_R3),.c1_data4(LB1_R4),.c1_data5(LB1_R5),
                .c1_data6(LB1_R6),.c1_data7(LB1_R7),.c1_data8(LB1_R8),

                .c2_data0(LB2_R0),.c2_data1(LB2_R1),.c2_data2(LB2_R2),
                .c2_data3(LB2_R3),.c2_data4(LB2_R4),.c2_data5(LB2_R5),
                .c2_data6(LB2_R6),.c2_data7(LB2_R7),.c2_data8(LB2_R8),

                .c3_data0(LB3_R0),.c3_data1(LB3_R1),.c3_data2(LB3_R2),
                .c3_data3(LB3_R3),.c3_data4(LB3_R4),.c3_data5(LB3_R5),
                .c3_data6(LB3_R6),.c3_data7(LB3_R7),.c3_data8(LB3_R8),
                
                .c4_data0(LB4_R0),.c4_data1(LB4_R1),.c4_data2(LB4_R2),
                .c4_data3(LB4_R3),.c4_data4(LB4_R4),.c4_data5(LB4_R5),
                .c4_data6(LB4_R6),.c4_data7(LB4_R7),.c4_data8(LB4_R8),
                .c1_kernel0(g4c1_kernel0),.c1_kernel1(g4c1_kernel1),.c1_kernel2(g4c1_kernel2),
                .c1_kernel3(g4c1_kernel3),.c1_kernel4(g4c1_kernel4),.c1_kernel5(g4c1_kernel5),
                .c1_kernel6(g4c1_kernel6),.c1_kernel7(g4c1_kernel7),.c1_kernel8(g4c1_kernel8),
                .c2_kernel0(g4c2_kernel0),.c2_kernel1(g4c2_kernel1),.c2_kernel2(g4c2_kernel2),
                .c2_kernel3(g4c2_kernel3),.c2_kernel4(g4c2_kernel4),.c2_kernel5(g4c2_kernel5),
                .c2_kernel6(g4c2_kernel6),.c2_kernel7(g4c2_kernel7),.c2_kernel8(g4c2_kernel8),
                .c3_kernel0(g4c3_kernel0),.c3_kernel1(g4c3_kernel1),.c3_kernel2(g4c3_kernel2),
                .c3_kernel3(g4c3_kernel3),.c3_kernel4(g4c3_kernel4),.c3_kernel5(g4c3_kernel5),
                .c3_kernel6(g4c3_kernel6),.c3_kernel7(g4c3_kernel7),.c3_kernel8(g4c3_kernel8),
                .c4_kernel0(g4c4_kernel0),.c4_kernel1(g4c4_kernel1),.c4_kernel2(g4c4_kernel2),
                .c4_kernel3(g4c4_kernel3),.c4_kernel4(g4c4_kernel4),.c4_kernel5(g4c4_kernel5),
                .c4_kernel6(g4c4_kernel6),.c4_kernel7(g4c4_kernel7),.c4_kernel8(g4c4_kernel8),
                .c1_sum(g4c1_sum),.c2_sum(g4c2_sum),.c3_sum(g4c3_sum),.c4_sum(g4c4_sum));

    PS PS_G1(.c1_sum(g1c1_sum),.c2_sum(g1c2_sum),.c3_sum(g1c3_sum),.c4_sum(g1c4_sum),.sum(g1_sum));

    PS PS_G2(.c1_sum(g2c1_sum),.c2_sum(g2c2_sum),.c3_sum(g2c3_sum),.c4_sum(g2c4_sum),.sum(g2_sum));

    PS PS_G3(.c1_sum(g3c1_sum),.c2_sum(g3c2_sum),.c3_sum(g3c3_sum),.c4_sum(g3c4_sum),.sum(g3_sum));

    PS PS_G4(.c1_sum(g4c1_sum),.c2_sum(g4c2_sum),.c3_sum(g4c3_sum),.c4_sum(g4c4_sum),.sum(g4_sum));

    ReLU relu_G1(.ps_data1(g1_ps_data1),.ps_data2(g1_ps_data2),.ps_data3(g1_ps_data3),.ps_data4(g1_ps_data4),
              .ps_data5(g1_ps_data5),.ps_data6(g1_ps_data6),.ps_data7(g1_ps_data7),.ps_data8(g1_ps_data8),
              .ps_data9(g1_ps_data9),.ps_data10(g1_ps_data10),.ps_data11(g1_ps_data11),.ps_data12(g1_ps_data12),
              .ps_data13(g1_ps_data13),.ps_data14(g1_ps_data14),.ps_data15(g1_ps_data15),.ps_data16(g1_ps_data16),
              .bias(g1_bias),.img_res(img1_res));
              
    ReLU relu_G2(.ps_data1(g2_ps_data1),.ps_data2(g2_ps_data2),.ps_data3(g2_ps_data3),.ps_data4(g2_ps_data4),
              .ps_data5(g2_ps_data5),.ps_data6(g2_ps_data6),.ps_data7(g2_ps_data7),.ps_data8(g2_ps_data8),
              .ps_data9(g2_ps_data9),.ps_data10(g2_ps_data10),.ps_data11(g2_ps_data11),.ps_data12(g2_ps_data12),
              .ps_data13(g2_ps_data13),.ps_data14(g2_ps_data14),.ps_data15(g2_ps_data15),.ps_data16(g2_ps_data16),
              .bias(g2_bias),.img_res(img2_res));

    ReLU relu_G3(.ps_data1(g3_ps_data1),.ps_data2(g3_ps_data2),.ps_data3(g3_ps_data3),.ps_data4(g3_ps_data4),
              .ps_data5(g3_ps_data5),.ps_data6(g3_ps_data6),.ps_data7(g3_ps_data7),.ps_data8(g3_ps_data8),
              .ps_data9(g3_ps_data9),.ps_data10(g3_ps_data10),.ps_data11(g3_ps_data11),.ps_data12(g3_ps_data12),
              .ps_data13(g3_ps_data13),.ps_data14(g3_ps_data14),.ps_data15(g3_ps_data15),.ps_data16(g3_ps_data16),
              .bias(g3_bias),.img_res(img3_res));

    ReLU relu_G4(.ps_data1(g4_ps_data1),.ps_data2(g4_ps_data2),.ps_data3(g4_ps_data3),.ps_data4(g4_ps_data4),
              .ps_data5(g4_ps_data5),.ps_data6(g4_ps_data6),.ps_data7(g4_ps_data7),.ps_data8(g4_ps_data8),
              .ps_data9(g4_ps_data9),.ps_data10(g4_ps_data10),.ps_data11(g4_ps_data11),.ps_data12(g4_ps_data12),
              .ps_data13(g4_ps_data13),.ps_data14(g4_ps_data14),.ps_data15(g4_ps_data15),.ps_data16(g4_ps_data16),
              .bias(g4_bias),.img_res(img4_res));

endmodule