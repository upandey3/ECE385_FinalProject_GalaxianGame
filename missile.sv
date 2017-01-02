module  missile ( 	input Reset, frame_clk, hit,//missile1_hit, missile2_hit,
				input [15:0] keycode,
				input [9:0] SHIPX, SHIPY,
				output [9:0]  MISSILE1_X, MISSILE1_Y, //MISSILE2_X, MISSILE2_Y,
				output missile_1,
				output logic reset_hit
			);
    
    logic missile1_state;// missile2_state;
    logic [3:0] missile_size;
    logic [9:0] missile1_X_Pos, missile1_Y_Motion, missile1_Y_Pos;
    //logic [9:0] missile2_X_Pos, missile2_Y_Motion, missile2_Y_Pos;
	 
    parameter [9:0] missile_Y_Step=6;     // Step size on the Y axis
    logic [9:0] missile_Y_Start, missile_X_Start;
	 
	 assign missile_Y_Start = SHIPY - 3;
    assign missile_X_Start = SHIPX - 1;
	 
	 enum logic [1:0] {Hit_Off, Hit_On, Trans}   State, Next_state;   // Internal state logic

  always_ff @ (posedge Reset or posedge frame_clk  )
    begin : Assign_Next_State
        if (Reset)
        begin
				State <= Hit_Off;
  		  end
		  else 
            State <= Next_state;
    end	

//NEXT STATE
	always_comb
    begin 
	    Next_state  = State;

        unique case (State)
         Hit_Off : 
				if (hit)
					Next_state <= Hit_On;	

			Hit_On : 
					Next_state <= Trans;
						
			Trans: 
					Next_state <= Hit_Off;
            
			default : ;

	     endcase
    end	

//ACTION AT EACH STATE
   always_comb
	begin
        //default controls signal values; within a process, these can be
        //overridden further down (in the case statement, in this case)
		reset_hit = 0;
		 
	    case (State)
			Hit_Off : ;

			Hit_On : 
				reset_hit = 1;

			Trans : 
				reset_hit = 1;
				
			default : ;
		 endcase
	end
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin
        if (Reset)  // Asynchronous Reset
        begin 
			missile1_state <= 0;
			missile1_Y_Motion <= 0;
		 	missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
        end 
		  
     else
     begin
	  
		if (hit)
		begin
			missile1_state <= 0;
			missile1_Y_Motion <= 0;
			missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
		end
		
		else if ((missile1_Y_Pos <= 0) || (missile1_Y_Pos >= 287))
		begin
			missile1_state <= 0;
			missile1_Y_Motion <= 0;
			missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
		end
		
		else if (((keycode[7:0] == 8'h2c) || (keycode[15:8] == 8'h2c)) && (missile1_state == 0))
		begin
			missile1_state <= 1;							
		 	missile1_Y_Motion <= (~missile_Y_Step) + 1'b1;
		 	missile1_Y_Pos <= missile_Y_Start;
		 	missile1_X_Pos <= missile_X_Start;
		end
		
		else
		begin
			missile1_X_Pos <= missile1_X_Pos;
			missile1_Y_Motion <= missile1_Y_Motion;
			missile1_Y_Pos <= (missile1_Y_Pos + missile1_Y_Motion);
		end
	 end
    end
       
    assign MISSILE1_X = missile1_X_Pos;
    assign MISSILE1_Y = missile1_Y_Pos;
	 assign missile_1 = missile1_state;

endmodule
