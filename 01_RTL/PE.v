module PE(
    //input clk,reset,
    input signed[8:0]data0,data1,data2,data3,data4,data5,data6,data7,data8,
    input signed[15:0]kernel00,kernel01,kernel02,kernel03,kernel04,kernel05,kernel06,kernel07,kernel08,
    output reg signed[24:0]conv00,conv01,conv02,conv03,conv04,conv05,conv06,conv07,conv08
);
    always@(*)begin
        conv00 <= data0*kernel00;
        conv01 <= data1*kernel01;
        conv02 <= data2*kernel02;
        conv03 <= data3*kernel03;
        conv04 <= data4*kernel04;
        conv05 <= data5*kernel05;
        conv06 <= data6*kernel06;
        conv07 <= data7*kernel07;
        conv08 <= data8*kernel08;
    end
endmodule