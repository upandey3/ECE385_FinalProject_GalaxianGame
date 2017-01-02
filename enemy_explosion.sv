module enemy_explosion(	input Reset, frame_clk, explode_enemy, 
					input [15:0] keycode,
					input clkdiv2,
					output explosion_enemy_0, explosion_enemy_1, explosion_enemy_2, explosion_enemy_3
				);
					  

enum logic [4:0] {Start, explode0, explode1, explode2, explode3, Game_Over}   State, Next_state;   // Internal state logic

  always_ff @ (posedge Reset or posedge clkdiv2  )
    begin : Assign_Next_State
        if (Reset)
			State <= Start; 
		else 
            State <= Next_state;
    end	

//NEXT STATE
	always_comb
    begin 
	    Next_state  = State;
        unique case (State)
            Start : 
				begin
			
	            if (explode == 1) //Enter or SPACEa
					Next_state <= explode0;	
				else
					Next_state <= Start;
				end
			explode0 : 
					Next_state <= explode1;
			explode1 : 
					Next_state <= explode2;
			explode2 : 
					Next_state <= explode3;
			explode3 : 
					Next_state <= Start;
		
   			default : ;

	     endcase
    end	

	always_ff @ (posedge Reset or posedge clkdiv2  )
    begin 
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
		explosion_enemy0 <= 0;
		explosion_enemy1 <= 0;
		explosion_enemy2 <= 0;
		explosion_enemy3 <= 0;
		 
	    case (State)
			Start : 

			explode0 : 
				begin
					explosion_enemy0 <= 1;
				end
			explode1 : 
				begin
					explosion_enemy1 <= 1;
				end
			explode2 : 
				begin
					explosion_enemy2 <= 1;
				end
			explode3 : 
				begin
					explosion_enemy3 <= 1;
				end

          default : ;
           
			  
		endcase
       
	end 	
	
endmodule