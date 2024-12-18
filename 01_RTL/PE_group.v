module PE_group(
    input clk,reset,
    input signed[8:0]c1_data0,c1_data1,c1_data2,c1_data3,c1_data4,c1_data5,c1_data6,c1_data7,c1_data8,
    input signed[8:0]c2_data0,c2_data1,c2_data2,c2_data3,c2_data4,c2_data5,c2_data6,c2_data7,c2_data8,
    input signed[8:0]c3_data0,c3_data1,c3_data2,c3_data3,c3_data4,c3_data5,c3_data6,c3_data7,c3_data8,
    input signed[8:0]c4_data0,c4_data1,c4_data2,c4_data3,c4_data4,c4_data5,c4_data6,c4_data7,c4_data8,

    input signed[15:0]c1_kernel0,c1_kernel1,c1_kernel2,c1_kernel3,c1_kernel4,c1_kernel5,c1_kernel6,c1_kernel7,c1_kernel8,
    input signed[15:0]c2_kernel0,c2_kernel1,c2_kernel2,c2_kernel3,c2_kernel4,c2_kernel5,c2_kernel6,c2_kernel7,c2_kernel8,
    input signed[15:0]c3_kernel0,c3_kernel1,c3_kernel2,c3_kernel3,c3_kernel4,c3_kernel5,c3_kernel6,c3_kernel7,c3_kernel8,
    input signed[15:0]c4_kernel0,c4_kernel1,c4_kernel2,c4_kernel3,c4_kernel4,c4_kernel5,c4_kernel6,c4_kernel7,c4_kernel8,

    output signed[28:0]c1_sum,c2_sum,c3_sum,c4_sum
);

    wire signed[24:0]c1_conv0,c1_conv1,c1_conv2,c1_conv3,c1_conv4,c1_conv5,c1_conv6,c1_conv7,c1_conv8;
    wire signed[24:0]c2_conv0,c2_conv1,c2_conv2,c2_conv3,c2_conv4,c2_conv5,c2_conv6,c2_conv7,c2_conv8;
    wire signed[24:0]c3_conv0,c3_conv1,c3_conv2,c3_conv3,c3_conv4,c3_conv5,c3_conv6,c3_conv7,c3_conv8;
    wire signed[24:0]c4_conv0,c4_conv1,c4_conv2,c4_conv3,c4_conv4,c4_conv5,c4_conv6,c4_conv7,c4_conv8;
    // .clk(clk),.reset(reset),

    PE C1(.data0(c1_data0),.data1(c1_data1),.data2(c1_data2),.data3(c1_data3),.data4(c1_data4),.data5(c1_data5),.data6(c1_data6),.data7(c1_data7),.data8(c1_data8),
            .kernel00(c1_kernel0),.kernel01(c1_kernel1),.kernel02(c1_kernel2),.kernel03(c1_kernel3),.kernel04(c1_kernel4),.kernel05(c1_kernel5),.kernel06(c1_kernel6),.kernel07(c1_kernel7),.kernel08(c1_kernel8),
            .conv00(c1_conv0),.conv01(c1_conv1),.conv02(c1_conv2),.conv03(c1_conv3),.conv04(c1_conv4),.conv05(c1_conv5),.conv06(c1_conv6),.conv07(c1_conv7),.conv08(c1_conv8));
    
    PE C2(.data0(c2_data0),.data1(c2_data1),.data2(c2_data2),.data3(c2_data3),.data4(c2_data4),.data5(c2_data5),.data6(c2_data6),.data7(c2_data7),.data8(c2_data8),
            .kernel00(c2_kernel0),.kernel01(c2_kernel1),.kernel02(c2_kernel2),.kernel03(c2_kernel3),.kernel04(c2_kernel4),.kernel05(c2_kernel5),.kernel06(c2_kernel6),.kernel07(c2_kernel7),.kernel08(c2_kernel8),
            .conv00(c2_conv0),.conv01(c2_conv1),.conv02(c2_conv2),.conv03(c2_conv3),.conv04(c2_conv4),.conv05(c2_conv5),.conv06(c2_conv6),.conv07(c2_conv7),.conv08(c2_conv8));
    
    PE C3(.data0(c3_data0),.data1(c3_data1),.data2(c3_data2),.data3(c3_data3),.data4(c3_data4),.data5(c3_data5),.data6(c3_data6),.data7(c3_data7),.data8(c3_data8),
            .kernel00(c3_kernel0),.kernel01(c3_kernel1),.kernel02(c3_kernel2),.kernel03(c3_kernel3),.kernel04(c3_kernel4),.kernel05(c3_kernel5),.kernel06(c3_kernel6),.kernel07(c3_kernel7),.kernel08(c3_kernel8),
            .conv00(c3_conv0),.conv01(c3_conv1),.conv02(c3_conv2),.conv03(c3_conv3),.conv04(c3_conv4),.conv05(c3_conv5),.conv06(c3_conv6),.conv07(c3_conv7),.conv08(c3_conv8));
    
    PE C4(.data0(c4_data0),.data1(c4_data1),.data2(c4_data2),.data3(c4_data3),.data4(c4_data4),.data5(c4_data5),.data6(c4_data6),.data7(c4_data7),.data8(c4_data8),
            .kernel00(c4_kernel0),.kernel01(c4_kernel1),.kernel02(c4_kernel2),.kernel03(c4_kernel3),.kernel04(c4_kernel4),.kernel05(c4_kernel5),.kernel06(c4_kernel6),.kernel07(c4_kernel7),.kernel08(c4_kernel8),
            .conv00(c4_conv0),.conv01(c4_conv1),.conv02(c4_conv2),.conv03(c4_conv3),.conv04(c4_conv4),.conv05(c4_conv5),.conv06(c4_conv6),.conv07(c4_conv7),.conv08(c4_conv8));

    AT ATC1(.pe_out_0(c1_conv0),.pe_out_1(c1_conv1),.pe_out_2(c1_conv2),.pe_out_3(c1_conv3),.pe_out_4(c1_conv4),.pe_out_5(c1_conv5),.pe_out_6(c1_conv6),.pe_out_7(c1_conv7),.pe_out_8(c1_conv8),.sum(c1_sum));
    AT ATC2(.pe_out_0(c2_conv0),.pe_out_1(c2_conv1),.pe_out_2(c2_conv2),.pe_out_3(c2_conv3),.pe_out_4(c2_conv4),.pe_out_5(c2_conv5),.pe_out_6(c2_conv6),.pe_out_7(c2_conv7),.pe_out_8(c2_conv8),.sum(c2_sum));
    AT ATC3(.pe_out_0(c3_conv0),.pe_out_1(c3_conv1),.pe_out_2(c3_conv2),.pe_out_3(c3_conv3),.pe_out_4(c3_conv4),.pe_out_5(c3_conv5),.pe_out_6(c3_conv6),.pe_out_7(c3_conv7),.pe_out_8(c3_conv8),.sum(c3_sum));
    AT ATC4(.pe_out_0(c4_conv0),.pe_out_1(c4_conv1),.pe_out_2(c4_conv2),.pe_out_3(c4_conv3),.pe_out_4(c4_conv4),.pe_out_5(c4_conv5),.pe_out_6(c4_conv6),.pe_out_7(c4_conv7),.pe_out_8(c4_conv8),.sum(c4_sum));

endmodule