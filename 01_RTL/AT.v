// AT as Adder Tree
module AT(
    input signed[24:0]pe_out_0,pe_out_1,pe_out_2,pe_out_3,pe_out_4,pe_out_5,pe_out_6,pe_out_7,pe_out_8,
    output reg signed[28:0]sum
);
    reg signed[25:0]tmp01,tmp23,tmp45,tmp67,tmp8;
    reg signed[26:0]tmp0123,tmp4567,tmp8_2;
    reg signed[27:0]tmp027,tmp8_3;

    always @(*) begin
        tmp01 = pe_out_0 + pe_out_1;
        tmp23 = pe_out_2 + pe_out_3;
        tmp45 = pe_out_4 + pe_out_5;
        tmp67 = pe_out_6 + pe_out_7;
        tmp8 = pe_out_8;
    end

    always @(*)begin
        tmp0123 = tmp01 + tmp23;
        tmp4567 = tmp45 + tmp67;
        tmp8_2 = tmp8;
    end

    always @(*) begin
        tmp027 = tmp0123 + tmp4567;
        tmp8_3 = tmp8_2;
    end
    
    always @(*) begin
        sum = tmp027 + tmp8_3;
    end
endmodule