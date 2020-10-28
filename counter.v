module counter 

(
    input clk,
    input rst,
    input en,
    input dir,
    output [6 : 0]  DISPLAY,
    output [3 : 0]    DIGIT,
    output max,
    output min
);


reg [6:0]counter;
wire[6:0]counter_next;
assign counter_next  = counter + 1;
wire[6:0]counter_last;
assign counter_last  = counter - 1;
wire[6:0]counter_w;
assign counter_w   = counter;

wire dived_clk ;

clock_div_mani one_sec(.clk(clk),.dived_clk(dived_clk),.rst(rst));

wire en_db ;
debounce en_dber(.pb_debounced(en_db), .pb(en), .clk(clk));
wire en_1p;
onepulse en_1per(.pb_debounced(en_db), .clk(clk),.pb_1pulse(en_1p));
reg en_state;

wire dir_db ;
debounce dir_dber(.pb_debounced(dir_db), .pb(dir), .clk(clk));
wire dir_1p;
onepulse dir_1per(.pb_debounced(dir_db), .clk(clk),.pb_1pulse(dir_1p));
reg dir_state;

wire rst_db ;
debounce rst_dber(.pb_debounced(rst_db), .pb(rst), .clk(clk));
wire rst_1p;
onepulse rst_1per(.pb_debounced(rst_db), .clk(clk),.pb_1pulse(rst_1p));

//debug
//assign min = en_state;
//assign max = dir_state;
//debug
reg is_max;
assign max = is_max;
reg is_min;
assign min = is_min ;
//
reg [3:0]arr_val ;
wire[3:0]arr_val_w;
assign arr_val_w =arr_val ;
//
reg [23:0]time_counter;
wire[23:0]next_time_counter ;
assign next_time_counter = time_counter + 1;


always @(posedge clk) begin
    if(rst_1p == 1'b1) begin
        en_state = 1'b0;
        dir_state = 1'b1;
        time_counter = 0;
        counter = 0;
        is_max = 0;
        is_min = 0;
    end
    else begin
        if(en_1p == 1'b1) en_state = ~en_state;
        if(dir_1p== 1'b1) dir_state= ~dir_state;
        if(en_state == 1'b1)begin
            if(counter == 7'd99)
                is_max = 1'b1;
            else if(counter == 7'd0)
                is_min = 1'b1;
            else begin
                is_max = 1'b0;
                is_min = 1'b0;
            end

        end
        if(time_counter[23]==0&&next_time_counter[23] == 1)begin

                if(en_state==1'b1) begin

                    if(dir_state == 1'b1&&!is_max)
                        counter = counter_next;
                    else if(dir_state == 1'b0&&!is_min)
                        counter = counter_last;
                end
                if(dir_state == 1'b1)arr_val = 4'd10;
                else arr_val = 4'd11;
            end

        end
    time_counter = next_time_counter;
end







wire [3:0]ten_digit;
assign  ten_digit = counter /7'd10 ;
wire [3:0]one_digit;
assign one_digit  = counter %7'd10;

four_bit_player(
.clk(clk),
.digit_0(one_digit),
.digit_1(ten_digit),
.digit_2(arr_val_w),
.digit_3(arr_val_w),
.rst(rst),
.my_display(DISPLAY),
.my_digit(DIGIT)
);


endmodule  