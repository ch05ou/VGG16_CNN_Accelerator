`timescale 1ns/1ps
`define period              15
`define max_img_size        224*224*3+54
`define padding_img_size    226*226
`define layer1_num          64

`define img_path            "../00_Source/cat224.bmp"
`define layer1_out_path     "./01_Image/01_Layer1/"
`define layer2_out_path     "./01_Image/02_Layer2/"
`define layer1_kernel_path  "../00_Source/conv1_kernel_hex.txt"
`define layer1_bias_path    "../00_Source/conv1_bias_hex.txt"
`define layer2_kernel_path  "../00_Source/conv2_kernel_hex.txt"
`define layer2_bias_path    "../00_Source/conv2_bias_hex.txt"

module hw5_tb_post;
    reg clk,reset;
    reg [7:0]img_data [0:`max_img_size-1];
    //reg [7:0]padding_img[0:`padding_img_size][2:0];
    reg [7:0]padding_img[0:`padding_img_size][2:0];

    //reg [7:0]layer1_img[0:223][0:223][63:0];
    //reg [7:0]layer1_padding_img[0:225][0:225][63:0];

    reg [7:0]layer1_img[0:224*224-1][63:0];
    reg [7:0]layer1_padding_img[0:`padding_img_size][63:0];

    integer layer1_img_handle[63:0],layer2_img_handle[63:0];
    reg [255:0]file_name1,file_name2;
    reg [7:0] digit1, digit2;

    reg [7:0] C1,C2,C3;
    reg [8:0] Y1,Y2,Y3,Y4;
    wire [3:0]cal_en;

    integer i,j,idx,idx_i;
    integer img_in,none;
    integer out_img;
    integer offset;
    integer img_h,h;
    integer img_w,w;
    integer header;

    reg signed [15:0]kernel1[1727:0];
    reg signed [15:0]kernel2[36863:0];
    reg signed [15:0]bias1[63:0];
    reg signed [15:0]bias2[63:0];

    reg signed[15:0]g1c1_kernel0,g1c1_kernel1,g1c1_kernel2,g1c1_kernel3,g1c1_kernel4,g1c1_kernel5,g1c1_kernel6,g1c1_kernel7,g1c1_kernel8;
    reg signed[15:0]g1c2_kernel0,g1c2_kernel1,g1c2_kernel2,g1c2_kernel3,g1c2_kernel4,g1c2_kernel5,g1c2_kernel6,g1c2_kernel7,g1c2_kernel8;
    reg signed[15:0]g1c3_kernel0,g1c3_kernel1,g1c3_kernel2,g1c3_kernel3,g1c3_kernel4,g1c3_kernel5,g1c3_kernel6,g1c3_kernel7,g1c3_kernel8;
    reg signed[15:0]g1c4_kernel0,g1c4_kernel1,g1c4_kernel2,g1c4_kernel3,g1c4_kernel4,g1c4_kernel5,g1c4_kernel6,g1c4_kernel7,g1c4_kernel8;

    reg signed[15:0]g2c1_kernel0,g2c1_kernel1,g2c1_kernel2,g2c1_kernel3,g2c1_kernel4,g2c1_kernel5,g2c1_kernel6,g2c1_kernel7,g2c1_kernel8;
    reg signed[15:0]g2c2_kernel0,g2c2_kernel1,g2c2_kernel2,g2c2_kernel3,g2c2_kernel4,g2c2_kernel5,g2c2_kernel6,g2c2_kernel7,g2c2_kernel8;
    reg signed[15:0]g2c3_kernel0,g2c3_kernel1,g2c3_kernel2,g2c3_kernel3,g2c3_kernel4,g2c3_kernel5,g2c3_kernel6,g2c3_kernel7,g2c3_kernel8;
    reg signed[15:0]g2c4_kernel0,g2c4_kernel1,g2c4_kernel2,g2c4_kernel3,g2c4_kernel4,g2c4_kernel5,g2c4_kernel6,g2c4_kernel7,g2c4_kernel8;

    reg signed[15:0]g3c1_kernel0,g3c1_kernel1,g3c1_kernel2,g3c1_kernel3,g3c1_kernel4,g3c1_kernel5,g3c1_kernel6,g3c1_kernel7,g3c1_kernel8;
    reg signed[15:0]g3c2_kernel0,g3c2_kernel1,g3c2_kernel2,g3c2_kernel3,g3c2_kernel4,g3c2_kernel5,g3c2_kernel6,g3c2_kernel7,g3c2_kernel8;
    reg signed[15:0]g3c3_kernel0,g3c3_kernel1,g3c3_kernel2,g3c3_kernel3,g3c3_kernel4,g3c3_kernel5,g3c3_kernel6,g3c3_kernel7,g3c3_kernel8;
    reg signed[15:0]g3c4_kernel0,g3c4_kernel1,g3c4_kernel2,g3c4_kernel3,g3c4_kernel4,g3c4_kernel5,g3c4_kernel6,g3c4_kernel7,g3c4_kernel8;

    reg signed[15:0]g4c1_kernel0,g4c1_kernel1,g4c1_kernel2,g4c1_kernel3,g4c1_kernel4,g4c1_kernel5,g4c1_kernel6,g4c1_kernel7,g4c1_kernel8;
    reg signed[15:0]g4c2_kernel0,g4c2_kernel1,g4c2_kernel2,g4c2_kernel3,g4c2_kernel4,g4c2_kernel5,g4c2_kernel6,g4c2_kernel7,g4c2_kernel8;
    reg signed[15:0]g4c3_kernel0,g4c3_kernel1,g4c3_kernel2,g4c3_kernel3,g4c3_kernel4,g4c3_kernel5,g4c3_kernel6,g4c3_kernel7,g4c3_kernel8;
    reg signed[15:0]g4c4_kernel0,g4c4_kernel1,g4c4_kernel2,g4c4_kernel3,g4c4_kernel4,g4c4_kernel5,g4c4_kernel6,g4c4_kernel7,g4c4_kernel8;

    wire signed[35:0]g1_sum,g2_sum,g3_sum,g4_sum;
    reg signed[15:0]bias_g1,bias_g2,bias_g3,bias_g4;

    reg signed[35:0]g1_partial_sum[15:0];
    reg signed[35:0]g2_partial_sum[15:0];
    reg signed[35:0]g3_partial_sum[15:0];
    reg signed[35:0]g4_partial_sum[15:0];

    wire [35:0]img1_res,img2_res,img3_res,img4_res;

    integer layer1_round,kernel_floor,ps_rst,res_loop;
    integer layer2_round,layer2_counter;

    TOP  top (.clk(clk),.reset(reset),
            .pix_ch1(Y1),.pix_ch2(Y2),.pix_ch3(Y3),.pix_ch4(Y4),
            .lb_en1(cal_en[0]),.lb_en2(cal_en[1]),.lb_en3(cal_en[2]),.lb_en4(cal_en[3]),
            .g1c1_kernel0(g1c1_kernel0),.g1c1_kernel1( g1c1_kernel1),.g1c1_kernel2( g1c1_kernel2),
            .g1c1_kernel3( g1c1_kernel3),.g1c1_kernel4( g1c1_kernel4),.g1c1_kernel5( g1c1_kernel5),
            .g1c1_kernel6( g1c1_kernel6),.g1c1_kernel7( g1c1_kernel7),.g1c1_kernel8( g1c1_kernel8),
            
            .g1c2_kernel0 (g1c2_kernel0),.g1c2_kernel1( g1c2_kernel1),.g1c2_kernel2( g1c2_kernel2),
            .g1c2_kernel3( g1c2_kernel3),.g1c2_kernel4( g1c2_kernel4),.g1c2_kernel5( g1c2_kernel5),
            .g1c2_kernel6( g1c2_kernel6),.g1c2_kernel7( g1c2_kernel7),.g1c2_kernel8( g1c2_kernel8),
            
            .g1c3_kernel0( g1c3_kernel0),.g1c3_kernel1( g1c3_kernel1),.g1c3_kernel2( g1c3_kernel2),
            .g1c3_kernel3( g1c3_kernel3),.g1c3_kernel4( g1c3_kernel4),.g1c3_kernel5( g1c3_kernel5),
            .g1c3_kernel6( g1c3_kernel6),.g1c3_kernel7( g1c3_kernel7),.g1c3_kernel8( g1c3_kernel8),
            
            .g1c4_kernel0( g1c4_kernel0),.g1c4_kernel1( g1c4_kernel1),.g1c4_kernel2( g1c4_kernel2),
            .g1c4_kernel3( g1c4_kernel3),.g1c4_kernel4( g1c4_kernel4),.g1c4_kernel5( g1c4_kernel5),
            .g1c4_kernel6( g1c4_kernel6),.g1c4_kernel7( g1c4_kernel7),.g1c4_kernel8( g1c4_kernel8),
            
            .g2c1_kernel0( g2c1_kernel0),.g2c1_kernel1( g2c1_kernel1),.g2c1_kernel2( g2c1_kernel2),
            .g2c1_kernel3( g2c1_kernel3),.g2c1_kernel4( g2c1_kernel4),.g2c1_kernel5( g2c1_kernel5),
            .g2c1_kernel6( g2c1_kernel6),.g2c1_kernel7( g2c1_kernel7),.g2c1_kernel8( g2c1_kernel8),
            
            .g2c2_kernel0( g2c2_kernel0),.g2c2_kernel1( g2c2_kernel1),.g2c2_kernel2( g2c2_kernel2),
            .g2c2_kernel3( g2c2_kernel3),.g2c2_kernel4( g2c2_kernel4),.g2c2_kernel5( g2c2_kernel5),
            .g2c2_kernel6( g2c2_kernel6),.g2c2_kernel7( g2c2_kernel7),.g2c2_kernel8( g2c2_kernel8),
            
            .g2c3_kernel0( g2c3_kernel0),.g2c3_kernel1( g2c3_kernel1),.g2c3_kernel2( g2c3_kernel2),
            .g2c3_kernel3( g2c3_kernel3),.g2c3_kernel4( g2c3_kernel4),.g2c3_kernel5( g2c3_kernel5),
            .g2c3_kernel6( g2c3_kernel6),.g2c3_kernel7( g2c3_kernel7),.g2c3_kernel8( g2c3_kernel8),
            
            .g2c4_kernel0( g2c4_kernel0),.g2c4_kernel1( g2c4_kernel1),.g2c4_kernel2( g2c4_kernel2),
            .g2c4_kernel3( g2c4_kernel3),.g2c4_kernel4( g2c4_kernel4),.g2c4_kernel5( g2c4_kernel5),
            .g2c4_kernel6( g2c4_kernel6),.g2c4_kernel7( g2c4_kernel7),.g2c4_kernel8( g2c4_kernel8),
            
            .g3c1_kernel0( g3c1_kernel0),.g3c1_kernel1( g3c1_kernel1),.g3c1_kernel2( g3c1_kernel2),
            .g3c1_kernel3( g3c1_kernel3),.g3c1_kernel4( g3c1_kernel4),.g3c1_kernel5( g3c1_kernel5),
            .g3c1_kernel6( g3c1_kernel6),.g3c1_kernel7( g3c1_kernel7),.g3c1_kernel8( g3c1_kernel8),
            
            .g3c2_kernel0( g3c2_kernel0),.g3c2_kernel1( g3c2_kernel1),.g3c2_kernel2( g3c2_kernel2),
            .g3c2_kernel3( g3c2_kernel3),.g3c2_kernel4( g3c2_kernel4),.g3c2_kernel5( g3c2_kernel5),
            .g3c2_kernel6( g3c2_kernel6),.g3c2_kernel7( g3c2_kernel7),.g3c2_kernel8( g3c2_kernel8),
            
            .g3c3_kernel0( g3c3_kernel0),.g3c3_kernel1( g3c3_kernel1),.g3c3_kernel2( g3c3_kernel2),
            .g3c3_kernel3( g3c3_kernel3),.g3c3_kernel4( g3c3_kernel4),.g3c3_kernel5( g3c3_kernel5),
            .g3c3_kernel6( g3c3_kernel6),.g3c3_kernel7( g3c3_kernel7),.g3c3_kernel8( g3c3_kernel8),
            
            .g3c4_kernel0( g3c4_kernel0),.g3c4_kernel1( g3c4_kernel1),.g3c4_kernel2( g3c4_kernel2),
            .g3c4_kernel3( g3c4_kernel3),.g3c4_kernel4( g3c4_kernel4),.g3c4_kernel5( g3c4_kernel5),
            .g3c4_kernel6( g3c4_kernel6),.g3c4_kernel7( g3c4_kernel7),.g3c4_kernel8( g3c4_kernel8),
            
            .g4c1_kernel0( g4c1_kernel0),.g4c1_kernel1( g4c1_kernel1),.g4c1_kernel2( g4c1_kernel2),
            .g4c1_kernel3( g4c1_kernel3),.g4c1_kernel4( g4c1_kernel4),.g4c1_kernel5( g4c1_kernel5),
            .g4c1_kernel6( g4c1_kernel6),.g4c1_kernel7( g4c1_kernel7),.g4c1_kernel8( g4c1_kernel8),
            
            .g4c2_kernel0( g4c2_kernel0),.g4c2_kernel1( g4c2_kernel1),.g4c2_kernel2( g4c2_kernel2),
            .g4c2_kernel3( g4c2_kernel3),.g4c2_kernel4( g4c2_kernel4),.g4c2_kernel5( g4c2_kernel5),
            .g4c2_kernel6( g4c2_kernel6),.g4c2_kernel7( g4c2_kernel7),.g4c2_kernel8( g4c2_kernel8),
            
            .g4c3_kernel0( g4c3_kernel0),.g4c3_kernel1( g4c3_kernel1),.g4c3_kernel2( g4c3_kernel2),
            .g4c3_kernel3( g4c3_kernel3),.g4c3_kernel4( g4c3_kernel4),.g4c3_kernel5( g4c3_kernel5),
            .g4c3_kernel6( g4c3_kernel6),.g4c3_kernel7( g4c3_kernel7),.g4c3_kernel8( g4c3_kernel8),
            
            .g4c4_kernel0( g4c4_kernel0),.g4c4_kernel1( g4c4_kernel1),.g4c4_kernel2( g4c4_kernel2),
            .g4c4_kernel3( g4c4_kernel3),.g4c4_kernel4( g4c4_kernel4),.g4c4_kernel5( g4c4_kernel5),
            .g4c4_kernel6( g4c4_kernel6),.g4c4_kernel7( g4c4_kernel7),.g4c4_kernel8( g4c4_kernel8),

            .g1_sum(g1_sum),.g2_sum(g2_sum),.g3_sum(g3_sum),.g4_sum(g4_sum),

            .g1_ps_data1(g1_partial_sum[0]),.g1_ps_data2(g1_partial_sum[1]),.g1_ps_data3(g1_partial_sum[2]),.g1_ps_data4(g1_partial_sum[3]),
            .g1_ps_data5(g1_partial_sum[4]),.g1_ps_data6(g1_partial_sum[5]),.g1_ps_data7(g1_partial_sum[6]),.g1_ps_data8(g1_partial_sum[7]),
            .g1_ps_data9(g1_partial_sum[8]),.g1_ps_data10(g1_partial_sum[9]),.g1_ps_data11(g1_partial_sum[10]),.g1_ps_data12(g1_partial_sum[11]),
            .g1_ps_data13(g1_partial_sum[12]),.g1_ps_data14(g1_partial_sum[13]),.g1_ps_data15(g1_partial_sum[14]),.g1_ps_data16(g1_partial_sum[15]),
            .g1_bias(bias_g1),
            
            .g2_ps_data1(g2_partial_sum[0]),.g2_ps_data2(g2_partial_sum[1]),.g2_ps_data3(g2_partial_sum[2]),.g2_ps_data4(g2_partial_sum[3]),
            .g2_ps_data5(g2_partial_sum[4]),.g2_ps_data6(g2_partial_sum[5]),.g2_ps_data7(g2_partial_sum[6]),.g2_ps_data8(g2_partial_sum[7]),
            .g2_ps_data9(g2_partial_sum[8]),.g2_ps_data10(g2_partial_sum[9]),.g2_ps_data11(g2_partial_sum[10]),.g2_ps_data12(g2_partial_sum[11]),
            .g2_ps_data13(g2_partial_sum[12]),.g2_ps_data14(g2_partial_sum[13]),.g2_ps_data15(g2_partial_sum[14]),.g2_ps_data16(g2_partial_sum[15]),
            .g2_bias(bias_g2),

            .g3_ps_data1(g3_partial_sum[0]),.g3_ps_data2(g3_partial_sum[1]),.g3_ps_data3(g3_partial_sum[2]),.g3_ps_data4(g3_partial_sum[3]),
            .g3_ps_data5(g3_partial_sum[4]),.g3_ps_data6(g3_partial_sum[5]),.g3_ps_data7(g3_partial_sum[6]),.g3_ps_data8(g3_partial_sum[7]),
            .g3_ps_data9(g3_partial_sum[8]),.g3_ps_data10(g3_partial_sum[9]),.g3_ps_data11(g3_partial_sum[10]),.g3_ps_data12(g3_partial_sum[11]),
            .g3_ps_data13(g3_partial_sum[12]),.g3_ps_data14(g3_partial_sum[13]),.g3_ps_data15(g3_partial_sum[14]),.g3_ps_data16(g3_partial_sum[15]),
            .g3_bias(bias_g3),

            .g4_ps_data1(g4_partial_sum[0]),.g4_ps_data2(g4_partial_sum[1]),.g4_ps_data3(g4_partial_sum[2]),.g4_ps_data4(g4_partial_sum[3]),
            .g4_ps_data5(g4_partial_sum[4]),.g4_ps_data6(g4_partial_sum[5]),.g4_ps_data7(g4_partial_sum[6]),.g4_ps_data8(g4_partial_sum[7]),
            .g4_ps_data9(g4_partial_sum[8]),.g4_ps_data10(g4_partial_sum[9]),.g4_ps_data11(g4_partial_sum[10]),.g4_ps_data12(g4_partial_sum[11]),
            .g4_ps_data13(g4_partial_sum[12]),.g4_ps_data14(g4_partial_sum[13]),.g4_ps_data15(g4_partial_sum[14]),.g4_ps_data16(g4_partial_sum[15]),
            .g4_bias(bias_g4),

            .img1_res(img1_res),.img2_res(img2_res),.img3_res(img3_res),.img4_res(img4_res)
    );

    initial begin
        $dumpvars();
        $dumpfile("hw5_VGG_post.vcd");
        $sdf_annotate("/home/H125720823_HDL/Homework5/02_Synthesis/dc_out_file/HW5_VGG16.sdf",top);
    end

// Generate CLK
    always begin
		#(`period/2.0) clk <= ~clk;
	end
// Read File
    initial begin
        $readmemh(`layer1_kernel_path,kernel1);
        $readmemh(`layer2_kernel_path,kernel2);
        $readmemh(`layer1_bias_path,bias1);
        $readmemh(`layer2_bias_path,bias2);
        //$finish;
    end
// Layer 1 read image、padding image and Creat Output Image 
    initial begin
        img_in = $fopen(`img_path,"rb");
        none = $fread(img_data,img_in);

        for(i=0;i<64;i=i+1)begin
            if (i < 10) begin
                digit1 = i + "0";
                file_name1 = {`layer1_out_path, "0", digit1, ".bmp"};
                file_name2 = {`layer2_out_path, "0", digit1, ".bmp"};
            end else begin
                digit1 = (i / 10) + "0";
                digit2 = (i % 10) + "0";
                file_name1 = {`layer1_out_path, digit1, digit2, ".bmp"};
                file_name2 = {`layer2_out_path, digit1, digit2, ".bmp"};
            end
            layer1_img_handle[i] = $fopen(file_name1, "wb"); // 以二進制模式打開
            layer2_img_handle[i] = $fopen(file_name2, "wb"); // 以二進制模式打開
        end

        //Read header information of input file
        img_w   = {img_data[21],img_data[20],img_data[19],img_data[18]};
        img_h   = {img_data[25],img_data[24],img_data[23],img_data[22]};
        offset  = {img_data[13],img_data[12],img_data[11],img_data[10]};

        for(j=0;j<64;j=j+1)begin
            for(header=0;header<54;header=header+1)begin
                $fwrite(layer1_img_handle[j],"%c",img_data[header]);
                $fwrite(layer2_img_handle[j],"%c",img_data[header]);
            end
        end

        for(idx=0;idx<3;idx=idx+1)begin
            for(i=0;i<`padding_img_size;i=i+1)begin
                padding_img[i][idx]=0;
            end
        end

        for(h = 0; h < img_h; h = h+1) begin
            for(w = 0; w < img_w; w = w+1) begin
                padding_img[h*226+w+227][2] = img_data[(h*224+w)*3 + offset + 2];
                padding_img[h*226+w+227][1] = img_data[(h*224+w)*3 + offset + 1];
                padding_img[h*226+w+227][0] = img_data[(h*224+w)*3 + offset + 0];
            end
        end

        $fclose(img_in);
        //$finish;
    //end
    
// Layer 1
    //initial begin
        for(ps_rst=0;ps_rst<16;ps_rst=ps_rst+1)begin
            g1_partial_sum[ps_rst] <= 0;
            g2_partial_sum[ps_rst] <= 0;
            g3_partial_sum[ps_rst] <= 0;
            g4_partial_sum[ps_rst] <= 0;
        end

        $display("---------- Start Layer 1 ----------");
        clk = 1'b1;
        for(layer1_round=0;layer1_round<16;layer1_round = layer1_round+1)begin
            reset = 1'b1;
            #(`period);
            reset = 1'b0;
            //--------------------------------------------------
            for(i=0;i<16;i=i+1)begin
                g1_partial_sum[i] = 0;
                g2_partial_sum[i] = 0;
                g3_partial_sum[i] = 0;
                g4_partial_sum[i] = 0;
            end
            //--------------------------------------------------
            $display("Now is Round %d",layer1_round);
            $display("Bias :%d, %d,%d,%d",bias1[4*layer1_round+0],bias1[4*layer1_round+1],bias1[4*layer1_round+2],bias1[4*layer1_round+3]);
            bias_g1 = bias1[4*layer1_round+0];
            bias_g2 = bias1[4*layer1_round+1];
            bias_g3 = bias1[4*layer1_round+2];
            bias_g4 = bias1[4*layer1_round+3];
        //-------------------------------------------------------------------------------------------------------//
            g1c1_kernel0 = kernel1[108*layer1_round];
            g1c1_kernel1 = kernel1[108*layer1_round+1];
            g1c1_kernel2 = kernel1[108*layer1_round+2];
            g1c1_kernel3 = kernel1[108*layer1_round+3];
            g1c1_kernel4 = kernel1[108*layer1_round+4];
            g1c1_kernel5 = kernel1[108*layer1_round+5];
            g1c1_kernel6 = kernel1[108*layer1_round+6];
            g1c1_kernel7 = kernel1[108*layer1_round+7];
            g1c1_kernel8 = kernel1[108*layer1_round+8];

            g1c2_kernel0 = kernel1[108*layer1_round+9];
            g1c2_kernel1 = kernel1[108*layer1_round+10];
            g1c2_kernel2 = kernel1[108*layer1_round+11];
            g1c2_kernel3 = kernel1[108*layer1_round+12];
            g1c2_kernel4 = kernel1[108*layer1_round+13];
            g1c2_kernel5 = kernel1[108*layer1_round+14];
            g1c2_kernel6 = kernel1[108*layer1_round+15];
            g1c2_kernel7 = kernel1[108*layer1_round+16];
            g1c2_kernel8 = kernel1[108*layer1_round+17];

            g1c3_kernel0 = kernel1[108*layer1_round+18];
            g1c3_kernel1 = kernel1[108*layer1_round+19];
            g1c3_kernel2 = kernel1[108*layer1_round+20];
            g1c3_kernel3 = kernel1[108*layer1_round+21];
            g1c3_kernel4 = kernel1[108*layer1_round+22];
            g1c3_kernel5 = kernel1[108*layer1_round+23];
            g1c3_kernel6 = kernel1[108*layer1_round+24];
            g1c3_kernel7 = kernel1[108*layer1_round+25];
            g1c3_kernel8 = kernel1[108*layer1_round+26];
            
            g1c4_kernel0 = 0;
            g1c4_kernel1 = 0;
            g1c4_kernel2 = 0;
            g1c4_kernel3 = 0;
            g1c4_kernel4 = 0;
            g1c4_kernel5 = 0;
            g1c4_kernel6 = 0;
            g1c4_kernel7 = 0;
            g1c4_kernel8 = 0;
        //-------------------------------------------------------------------------------------------------------//
            g2c1_kernel0 = kernel1[108*layer1_round+27];
            g2c1_kernel1 = kernel1[108*layer1_round+28];
            g2c1_kernel2 = kernel1[108*layer1_round+29];
            g2c1_kernel3 = kernel1[108*layer1_round+30];
            g2c1_kernel4 = kernel1[108*layer1_round+31];
            g2c1_kernel5 = kernel1[108*layer1_round+32];
            g2c1_kernel6 = kernel1[108*layer1_round+33];
            g2c1_kernel7 = kernel1[108*layer1_round+34];
            g2c1_kernel8 = kernel1[108*layer1_round+35];

            g2c2_kernel0 = kernel1[108*layer1_round+36];
            g2c2_kernel1 = kernel1[108*layer1_round+37];
            g2c2_kernel2 = kernel1[108*layer1_round+38];
            g2c2_kernel3 = kernel1[108*layer1_round+39];
            g2c2_kernel4 = kernel1[108*layer1_round+40];
            g2c2_kernel5 = kernel1[108*layer1_round+41];
            g2c2_kernel6 = kernel1[108*layer1_round+42];
            g2c2_kernel7 = kernel1[108*layer1_round+43];
            g2c2_kernel8 = kernel1[108*layer1_round+44];

            g2c3_kernel0 = kernel1[108*layer1_round+45];
            g2c3_kernel1 = kernel1[108*layer1_round+46];
            g2c3_kernel2 = kernel1[108*layer1_round+47];
            g2c3_kernel3 = kernel1[108*layer1_round+48];
            g2c3_kernel4 = kernel1[108*layer1_round+49];
            g2c3_kernel5 = kernel1[108*layer1_round+50];
            g2c3_kernel6 = kernel1[108*layer1_round+51];
            g2c3_kernel7 = kernel1[108*layer1_round+52];
            g2c3_kernel8 = kernel1[108*layer1_round+53];
            //$display("%d",108*layer1_round+53);
            
            g2c4_kernel0 = 0;
            g2c4_kernel1 = 0;
            g2c4_kernel2 = 0;
            g2c4_kernel3 = 0;
            g2c4_kernel4 = 0;
            g2c4_kernel5 = 0;
            g2c4_kernel6 = 0;
            g2c4_kernel7 = 0;
            g2c4_kernel8 = 0;
        //-------------------------------------------------------------------------------------------------------//
            g3c1_kernel0 = kernel1[108*layer1_round+54];
            g3c1_kernel1 = kernel1[108*layer1_round+55];
            g3c1_kernel2 = kernel1[108*layer1_round+56];
            g3c1_kernel3 = kernel1[108*layer1_round+57];
            g3c1_kernel4 = kernel1[108*layer1_round+58];
            g3c1_kernel5 = kernel1[108*layer1_round+59];
            g3c1_kernel6 = kernel1[108*layer1_round+60];
            g3c1_kernel7 = kernel1[108*layer1_round+61];
            g3c1_kernel8 = kernel1[108*layer1_round+62];

            g3c2_kernel0 = kernel1[108*layer1_round+63];
            g3c2_kernel1 = kernel1[108*layer1_round+64];
            g3c2_kernel2 = kernel1[108*layer1_round+65];
            g3c2_kernel3 = kernel1[108*layer1_round+66];
            g3c2_kernel4 = kernel1[108*layer1_round+67];
            g3c2_kernel5 = kernel1[108*layer1_round+68];
            g3c2_kernel6 = kernel1[108*layer1_round+69];
            g3c2_kernel7 = kernel1[108*layer1_round+70];
            g3c2_kernel8 = kernel1[108*layer1_round+71];

            g3c3_kernel0 = kernel1[108*layer1_round+72];
            g3c3_kernel1 = kernel1[108*layer1_round+73];
            g3c3_kernel2 = kernel1[108*layer1_round+74];
            g3c3_kernel3 = kernel1[108*layer1_round+75];
            g3c3_kernel4 = kernel1[108*layer1_round+76];
            g3c3_kernel5 = kernel1[108*layer1_round+77];
            g3c3_kernel6 = kernel1[108*layer1_round+78];
            g3c3_kernel7 = kernel1[108*layer1_round+79];
            g3c3_kernel8 = kernel1[108*layer1_round+80];
            
            g3c4_kernel0 = 0;
            g3c4_kernel1 = 0;
            g3c4_kernel2 = 0;
            g3c4_kernel3 = 0;
            g3c4_kernel4 = 0;
            g3c4_kernel5 = 0;
            g3c4_kernel6 = 0;
            g3c4_kernel7 = 0;
            g3c4_kernel8 = 0;
        //-------------------------------------------------------------------------------------------------------//        
            g4c1_kernel0 = kernel1[108*layer1_round+81];
            g4c1_kernel1 = kernel1[108*layer1_round+82];
            g4c1_kernel2 = kernel1[108*layer1_round+83];
            g4c1_kernel3 = kernel1[108*layer1_round+84];
            g4c1_kernel4 = kernel1[108*layer1_round+85];
            g4c1_kernel5 = kernel1[108*layer1_round+86];
            g4c1_kernel6 = kernel1[108*layer1_round+87];
            g4c1_kernel7 = kernel1[108*layer1_round+88];
            g4c1_kernel8 = kernel1[108*layer1_round+89];

            g4c2_kernel0 = kernel1[108*layer1_round+90];
            g4c2_kernel1 = kernel1[108*layer1_round+91];
            g4c2_kernel2 = kernel1[108*layer1_round+92];
            g4c2_kernel3 = kernel1[108*layer1_round+93];
            g4c2_kernel4 = kernel1[108*layer1_round+94];
            g4c2_kernel5 = kernel1[108*layer1_round+95];
            g4c2_kernel6 = kernel1[108*layer1_round+96];
            g4c2_kernel7 = kernel1[108*layer1_round+97];
            g4c2_kernel8 = kernel1[108*layer1_round+98];
            
            g4c3_kernel0 = kernel1[108*layer1_round+99];
            g4c3_kernel1 = kernel1[108*layer1_round+100];
            g4c3_kernel2 = kernel1[108*layer1_round+101];
            g4c3_kernel3 = kernel1[108*layer1_round+102];
            g4c3_kernel4 = kernel1[108*layer1_round+103];
            g4c3_kernel5 = kernel1[108*layer1_round+104];
            g4c3_kernel6 = kernel1[108*layer1_round+105];
            g4c3_kernel7 = kernel1[108*layer1_round+106];
            g4c3_kernel8 = kernel1[108*layer1_round+107];
            
            g4c4_kernel0 = 0;
            g4c4_kernel1 = 0;
            g4c4_kernel2 = 0;
            g4c4_kernel3 = 0;
            g4c4_kernel4 = 0;
            g4c4_kernel5 = 0;
            g4c4_kernel6 = 0;
            g4c4_kernel7 = 0;
            g4c4_kernel8 = 0;
        //-------------------------------------------------------------------------------------------------------//
            for(i=0;i<`padding_img_size;i=i+1)begin
                Y1 = {1'b0,padding_img[i][2]};
                Y2 = {1'b0,padding_img[i][1]};
                Y3 = {1'b0,padding_img[i][0]};
                Y4 = 0;
                g1_partial_sum[0] = g1_sum;
                g2_partial_sum[0] = g2_sum;
                g3_partial_sum[0] = g3_sum;
                g4_partial_sum[0] = g4_sum;
                #(`period);
                if(cal_en == 4'b1111)begin
                    for(res_loop=0;res_loop<3;res_loop=res_loop+1)begin
                        $fwrite(layer1_img_handle[4*layer1_round],"%c",img1_res[11:3]);
                        $fwrite(layer1_img_handle[4*layer1_round+1],"%c",img2_res[13:6]);
                        $fwrite(layer1_img_handle[4*layer1_round+2],"%c",img3_res[13:6]);
                        $fwrite(layer1_img_handle[4*layer1_round+3],"%c",img4_res[11:4]);
                    end
                    layer1_padding_img[i][4*layer1_round+0] = img1_res[11:3];
                    layer1_padding_img[i][4*layer1_round+1] = img2_res[13:6];
                    layer1_padding_img[i][4*layer1_round+2] = img3_res[13:6];
                    layer1_padding_img[i][4*layer1_round+3] = img4_res[11:4];
                end
                else begin
                    layer1_padding_img[i][4*layer1_round+0] = 0;
                    layer1_padding_img[i][4*layer1_round+1] = 0;
                    layer1_padding_img[i][4*layer1_round+2] = 0;
                    layer1_padding_img[i][4*layer1_round+3] = 0;
                end
            end
        end 
// Layer 2
        $display("---------- Start Layer 2 ----------");
        //test = 0;
        for(ps_rst=0;ps_rst<16;ps_rst=ps_rst+1)begin
            g1_partial_sum[ps_rst] = 0;
            g2_partial_sum[ps_rst] = 0;
            g3_partial_sum[ps_rst] = 0;
            g4_partial_sum[ps_rst] = 0;
        end

        for(layer2_round=0;layer2_round<64;layer2_round=layer2_round+4)begin
            reset = 1'b1;
            #(`period);
            reset = 1'b0;
            //--------------------------------------------------
            for(i=0;i<16;i=i+1)begin
                g1_partial_sum[i] = 0;
                g2_partial_sum[i] = 0;
                g3_partial_sum[i] = 0;
                g4_partial_sum[i] = 0;
            end
            //--------------------------------------------------
            $display("Now is Round %d",layer2_round/4);
            $display("Bias :%d, %d,%d,%d",bias2[layer2_round+0],bias2[layer2_round+1],bias2[layer2_round+2],bias2[layer2_round+3]);
            bias_g1 = bias2[layer2_round+0];
            bias_g2 = bias2[layer2_round+1];
            bias_g3 = bias2[layer2_round+2];
            bias_g4 = bias2[layer2_round+3];
            for(i=0;i<`padding_img_size;i=i+1)begin
                Y1 = {1'b0,layer1_padding_img[i][layer2_round+0]};
                Y2 = {1'b0,layer1_padding_img[i][layer2_round+1]};
                Y3 = {1'b0,layer1_padding_img[i][layer2_round+2]};
                Y4 = {1'b0,layer1_padding_img[i][layer2_round+3]};
                for(layer2_counter=0;layer2_counter<16;layer2_counter=layer2_counter+1)begin
            //-------------------------------------------------------------------------------------------------------//
                    g1c1_kernel0 = kernel2[576*layer2_round+layer2_counter*36+0];
                    g1c1_kernel1 = kernel2[576*layer2_round+layer2_counter*36+1];
                    g1c1_kernel2 = kernel2[576*layer2_round+layer2_counter*36+2];
                    g1c1_kernel3 = kernel2[576*layer2_round+layer2_counter*36+3];
                    g1c1_kernel4 = kernel2[576*layer2_round+layer2_counter*36+4];
                    g1c1_kernel5 = kernel2[576*layer2_round+layer2_counter*36+5];
                    g1c1_kernel6 = kernel2[576*layer2_round+layer2_counter*36+6];
                    g1c1_kernel7 = kernel2[576*layer2_round+layer2_counter*36+7];
                    g1c1_kernel8 = kernel2[576*layer2_round+layer2_counter*36+8];

                    g1c2_kernel0 = kernel2[576*layer2_round+layer2_counter*36+9];
                    g1c2_kernel1 = kernel2[576*layer2_round+layer2_counter*36+10];
                    g1c2_kernel2 = kernel2[576*layer2_round+layer2_counter*36+11];
                    g1c2_kernel3 = kernel2[576*layer2_round+layer2_counter*36+12];
                    g1c2_kernel4 = kernel2[576*layer2_round+layer2_counter*36+13];
                    g1c2_kernel5 = kernel2[576*layer2_round+layer2_counter*36+14];
                    g1c2_kernel6 = kernel2[576*layer2_round+layer2_counter*36+15];
                    g1c2_kernel7 = kernel2[576*layer2_round+layer2_counter*36+16];
                    g1c2_kernel8 = kernel2[576*layer2_round+layer2_counter*36+17];

                    g1c3_kernel0 = kernel2[576*layer2_round+layer2_counter*36+18];
                    g1c3_kernel1 = kernel2[576*layer2_round+layer2_counter*36+19];
                    g1c3_kernel2 = kernel2[576*layer2_round+layer2_counter*36+20];
                    g1c3_kernel3 = kernel2[576*layer2_round+layer2_counter*36+21];
                    g1c3_kernel4 = kernel2[576*layer2_round+layer2_counter*36+22];
                    g1c3_kernel5 = kernel2[576*layer2_round+layer2_counter*36+23];
                    g1c3_kernel6 = kernel2[576*layer2_round+layer2_counter*36+24];
                    g1c3_kernel7 = kernel2[576*layer2_round+layer2_counter*36+25];
                    g1c3_kernel8 = kernel2[576*layer2_round+layer2_counter*36+26];
                    
                    g1c4_kernel0 = kernel2[576*layer2_round+layer2_counter*36+27];
                    g1c4_kernel1 = kernel2[576*layer2_round+layer2_counter*36+28];
                    g1c4_kernel2 = kernel2[576*layer2_round+layer2_counter*36+29];
                    g1c4_kernel3 = kernel2[576*layer2_round+layer2_counter*36+30];
                    g1c4_kernel4 = kernel2[576*layer2_round+layer2_counter*36+31];
                    g1c4_kernel5 = kernel2[576*layer2_round+layer2_counter*36+32];
                    g1c4_kernel6 = kernel2[576*layer2_round+layer2_counter*36+33];
                    g1c4_kernel7 = kernel2[576*layer2_round+layer2_counter*36+34];
                    g1c4_kernel8 = kernel2[576*layer2_round+layer2_counter*36+35];
            //-------------------------------------------------------------------------------------------------------//
                    g2c1_kernel0 = kernel2[576*(layer2_round+1)+layer2_counter*36+0];
                    g2c1_kernel1 = kernel2[576*(layer2_round+1)+layer2_counter*36+1];
                    g2c1_kernel2 = kernel2[576*(layer2_round+1)+layer2_counter*36+2];
                    g2c1_kernel3 = kernel2[576*(layer2_round+1)+layer2_counter*36+3];
                    g2c1_kernel4 = kernel2[576*(layer2_round+1)+layer2_counter*36+4];
                    g2c1_kernel5 = kernel2[576*(layer2_round+1)+layer2_counter*36+5];
                    g2c1_kernel6 = kernel2[576*(layer2_round+1)+layer2_counter*36+6];
                    g2c1_kernel7 = kernel2[576*(layer2_round+1)+layer2_counter*36+7];
                    g2c1_kernel8 = kernel2[576*(layer2_round+1)+layer2_counter*36+8];

                    g2c2_kernel0 = kernel2[576*(layer2_round+1)+layer2_counter*36+9];
                    g2c2_kernel1 = kernel2[576*(layer2_round+1)+layer2_counter*36+10];
                    g2c2_kernel2 = kernel2[576*(layer2_round+1)+layer2_counter*36+11];
                    g2c2_kernel3 = kernel2[576*(layer2_round+1)+layer2_counter*36+12];
                    g2c2_kernel4 = kernel2[576*(layer2_round+1)+layer2_counter*36+13];
                    g2c2_kernel5 = kernel2[576*(layer2_round+1)+layer2_counter*36+14];
                    g2c2_kernel6 = kernel2[576*(layer2_round+1)+layer2_counter*36+15];
                    g2c2_kernel7 = kernel2[576*(layer2_round+1)+layer2_counter*36+16];
                    g2c2_kernel8 = kernel2[576*(layer2_round+1)+layer2_counter*36+17];

                    g2c3_kernel0 = kernel2[576*(layer2_round+1)+layer2_counter*36+18];
                    g2c3_kernel1 = kernel2[576*(layer2_round+1)+layer2_counter*36+19];
                    g2c3_kernel2 = kernel2[576*(layer2_round+1)+layer2_counter*36+20];
                    g2c3_kernel3 = kernel2[576*(layer2_round+1)+layer2_counter*36+21];
                    g2c3_kernel4 = kernel2[576*(layer2_round+1)+layer2_counter*36+22];
                    g2c3_kernel5 = kernel2[576*(layer2_round+1)+layer2_counter*36+23];
                    g2c3_kernel6 = kernel2[576*(layer2_round+1)+layer2_counter*36+24];
                    g2c3_kernel7 = kernel2[576*(layer2_round+1)+layer2_counter*36+25];
                    g2c3_kernel8 = kernel2[576*(layer2_round+1)+layer2_counter*36+26];
                    
                    g2c4_kernel0 = kernel2[576*(layer2_round+1)+layer2_counter*36+27];
                    g2c4_kernel1 = kernel2[576*(layer2_round+1)+layer2_counter*36+28];
                    g2c4_kernel2 = kernel2[576*(layer2_round+1)+layer2_counter*36+29];
                    g2c4_kernel3 = kernel2[576*(layer2_round+1)+layer2_counter*36+30];
                    g2c4_kernel4 = kernel2[576*(layer2_round+1)+layer2_counter*36+31];
                    g2c4_kernel5 = kernel2[576*(layer2_round+1)+layer2_counter*36+32];
                    g2c4_kernel6 = kernel2[576*(layer2_round+1)+layer2_counter*36+33];
                    g2c4_kernel7 = kernel2[576*(layer2_round+1)+layer2_counter*36+34];
                    g2c4_kernel8 = kernel2[576*(layer2_round+1)+layer2_counter*36+35];
            //-------------------------------------------------------------------------------------------------------//
                    g3c1_kernel0 = kernel2[576*(layer2_round+2)+layer2_counter*36+0];
                    g3c1_kernel1 = kernel2[576*(layer2_round+2)+layer2_counter*36+1];
                    g3c1_kernel2 = kernel2[576*(layer2_round+2)+layer2_counter*36+2];
                    g3c1_kernel3 = kernel2[576*(layer2_round+2)+layer2_counter*36+3];
                    g3c1_kernel4 = kernel2[576*(layer2_round+2)+layer2_counter*36+4];
                    g3c1_kernel5 = kernel2[576*(layer2_round+2)+layer2_counter*36+5];
                    g3c1_kernel6 = kernel2[576*(layer2_round+2)+layer2_counter*36+6];
                    g3c1_kernel7 = kernel2[576*(layer2_round+2)+layer2_counter*36+7];
                    g3c1_kernel8 = kernel2[576*(layer2_round+2)+layer2_counter*36+8];

                    g3c2_kernel0 = kernel2[576*(layer2_round+2)+layer2_counter*36+9];
                    g3c2_kernel1 = kernel2[576*(layer2_round+2)+layer2_counter*36+10];
                    g3c2_kernel2 = kernel2[576*(layer2_round+2)+layer2_counter*36+11];
                    g3c2_kernel3 = kernel2[576*(layer2_round+2)+layer2_counter*36+12];
                    g3c2_kernel4 = kernel2[576*(layer2_round+2)+layer2_counter*36+13];
                    g3c2_kernel5 = kernel2[576*(layer2_round+2)+layer2_counter*36+14];
                    g3c2_kernel6 = kernel2[576*(layer2_round+2)+layer2_counter*36+15];
                    g3c2_kernel7 = kernel2[576*(layer2_round+2)+layer2_counter*36+16];
                    g3c2_kernel8 = kernel2[576*(layer2_round+2)+layer2_counter*36+17];

                    g3c3_kernel0 = kernel2[576*(layer2_round+2)+layer2_counter*36+18];
                    g3c3_kernel1 = kernel2[576*(layer2_round+2)+layer2_counter*36+19];
                    g3c3_kernel2 = kernel2[576*(layer2_round+2)+layer2_counter*36+20];
                    g3c3_kernel3 = kernel2[576*(layer2_round+2)+layer2_counter*36+21];
                    g3c3_kernel4 = kernel2[576*(layer2_round+2)+layer2_counter*36+22];
                    g3c3_kernel5 = kernel2[576*(layer2_round+2)+layer2_counter*36+23];
                    g3c3_kernel6 = kernel2[576*(layer2_round+2)+layer2_counter*36+24];
                    g3c3_kernel7 = kernel2[576*(layer2_round+2)+layer2_counter*36+25];
                    g3c3_kernel8 = kernel2[576*(layer2_round+2)+layer2_counter*36+26];
                    
                    g3c4_kernel0 = kernel2[576*(layer2_round+2)+layer2_counter*36+27];
                    g3c4_kernel1 = kernel2[576*(layer2_round+2)+layer2_counter*36+28];
                    g3c4_kernel2 = kernel2[576*(layer2_round+2)+layer2_counter*36+29];
                    g3c4_kernel3 = kernel2[576*(layer2_round+2)+layer2_counter*36+30];
                    g3c4_kernel4 = kernel2[576*(layer2_round+2)+layer2_counter*36+31];
                    g3c4_kernel5 = kernel2[576*(layer2_round+2)+layer2_counter*36+32];
                    g3c4_kernel6 = kernel2[576*(layer2_round+2)+layer2_counter*36+33];
                    g3c4_kernel7 = kernel2[576*(layer2_round+2)+layer2_counter*36+34];
                    g3c4_kernel8 = kernel2[576*(layer2_round+2)+layer2_counter*36+35];
            //-------------------------------------------------------------------------------------------------------//        
                    g4c1_kernel0 = kernel2[576*(layer2_round+3)+layer2_counter*36+0];
                    g4c1_kernel1 = kernel2[576*(layer2_round+3)+layer2_counter*36+1];
                    g4c1_kernel2 = kernel2[576*(layer2_round+3)+layer2_counter*36+2];
                    g4c1_kernel3 = kernel2[576*(layer2_round+3)+layer2_counter*36+3];
                    g4c1_kernel4 = kernel2[576*(layer2_round+3)+layer2_counter*36+4];
                    g4c1_kernel5 = kernel2[576*(layer2_round+3)+layer2_counter*36+5];
                    g4c1_kernel6 = kernel2[576*(layer2_round+3)+layer2_counter*36+6];
                    g4c1_kernel7 = kernel2[576*(layer2_round+3)+layer2_counter*36+7];
                    g4c1_kernel8 = kernel2[576*(layer2_round+3)+layer2_counter*36+8];

                    g4c2_kernel0 = kernel2[576*(layer2_round+3)+layer2_counter*36+9];
                    g4c2_kernel1 = kernel2[576*(layer2_round+3)+layer2_counter*36+10];
                    g4c2_kernel2 = kernel2[576*(layer2_round+3)+layer2_counter*36+11];
                    g4c2_kernel3 = kernel2[576*(layer2_round+3)+layer2_counter*36+12];
                    g4c2_kernel4 = kernel2[576*(layer2_round+3)+layer2_counter*36+13];
                    g4c2_kernel5 = kernel2[576*(layer2_round+3)+layer2_counter*36+14];
                    g4c2_kernel6 = kernel2[576*(layer2_round+3)+layer2_counter*36+15];
                    g4c2_kernel7 = kernel2[576*(layer2_round+3)+layer2_counter*36+16];
                    g4c2_kernel8 = kernel2[576*(layer2_round+3)+layer2_counter*36+17];
                    
                    g4c3_kernel0 = kernel2[576*(layer2_round+3)+layer2_counter*36+18];
                    g4c3_kernel1 = kernel2[576*(layer2_round+3)+layer2_counter*36+19];
                    g4c3_kernel2 = kernel2[576*(layer2_round+3)+layer2_counter*36+20];
                    g4c3_kernel3 = kernel2[576*(layer2_round+3)+layer2_counter*36+21];
                    g4c3_kernel4 = kernel2[576*(layer2_round+3)+layer2_counter*36+22];
                    g4c3_kernel5 = kernel2[576*(layer2_round+3)+layer2_counter*36+23];
                    g4c3_kernel6 = kernel2[576*(layer2_round+3)+layer2_counter*36+24];
                    g4c3_kernel7 = kernel2[576*(layer2_round+3)+layer2_counter*36+25];
                    g4c3_kernel8 = kernel2[576*(layer2_round+3)+layer2_counter*36+26];
                    
                    g4c4_kernel0 = kernel2[576*(layer2_round+3)+layer2_counter*36+27];
                    g4c4_kernel1 = kernel2[576*(layer2_round+3)+layer2_counter*36+28];
                    g4c4_kernel2 = kernel2[576*(layer2_round+3)+layer2_counter*36+29];
                    g4c4_kernel3 = kernel2[576*(layer2_round+3)+layer2_counter*36+30];
                    g4c4_kernel4 = kernel2[576*(layer2_round+3)+layer2_counter*36+31];
                    g4c4_kernel5 = kernel2[576*(layer2_round+3)+layer2_counter*36+32];
                    g4c4_kernel6 = kernel2[576*(layer2_round+3)+layer2_counter*36+33];
                    g4c4_kernel7 = kernel2[576*(layer2_round+3)+layer2_counter*36+34];
                    g4c4_kernel8 = kernel2[576*(layer2_round+3)+layer2_counter*36+35];
            //-------------------------------------------------------------------------------------------------------//
                    g1_partial_sum[layer2_counter] = g1_sum;
                    g2_partial_sum[layer2_counter] = g2_sum;
                    g3_partial_sum[layer2_counter] = g3_sum;
                    g4_partial_sum[layer2_counter] = g4_sum;
                end
                #(`period);
                if(cal_en == 4'b1111)begin
                    for(res_loop=0;res_loop<3;res_loop=res_loop+1)begin
                        $fwrite(layer2_img_handle[layer2_round],"%c",img1_res[14:7]);
                        $fwrite(layer2_img_handle[layer2_round+1],"%c",img2_res[14:7]);
                        $fwrite(layer2_img_handle[layer2_round+2],"%c",img3_res[14:7]);
                        $fwrite(layer2_img_handle[layer2_round+3],"%c",img4_res[14:7]);
                    end
                end
                //#(`period);
            end
            #(`period);
        end
        $finish;
    end

endmodule