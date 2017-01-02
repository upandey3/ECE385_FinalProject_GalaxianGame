module gamestate(	input Reset, frame_clk, hit, explode,//collision,
					input [15:0] keycode,
					input game_over,
					output logic lost_game, level,
					output logic [8:0] hi_score, score
				);
					  

enum logic [3:0] {Start, level_1, Game_Over}   State, Next_state;   // Internal state logic

  always_ff @ (posedge Reset or posedge frame_clk  )
    begin : Assign_Next_State
        if (Reset)
        begin
				State <= Start;
  		  end
		  else 
            State <= Next_state;
    end	

//NEXT STATE
	always_comb
    begin 
	    Next_state = State;

        unique case (State)
            Start : 
	            if (keycode == 8'h28) //Enter or SPACE
					Next_state <= level_1;	

			level_1 : 
				if(game_over == 1)
					Next_state <= Game_Over;
						
			Game_Over: ;
				//if (keycode == 8'h28 || keycode == 8'h2c || keycode == 8'h1a) //Enter or SPACE or w
				//	Next_state <= level_1;
            
			default : ;

	     endcase
    end	
/*
    always_comb
    begin
    	if (collision)
	     	lives = lives - 1'b1;
	end
*/
//ACTION AT EACH STATE
   //always_comb
	always_ff @ (posedge Reset or posedge frame_clk  )
    begin 
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
		level <= 0;
		lost_game <= 0;
		score <= score;
		hi_score <= hi_score;
		 
	    case (State)
			Start : 
				begin 
					score <= 0;
				end

			level_1 : 
				begin
				level <= 1;
				
				if (hit)
					score <= score + 1;

				if (score > hi_score)		//if new hi score
					hi_score <= score;
			   end

			Game_Over : 
				begin 
					lost_game <= 1;
            end
        
          default : ;
           
			  
		endcase
       
	end 	
	
endmodule