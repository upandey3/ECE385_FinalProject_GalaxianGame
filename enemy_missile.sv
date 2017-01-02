module  enemy_missile ( 	input Reset, frame_clk, Clk, 
				//input [15:0] keycode,
				input logic [9:0] enemy_posX [0:23],
				input logic [9:0] enemy_posY [0:23],
                input logic present [0:23],
				output [9:0]  beam_X, beam_Y,
				output beam_enable
			);
    
    logic beam_state;// beam_state;
    logic [3:0] beam_size;
    logic [9:0] beam_X_Pos, beam_Y_Motion, beam_Y_Pos;
	 
    parameter [9:0] beam_Y_Step=3;     // Step size on the Y axis
    logic [9:0] beam_Y_Start, beam_X_Start;
    //assign beam_Y_Start = 200;//enemy_posY[23];
    //assign beam_X_Start = 100;//enemy_posX[23];
    logic [4:0] d;

    
	always_ff @ (posedge frame_clk or posedge Reset)
    if (Reset)
        d <= 5'd1; 
	else
    begin
        d <= { d[3:0], d[4] ^ d[3] };
	end
	
	always_comb
	begin
		
        if (d == 5'd1 && present[23] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[23];
             		beam_X_Start = enemy_posX[23];
             	end
        else if (d == 5'd2 && present[22] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[22];
             		beam_X_Start = enemy_posX[22];
             	end
        else if (d == 5'd3 && present[21] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[21];
             		beam_X_Start = enemy_posX[21];
             	end
        else if (d == 5'd4 && present[20] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[20];
             		beam_X_Start = enemy_posX[20];
             	end
		else if (d == 5'd5 && present[0] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[0];
             		beam_X_Start = enemy_posX[0];
             	end
		else if (d == 5'd6 && present[1] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[1];
             		beam_X_Start = enemy_posX[1];
             	end
		else if (d == 5'd7 && present[2] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[2];
             		beam_X_Start = enemy_posX[2];
             	end
		else if (d == 5'd8 && present[3] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[3];
             		beam_X_Start = enemy_posX[3];
             	end
		else if (d == 5'd9 && present[4] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[4];
             		beam_X_Start = enemy_posX[4];
             	end
		else if (d == 5'd10 && present[5] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[5];
             		beam_X_Start = enemy_posX[5];
             	end
		else if (d == 5'd11 && present[6] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[6];
             		beam_X_Start = enemy_posX[6];
             	end
		else if (d == 5'd12 && present[7] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[7];
             		beam_X_Start = enemy_posX[7];
             	end
		else if (d == 5'd13 && present[8] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[8];
             		beam_X_Start = enemy_posX[8];
             	end
		else if (d == 5'd14 && present[9] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[9];
             		beam_X_Start = enemy_posX[9];
             	end
		else if (d == 5'd15 && present[10] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[10];
             		beam_X_Start = enemy_posX[10];
             	end
		else if (d == 5'd16 && present[11] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[11];
             		beam_X_Start = enemy_posX[11];
             	end
		else if (d == 5'd17 && present[12] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[12];
             		beam_X_Start = enemy_posX[12];
             	end
		else if (d == 5'd18 && present[13] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[13];
             		beam_X_Start = enemy_posX[13];
             	end
		else if (d == 5'd19 && present[14] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[14];
             		beam_X_Start = enemy_posX[14];
             	end
		else if (d == 5'd20 && present[15] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[15];
             		beam_X_Start = enemy_posX[15];
             	end
		else if (d == 5'd21 && present[16] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[16];
             		beam_X_Start = enemy_posX[16];
             	end
		else if (d == 5'd22 && present[17] == 1) 
             	begin
             		beam_Y_Start = enemy_posY[17];
             		beam_X_Start = enemy_posX[17];
             	end
		else if (d == 5'd23 && present[18] == 1) 
              	begin
             		beam_Y_Start = enemy_posY[18];
             		beam_X_Start = enemy_posX[18];
             	end
	    else if (d == 5'd24 && present[19] == 1)
             	begin
             		beam_Y_Start = enemy_posY[19];
             		beam_X_Start = enemy_posX[19];
             	end		              
		else 
				begin
             		beam_Y_Start = 10'd1;
             		beam_X_Start = 10'd1;
             	end
	     
	end 
	
    always_ff @ (posedge Reset or posedge frame_clk )
    begin
        if (Reset)  // Asynchronous Reset
        begin 
			beam_state <= 0;
			beam_Y_Motion <= 0;
		 	beam_Y_Pos <= beam_Y_Start;
		 	beam_X_Pos <= beam_X_Start;
        end
		  
     else
     begin
        if (beam_state == 0 /*&& d < 5'd25 */&& beam_Y_Start != 10'd1)//((keycode[7:0] == 8'h2c) || (keycode[15:8] == 8'h2c) && (beam_state == 0))
        begin   
            beam_state <= 1;                            
            beam_Y_Motion <= (beam_Y_Step) + 1'b1;
            beam_Y_Pos <= beam_Y_Start;
            beam_X_Pos <= beam_X_Start;
        end

        else if ((beam_Y_Pos <= 0) || (beam_Y_Pos >= 287))
        begin
            beam_state <= 0;
            beam_Y_Motion <= 0;
            beam_Y_Pos <= beam_Y_Start;
            beam_X_Pos <= beam_X_Start;
        end
				

		else
		begin
			beam_X_Pos <= beam_X_Pos;
			beam_Y_Motion <= beam_Y_Motion;
			beam_Y_Pos <= (beam_Y_Pos + beam_Y_Motion);
		end

	
	  
    end
    end
    assign beam_X = beam_X_Pos;
    assign beam_Y = beam_Y_Pos;
  	assign beam_enable = beam_state;

endmodule
