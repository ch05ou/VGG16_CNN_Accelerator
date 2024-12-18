module PS(
    input signed[28:0]c1_sum,c2_sum,c3_sum,c4_sum,
    output reg signed[35:0]sum
);
    always @(*) begin
            sum <= c1_sum + c2_sum + c3_sum + c4_sum;
    end
endmodule