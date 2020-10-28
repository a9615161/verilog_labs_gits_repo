//note that I defined:
//val 10 map to ABF(upward arrow),
//val 11 map tp CDE(downword arrow) 

module val_to_display(input [3:0]val , output[6:0] my_display_pat);

reg [6:0]DISPLAY;
assign my_display_pat = DISPLAY; 
always @(*) begin      //1 is close 0 is light
case (val)           //GFEDCBA
    4'd0: DISPLAY = 7'b1000000;
    4'd1: DISPLAY = 7'b1111001;
    4'd2: DISPLAY = 7'b0100100;
    4'd3: DISPLAY = 7'b0110000;
    4'd4: DISPLAY = 7'b0011001;
    4'd5: DISPLAY = 7'b0010010;
    4'd6: DISPLAY = 7'b0000010;
    4'd7: DISPLAY = 7'b1111000;
    4'd8: DISPLAY = 7'b0000000;
    4'd9: DISPLAY = 7'b0010000;
    4'd10:DISPLAY = 7'b1011100;//A B F
    4'd11:DISPLAY = 7'b1100011;//C D E
    default: DISPLAY = 7'b1111111;
endcase
end

endmodule
