module  enemy ( input Reset, frame_clk, /*collision,*/ level, lost_game,
				input enemy_missile_collision [0:23],
				output [9:0] enemy_posX [0:23],
				output [9:0] enemy_posY [0:23],
				output [4:0] enemy_type,
				output enemy_present [0:23]
			  );
    
    //logic ship_state;
    //logic [9:0] SHIP_X_Pos, SHIP_X_Motion, SHIP_Y_Pos, Ship_Size;
    logic [9:0] posX[0:23];
    logic [9:0] posY[0:23];
    logic [4:0] type_of_enemy;
    logic present [0:23];
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Display_enemy
        if (Reset)  // Asynchronous Reset
			begin
				
				posX[0] <= 10'd43;
				posX[1] <= 10'd61;
				posX[2] <= 10'd79;
				posX[3] <= 10'd97;
				posX[4] <= 10'd115;
				posX[5] <= 10'd133;
				posX[6] <= 10'd151;
				posX[7] <= 10'd169;
				
				posX[8] <= 10'd43;
				posX[9] <= 10'd61;
				posX[10] <= 10'd79;
				posX[11] <= 10'd97;
				posX[12] <= 10'd115;
				posX[13] <= 10'd133;
				posX[14] <= 10'd151;
				posX[15] <= 10'd169;

				posX[16] <= 10'd43;
				posX[17] <= 10'd61;
				posX[18] <= 10'd79;
				posX[19] <= 10'd97;
				posX[20] <= 10'd115;
				posX[21] <= 10'd133;
				posX[22] <= 10'd151;
				posX[23] <= 10'd169;

				posY[0] <= 10'd48;
				posY[1] <= 10'd48;
				posY[2] <= 10'd48;
				posY[3] <= 10'd48;
				posY[4] <= 10'd48;
				posY[5] <= 10'd48;
				posY[6] <= 10'd48;
				posY[7] <= 10'd48;

				posY[8] <= 10'd66;
				posY[9] <= 10'd66;
				posY[10] <= 10'd66;
				posY[11] <= 10'd66;
				posY[12] <= 10'd66;
				posY[13] <= 10'd66;
				posY[14] <= 10'd66;
				posY[15] <= 10'd66;

				posY[16] <= 10'd84;
				posY[17] <= 10'd84;
				posY[18] <= 10'd84;
				posY[19] <= 10'd84;
				posY[20] <= 10'd84;
				posY[21] <= 10'd84;
				posY[22] <= 10'd84;
				posY[23] <= 10'd84;
			
				present[0] <= 1;
				present[1] <= 1;
				present[2] <= 1;
				present[3] <= 1;
				present[4] <= 1;
				present[5] <= 1;
				present[6] <= 1;
				present[7] <= 1;
				present[8] <= 1;
				present[9] <= 1;
				present[10] <= 1;
				present[11] <= 1;
				present[12] <= 1;
				present[13] <= 1;
				present[14] <= 1;
				present[15] <= 1;
				present[16] <= 1;
				present[17] <= 1;
				present[18] <= 1;
				present[19] <= 1;
				present[20] <= 1;
				present[21] <= 1;
				present[22] <= 1;
				present[23] <= 1;


				type_of_enemy <= 4'd0;
	        end
	    else
	    begin
	    	if ((level == 0 )|| (lost_game == 1))
	    		type_of_enemy <= 4'd0;
	        else 
		        begin
		        // The 24 enemies are laid out in 8 x 3 space with each enemy of the size 16 * 16.
		        // row 1 = 0 ... 7,  row 2 =  8... 15, row 3 =  16... 23
		        // Enemy 0 is at 48, 48, Enemy 1 is at 64, 48 ... Enemy 23 is at 160, 80  
					type_of_enemy <= 4'd1;
					
					if (enemy_missile_collision[0] == 1)
						present[0] <= 0;
					
					if (enemy_missile_collision[1] == 1)
						present[1] <= 0;

					if (enemy_missile_collision[2] == 1)
						present[2] <= 0;

					if (enemy_missile_collision[3] == 1)
						present[3] <= 0;

					if (enemy_missile_collision[4] == 1)
						present[4] <= 0;

					if (enemy_missile_collision[5] == 1)
						present[5] <= 0;

					if (enemy_missile_collision[6] == 1)
						present[6] <= 0;

					if (enemy_missile_collision[7] == 1)
						present[7] <= 0;

					if (enemy_missile_collision[8] == 1)
						present[8] <= 0;

					if (enemy_missile_collision[9] == 1)
						present[9] <= 0;

					if (enemy_missile_collision[10] == 1)
						present[10] <= 0;

					if (enemy_missile_collision[11] == 1)
						present[11] <= 0;

					if (enemy_missile_collision[12] == 1)
						present[12] <= 0;

					if (enemy_missile_collision[13] == 1)
						present[13] <= 0;

					if (enemy_missile_collision[14] == 1)
						present[14] <= 0;

					if (enemy_missile_collision[15] == 1)
						present[15] <= 0;

					if (enemy_missile_collision[16] == 1)
						present[16] <= 0;
					

					//Add counter for victory
				end
		end  
    end
       
    assign enemy_posY = posY; 
    assign enemy_posX = posX;
    assign enemy_type = type_of_enemy;
    assign enemy_present = present;
    

endmodule
