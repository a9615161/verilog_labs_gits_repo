//to do : take current state and show them at turns
module four_bit_player(
input clk,
input [3:0]digit_0,
input [3:0]digit_1,
input [3:0]digit_2,
input [3:0]digit_3,
input rst,

output [6:0]my_display,
output [3:0]my_digit

);


wire dived_clk ;
clk_div_flip my_player_clk( .clk(clk), .dived_clk(dived_clk),.rst(rst));

reg [6:0]state ;
assign my_display = state;

wire [6:0]digit_0_display;
wire [6:0]digit_1_display;
wire [6:0]digit_2_display;
wire [6:0]digit_3_display;//my_display_pat
val_to_display display_0(.val(digit_0) , .my_display_pat(digit_0_display));
val_to_display display_1(.val(digit_1) , .my_display_pat(digit_1_display));
val_to_display display_2(.val(digit_2) , .my_display_pat(digit_2_display));
val_to_display display_3(.val(digit_3) , .my_display_pat(digit_3_display));

reg[3:0] DIGIT;
assign my_digit = DIGIT;

    always @(posedge dived_clk,posedge rst) begin
        if(rst == 1) DIGIT = 4'b0000;
        case (DIGIT)
            4'b1110: begin
                DIGIT = 4'b1101;
                state = digit_1_display;
            end
            4'b1101: begin
                DIGIT = 4'b1011;
                state = digit_2_display;
            end
            4'b1011: begin
                DIGIT = 4'b0111;
                state = digit_3_display;
            end
            4'b0111: begin
                DIGIT = 4'b1110;
                state = digit_0_display;
            end
            default: begin
                DIGIT = 4'b1110;
                state = 7'b1111111;
            end
        endcase;
    end

endmodule