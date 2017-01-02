module explosion(	input Reset, frame_clk, explode, 
					input [15:0] keycode,
					input clkdiv2,
					output logic game_over, explosion0, explosion1, explosion2, explosion3
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
					Next_state <= Game_Over;
			Game_Over: 
				if (keycode == 8'h28 || keycode == 8'h2c || keycode == 8'h1a) //Enter or SPACE or w
					Next_state <= Start;
   			default : ;

	     endcase
    end	

	always_ff @ (posedge Reset or posedge clkdiv2  )
    begin 
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
		explosion0 <= 0;
		explosion1 <= 0;
		explosion2 <= 0;
		explosion3 <= 0;
		game_over  <= 0;
		 
	    case (State)
			Start : 
					game_over <= 0;

			explode0 : 
				begin
					explosion0 <= 1;
				end
			explode1 : 
				begin
					explosion1 <= 1;
				end
			explode2 : 
				begin
					explosion2 <= 1;
				end
			explode3 : 
				begin
					explosion3 <= 1;
				end

			Game_Over : 
				begin 
					game_over <= 1;
            	end
          default : ;
           
			  
		endcase
       
	end 	
	
endmodule