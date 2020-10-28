module lab4_2 (
 input clk,
 input rst,
 input en,
 input record,
 input display_1,
 input display_2,
 output [3:0] DIGIT,
output [6:0] DISPLAY
);

wire en_db;
debounce en_dber(.pb_debounced(en_db),.pb(en),.clk(clk));
wire en_1p;
onepulse en_1per(.pb_1pulse(en_1p),.pb_debounced(en_db),.clk(clk));

wire record_db;
debounce record_dber(.pb_debounced(record_db),.pb(record),.clk(clk));
wire record_1p;
onepulse record_1per(.pb_1pulse(record_1p),.pb_debounced(record_db),.clk(clk));

wire rst_db;
debounce rst_dber(.pb_debounced(rst_db),.pb(rst),.clk(clk));
wire rst_1p;
onepulse rst_1per(.pb_1pulse(rst_1p),.pb_debounced(rst_db),.clk(clk));
//101 1111 0101 1110 0001 0000 0000 == 10^8
reg [6:0]counter;// a 7 bit counter counting form 0 to 120
reg [6:0]counter_record_1;
reg [6:0]counter_record_2;

reg [4:0]show_min;
wire[4:0]show_min_w;
assign show_min_w = show_min;
reg [4:0]show_sec_ten;
wire[4:0]show_sec_ten_w;
assign show_sec_ten_w = show_sec_ten ;
reg [4:0]show_sec_one;
wire[4:0] show_sec_one_w;
assign show_sec_one_w = show_sec_one;
reg [4:0]show_sec_small;
wire[4:0]show_sec_small_w;
assign show_sec_small_w = show_sec_small;





endmodule
