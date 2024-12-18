module ReLU(
    input signed[35:0]ps_data1,ps_data2,ps_data3,ps_data4,
                      ps_data5,ps_data6,ps_data7,ps_data8,
                      ps_data9,ps_data10,ps_data11,ps_data12,
                      ps_data13,ps_data14,ps_data15,ps_data16,
    input signed[15:0]bias,
    output reg [35:0]img_res
);
    reg signed[35:0]tmp;

    always @(*) begin
        tmp = ps_data1 + ps_data2 + ps_data3 + ps_data4 +
              ps_data5 + ps_data6 + ps_data7 + ps_data8 + 
              ps_data9 + ps_data10 + ps_data11 + ps_data12 +
              ps_data13 + ps_data14 + ps_data15 + ps_data16 + bias;
    end

    always @(tmp) begin
        img_res <= (tmp>0)? tmp:0;
    end
endmodule