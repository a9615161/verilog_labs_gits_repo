module clock_div_mani ( clk, dived_clk,rst);
parameter n = 23;
input clk;
input rst;
output dived_clk;
// add your design here
reg[n:0] counter;

always @(posedge clk,posedge rst)begin
        if(rst == 1)
        counter = 0;
        else counter=counter + 1;

end

assign dived_clk = counter[n];


endmodule