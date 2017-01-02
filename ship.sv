module  ship ( 	input Reset, frame_clk, //collision,
				input [15:0] keycode,
            	output [9:0]  SHIPX, SHIPY,
            	output ship);
    
    logic [9:0] SHIP_X_Pos, SHIP_X_Motion, SHIP_Y_Pos, Ship_Size;
    logic ship_state;
	 
    parameter [9:0] SHIP_X_Center=15;  // Center position on the X axis
    parameter [9:0] SHIP_X_Min=12;       // Leftmost point on the X axis
    parameter [9:0] SHIP_X_Max=206;     // Rightmost point on the X axis
    parameter [9:0] SHIP_X_Step=2;      // Step size on the X axis
    
    assign SHIP_Y_Pos = 250; //250
    assign Ship_Size = 16;
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ship
        if (Reset)  // Asynchronous Reset
        begin 
        		ship_state <= 0;
				SHIP_X_Motion <= 10'd0; //SHIP_X_Step;
				SHIP_X_Pos <= SHIP_X_Center;
        end
           
        //else if (collision)
				//ship_state = 0;

        else if ((!(ship_state)) && (keycode == 8'h28)) //enter
        begin
        	ship_state <= 1;
        	SHIP_X_Motion <= 10'd0; //SHIP_X_Step;
			SHIP_X_Pos <= SHIP_X_Center;
        end

        else 
        begin 
			case (keycode[7:0])
			 		8'h04: 
						begin //A							
			 			SHIP_X_Motion <= (~(SHIP_X_Step) + 1'b1);
						end
					8'h07: 
						begin //D
						SHIP_X_Motion <= SHIP_X_Step;
						end
					default: 
						begin
							SHIP_X_Motion <= 0; //default stop moving
						end
			endcase
				 
				 if ( ((SHIP_X_Pos + Ship_Size) >= SHIP_X_Max) )
						SHIP_X_Motion <= ((~SHIP_X_Step) + 1'b1);  // 2's complement.	
				 
				 else if((SHIP_X_Pos <= SHIP_X_Min))
					   	SHIP_X_Motion <= SHIP_X_Step;
				 
				SHIP_X_Pos <= (SHIP_X_Pos + SHIP_X_Motion); // Update ball position
		end  
    end
       
    assign SHIPX = SHIP_X_Pos;
   
    assign SHIPY = SHIP_Y_Pos;

    assign ship = ship_state;
    
endmodule