module lab4_1 (
 input clk,
 input rst,
 input en,
 input dir,
 output [3:0] DIGIT,
 output [6:0] DISPLAY,
 output max,
 output min
);

wire dived_clk ;
clock_div_mani clk_divider( .clk(clk), .dived_clk(dived_clk),.rst(rst));
//handle the debounce of buttons
wire en_db;
debounce en_dber(.pb_debounced(en_db),.pb(en),.clk(clk));
wire en_1p;
onepulse en_1per(.pb_1pulse(en_1p),.pb_debounced(en_db),.clk(clk));

wire dir_db;
debounce dir_dber(.pb_debounced(dir_db),.pb(dir),.clk(clk));
wire dir_1p;
onepulse dir_1per(.pb_1pulse(dir_1p),.pb_debounced(dir_db),.clk(clk));

wire rst_db;
debounce rst_dber(.pb_debounced(rst_db),.pb(rst),.clk(clk));
wire rst_1p;
onepulse rst_1per(.pb_1pulse(rst_1p),.pb_debounced(rst_db),.clk(clk));

//using regs to store the en,dir state
reg en_state;
reg dir_state;
//a counter countering form 0 to 99,7 bits
reg[6:0]val_counter;
//you get it
reg is_max ;
reg is_min ;
reg counter_no_zero;
//assign max = is_max;
assign max = counter_no_zero;
assign min = is_min;

reg  [3:0]arrow_val ;
wire [3:0]arrow_val_w;
assign  arrow_val_w =arrow_val ;
//maintain the relationship between 
//counter val and the display pattern to be showed

wire[6:0] display;
wire[3:0] digit;
wire [3:0]ten_digit_val;
assign ten_digit_val = (val_counter / 7'd10) ;
wire [3:0]one_digit_val ;
assign  one_digit_val = (val_counter % 7'd10);

assign DISPLAY =display;
assign DIGIT =digit;


four_bit_player my_player(
.clk(clk),
.digit_0(one_digit_val),
.digit_1(ten_digit_val),
.digit_2(arrow_val_w),
.digit_3(arrow_val_w),
.rst(rst),

.my_digit(digit),
.my_display(display)
);

wire[6:0]counter_add1 ;
assign counter_add1= val_counter +1;
wire[6:0]counter_neg1 ;
assign  counter_neg1 =  val_counter -1;


//maintain the val_cunter value and  overtime
always@(posedge dived_clk , posedge rst_1p)begin
    if(rst_1p==1'b1);
    else if(en_state==1'b1)begin

        if(dir_state == 1'b1 )begin
            if(!is_max)begin
            val_counter = counter_add1;
            end
            else val_counter = 7'b1100011;//99   
            
        end
        
        else if(dir_state == 1'b0 )begin
            if( !is_min)begin
            val_counter = counter_neg1;
            end
            else val_counter = 7'b0000000;
        end
    end
end

//maintain tranformation of states
always@(posedge clk , posedge rst_1p)begin//to do : sperate state change and counter change
    if(val_counter > 0)counter_no_zero = 1'b1;
    else counter_no_zero = 1'b0;
    if(rst_1p==1'b1)begin
        val_counter = 0 ;
        is_min = 0;
        is_max = 0;
        arrow_val = 10; 
        en_state =0;
        dir_state = 1;//upward
        counter_no_zero = 0;
        
    end
    else begin 
        if(en_1p==1'b1)en_state = ~en_state;
        if(dir_1p==1'b1)dir_state = ~dir_state;
        if(en_state==1'b1)begin
            
            if(val_counter>0) is_min = 0;
            else is_min = 1;
            if(val_counter>=7'b1100011) is_max = 1;//99
            else is_max =0;

            if(dir_state == 1'b1 )begin
                arrow_val = 10;//upward val          
            end
            else if(dir_state == 1'b0 )begin
                arrow_val = 11;//downward val                
            end
        end
        else begin//not enable
            ;
        end

    end
     

end

//maintain which display value to be showed

 // add your design here
endmodule
