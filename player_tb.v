module test_1p;
reg clk,rst;
wire[3:0] d0 = 4'b0000;
wire[3:0] d1 = 4'b0001;
wire[3:0] d2 = 4'b0010;
wire[3:0] d3 = 4'b0011;

wire [3:0]digit;
wire [6:0]display;

four_bit_player test_player(
 .clk(clk),
 .digit_0(d0),
 .digit_1(d1),
 .digit_2(d2),
 .digit_3(d3),
 .rst(rst),
 .my_display(display),
 .my_digit(digit)

);

always #5 clk = ~clk;

initial begin
clk = 0;

    #25
    rst = 1;

    #20;
    rst = 0;
end

endmodule