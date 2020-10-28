module test_4_1;
reg clk, rst,en,dir;
wire[3:0]digit;
wire[6:0]display;
wire max,min;
 lab4_1 test(
 .clk(clk),
 .rst(rst),
 .en(en),
 .dir(dir),
 .DIGIT(digit) ,
 .DISPLAY(display),
 .max(max),
 .min(min)
);

reg sth;

always #5 clk = ~clk;

initial begin
    clk = 0;
    en = 0;
   // dir = 0;
    rst =0;
    #66
    rst =1;
    #50
    rst =0;
    //dir =1;
    #78
   // dir =0;
    en = 1;
    //dir = 1;
    #686
    en =0;
    //dir =0; 
end

endmodule