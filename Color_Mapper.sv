module  color_mapper (input Reset, Clk, 
                             input [9:0] ShipX, ShipY, DrawX, DrawY,
                      input [9:0] missile1_x, missile1_y,//missile2_X, missile2_Y,
                      input [9:0] enemy_posX [0:23],
                      input [9:0] enemy_posY [0:23],
                      input [4:0] enemy_type, enemy_type2, enemy_type3,
                      input [9:0]  beam_X, beam_Y,
                      input beam_enable,

                     input [0:15][0:15][0:3] enemy_0_0,
                     input [0:15][0:15][0:3] enemy_0_1,
                     input [0:15][0:15][0:3] enemy_1_0,
                     input [0:15][0:15][0:3] enemy_1_1,
                     input [0:15][0:15][0:3] enemy_2_0,
                     input [0:15][0:15][0:3] enemy_2_1,
                     input [0:15][0:15][0:3] enemy_3_0,
                     input [0:15][0:15][0:3] enemy_3_1,
                     input [0:15][0:15][0:3] enemy_4_00,
                     input [0:15][0:15][0:3] enemy_5_00,
                     input [0:15][0:15][0:3] enemy_6_00,
                     input [0:15][0:15][0:3] enemy_7_00,
                     input [0:15][0:15][0:3] enemy_8_0,
                     input [0:15][0:15][0:3] enemy_8_1,
                     input [0:15][0:15][0:3] enemy_8_2,
                     input [0:15][0:15][0:3] enemy_9_00,
                     input [0:15][0:15][0:3] player,
                     input [0:15][0:15][0:3] player_missile,
                     input [0:43][0:143][0:3] Logo_Galaxian,
                     input [0:9][0:82][0:3] Logo_Gameover,
                     input [0:8][0:119][0:3] Logo_Credits,
                     input [0:8][0:136][0:3] Logo_Retry, 
                     input [0:31][0:31][0:3] explosion_0,
                     input [0:31][0:31][0:3] explosion_1,
                     input [0:31][0:31][0:3] explosion_2,
                     input [0:31][0:31][0:3] explosion_3,
             
                    input level, lost_game, ship, missile, reset_hit,
                    
                    input explosion0, explosion1, explosion2, explosion3,
                    output logic present [0:23],
                    output logic explode, hit,
                    output logic [7:0]  Red, Green, Blue );
    
    //Galaxian Game Start specificalions
    //center - Galaxian Logo
    logic [3:0] Logo_Galaxian_on;
    logic[9:0] Logo_Galaxian_x = 40; 
    logic[9:0] Logo_Galaxian_y = 122;
    logic[9:0] Logo_Galaxian_size_x = 10'd143;
    logic[9:0] Logo_Galaxian_size_y = 10'd43;
    //center below - Credits Logo
    logic [3:0] Logo_Credits_on;
    logic[9:0] Logo_Credits_x = 52;  
    logic[9:0] Logo_Credits_y = 176;
    logic[9:0] Logo_Credits_size_x = 10'd119;
    logic[9:0] Logo_Credits_size_y = 10'd8;


    //Game Over state specifications
    //center = Game over Logo
    logic [3:0] Logo_Gameover_on;
    logic[9:0] Logo_Gameover_x = 70; 
    logic[9:0] Logo_Gameover_y = 139;
    logic[9:0] Logo_Gameover_size_x = 10'd82;
    logic[9:0] Logo_Gameover_size_y = 10'd9;
    //center below - Retry Logo specifications
    logic [3:0] Logo_Retry_on;
    logic[9:0] Logo_Retry_x = 70; 
    logic[9:0] Logo_Retry_y = 200;
    logic[9:0] Logo_Retry_size_x = 10'd136;
    logic[9:0] Logo_Retry_size_y = 10'd8;
    
     logic enemy_on_sig_0, enemy_on_sig_1, enemy_on_sig_2, enemy_on_sig_3;
     logic enemy_on_sig_4, enemy_on_sig_5, enemy_on_sig_6, enemy_on_sig_7;
     logic enemy_on_sig_8, enemy_on_sig_9, enemy_on_sig_10, enemy_on_sig_11;
     logic enemy_on_sig_12, enemy_on_sig_13, enemy_on_sig_14, enemy_on_sig_15;
     logic enemy_on_sig_16, enemy_on_sig_17, enemy_on_sig_18, enemy_on_sig_19;
     logic enemy_on_sig_20, enemy_on_sig_21, enemy_on_sig_22, enemy_on_sig_23;
     
     always_ff @ (posedge Reset or posedge Clk)
     begin
         if (Reset)
         begin
            enemy_on_sig_0 <= 1;
            enemy_on_sig_1 <= 1;
            enemy_on_sig_2 <= 1;
            enemy_on_sig_3 <= 1;
            enemy_on_sig_4 <= 1;
            enemy_on_sig_5 <= 1;
            enemy_on_sig_6 <= 1;
            enemy_on_sig_7 <= 1;
            
            enemy_on_sig_8 <= 1;
            enemy_on_sig_9 <= 1;
            enemy_on_sig_10 <= 1;
            enemy_on_sig_11 <= 1;
            enemy_on_sig_12 <= 1;
            enemy_on_sig_13 <= 1;
            enemy_on_sig_14 <= 1;
            enemy_on_sig_15 <= 1;
            
            enemy_on_sig_16 <= 1;
            enemy_on_sig_17 <= 1;
            enemy_on_sig_18 <= 1;
            enemy_on_sig_19 <= 1;
            enemy_on_sig_20 <= 1;
            enemy_on_sig_21 <= 1;
            enemy_on_sig_22 <= 1;
            enemy_on_sig_23 <= 1;

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
         end
         
         else
         begin
                if ((Enemy_at_0_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[0] <= 0;
                    enemy_on_sig_0 <= 0;
                end
                if ((Enemy_at_1_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[1] <= 0;
                    enemy_on_sig_1 <= 0;
                end
                if ((Enemy_at_2_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[2] <= 0;
                    enemy_on_sig_2 <= 0;
                end
                if ((Enemy_at_3_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[3] <= 0;
                    enemy_on_sig_3 <= 0;
                end
                if ((Enemy_at_4_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[4] <= 0;
                    enemy_on_sig_4 <= 0;
                end
                if ((Enemy_at_5_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[5] <= 0;
                    enemy_on_sig_5 <= 0;
                end
                if ((Enemy_at_6_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[6] <= 0;
                    enemy_on_sig_6 <= 0;
                end
                if ((Enemy_at_7_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[7] <= 0;
                    enemy_on_sig_7 <= 0;
                end

                if ((Enemy_at_8_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[8] <= 0;
                    enemy_on_sig_8 <= 0;
                end
                if ((Enemy_at_9_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[9] <= 0;
                    enemy_on_sig_9 <= 0;
                end
                if ((Enemy_at_10_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[10] <= 0;
                    enemy_on_sig_10 <= 0;
                end
                if ((Enemy_at_11_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[11] <= 0;
                    enemy_on_sig_11 <= 0;
                end
                if ((Enemy_at_12_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[12] <= 0;
                    enemy_on_sig_12 <= 0;
                end
                if ((Enemy_at_13_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[13] <= 0;
                    enemy_on_sig_13 <= 0;
                end
                if ((Enemy_at_14_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[14] <= 0;
                    enemy_on_sig_14 <= 0;
                end
                if ((Enemy_at_15_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[15] <= 0;
                    enemy_on_sig_15 <= 0;
                end

                if ((Enemy_at_16_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[16] <= 0;
                    enemy_on_sig_16 <= 0;
                end
                if ((Enemy_at_17_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[17] <= 0;
                    enemy_on_sig_17 <= 0;
                end
                if ((Enemy_at_18_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[18] <= 0;
                    enemy_on_sig_18 <= 0;
                end
                if ((Enemy_at_19_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[19] <= 0;
                    enemy_on_sig_19 <= 0;
                end
                if ((Enemy_at_20_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[20] <= 0;
                    enemy_on_sig_20 <= 0;
                end
                if ((Enemy_at_21_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[21] <= 0;
                    enemy_on_sig_21 <= 0;
                end
                if ((Enemy_at_22_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[22] <= 0;
                    enemy_on_sig_22 <= 0;
                end
                if ((Enemy_at_23_on != 4'd0) && (missile_on != 4'd0))
                begin
                    present[23] <= 0;
                    enemy_on_sig_23 <= 0;
                end

         end
     end

    logic player_alive;
    always_ff @ (posedge Reset or posedge Clk )
     begin
         if (Reset)
            begin
             player_alive <= 1;
             explode <= 0;
            end
         else
         begin
            if (Ship_on != 4'd0 && beam_on != 4'd0)
                begin
                    player_alive <= 0;
                    explode <= 1; 
                end 
         end
    end
     
     always_ff @ (posedge Reset or posedge Clk )
     begin
         if (Reset)
            hit <= 0;
         else
         begin
            if ((Enemy_at_0_on|| Enemy_at_1_on || Enemy_at_2_on || Enemy_at_3_on || Enemy_at_4_on || Enemy_at_5_on 
                || Enemy_at_6_on || Enemy_at_7_on || Enemy_at_8_on || Enemy_at_9_on || Enemy_at_10_on || Enemy_at_11_on 
                || Enemy_at_12_on || Enemy_at_13_on || Enemy_at_14_on || Enemy_at_15_on || Enemy_at_16_on || Enemy_at_17_on 
                || Enemy_at_18_on || Enemy_at_19_on || Enemy_at_20_on || Enemy_at_21_on || Enemy_at_22_on || Enemy_at_23_on) && missile_on)
                hit <= 1;
            else if (reset_hit)
                hit <= 0;
         end
    end
    

    //-----------------------------------------Draw StartScreen --------------------------------------------------//

    always_comb
    begin:galaxian_logo
        
        if (level == 0 && lost_game == 0 && ((DrawX >= Logo_Galaxian_x) && (DrawX <= Logo_Galaxian_x + Logo_Galaxian_size_x) 
            && (DrawY >= Logo_Galaxian_y) &&(DrawY <= Logo_Galaxian_y +Logo_Galaxian_size_y)))
            begin
                Logo_Galaxian_on = Logo_Galaxian[DrawY-Logo_Galaxian_y][DrawX-Logo_Galaxian_x];
            end
        else 
            begin
               Logo_Galaxian_on = 4'd0;   
            end   
    end 

    always_comb
    begin:credits_logo
        
        if (level == 0 && lost_game == 0 && ((DrawX >= Logo_Credits_x) && (DrawX <= Logo_Credits_x + Logo_Credits_size_x) 
            && (DrawY >= Logo_Credits_y) &&(DrawY <= Logo_Credits_y +Logo_Credits_size_y)))
            begin
                Logo_Credits_on = Logo_Credits[DrawY-Logo_Credits_y][DrawX-Logo_Credits_x];
            end
        else 
            begin
               Logo_Credits_on = 4'd0;   
            end   
    end 

    //-----------------------------------------Draw GameOver --------------------------------------------------//
    
    always_comb
    begin:game_over_logo
        
        if (lost_game == 1 && ((DrawX >= Logo_Gameover_x) && (DrawX <= Logo_Gameover_x + Logo_Gameover_size_x) 
            && (DrawY >= Logo_Gameover_y) &&(DrawY <= Logo_Gameover_y +Logo_Gameover_size_y)))
            begin
                Logo_Gameover_on = Logo_Gameover[DrawY-Logo_Gameover_y][DrawX-Logo_Gameover_x];
            end
        else 
            begin
               Logo_Gameover_on = 4'd0;   
            end   
    end 
	/*
    always_comb
    begin:press_w_to_try_again_logo
        
        if (lost_game == 1 && ((DrawX >= Logo_Retry_x) && (DrawX <= Logo_Retry_x + Logo_Retry_size_x) 
            && (DrawY >= Logo_Retry_y) &&(DrawY <= Logo_Retry_y +Logo_Retry_size_y)))
            begin
                Logo_Retry_on = Logo_Retry[DrawY-Logo_Retry_y][DrawX-Logo_Retry_x];
            end
        else 
            begin
               Logo_Retry_on = 4'd0;   
            end   
    end
	 */

    //-----------------------------------------Draw Background --------------------------------------------//
    /*
    logic [3:0] background_1_on;
    logic[9:0] background_1_x = 0; 
    logic[9:0] background_1_y = 0;
    logic[9:0] background_1_size_x = 223;//background_x;
    logic[9:0] background_1_size_y = 287;//background_y;

    always_comb
    begin:background_logo
        
        if (((DrawX >= background_1_x) && (DrawX <= background_1_x + background_1_size_x) 
            && (DrawY >= background_1_y) &&(DrawY <= background_1_y +background_1_size_y)))
            begin
                background_1_on = background_1[DrawY-background_1_y][DrawX-background_1_x];
            end
        else 
            begin
               background_1_on = 4'd0;   
            end   
    end
    */

    //-----------------------------------------Draw Ship --------------------------------------------------//
    logic [3:0] Ship_on;     
    int Ship_DistX, Ship_DistY, Size;
    assign Ship_DistX = DrawX - ShipX;
    assign Ship_DistY = DrawY - ShipY;
    assign Size = 15; //This size will be used for enemies too
      
    always_comb
    begin:Ship_on_proc
        if (player_alive == 1 && lost_game == 0  && level == 1 && (ship == 1) && (Ship_DistX<=Size) && (Ship_DistX>=0) && (Ship_DistY<=Size) && (Ship_DistY>=0) ) 
            Ship_on = player[Ship_DistY][Ship_DistX];
        else 
            Ship_on = 4'd0;
    end 
 
    //---------------------------------------- Draw Missile ----------------------------------------------// 
    logic [3:0] missile_on;
    int missile1_DistX, missile1_DistY;
    assign missile1_DistX = DrawX - missile1_x;
    assign missile1_DistY = DrawY - missile1_y;
     /*int missile2_DistX, missile2_DistY;
     assign missile2_DistX = DrawX - missile2_X;
    assign missile2_DistY = DrawY - missile2_Y;
     */
    always_comb
    begin:Missile1_on_proc
        if (lost_game == 0 && level == 1 && (missile1_DistX<=Size) && (missile1_DistX>=0) && (missile1_DistY<=Size) && (missile1_DistY>=0) && missile )
             missile_on = player_missile[missile1_DistY][missile1_DistX];
        /*else if ( (missile2_DistX<=Size) && (missile2_DistX>=0) && (missile2_DistY<=Size) && (missile2_DistY>=0))// && missile2 )
            missile_on = Missile[missile2_DistY][missile2_DistX];*/
        else 
            missile_on = 4'b0;
     end
     

    //---------------------------------------- Draw Enemy Beams/Missiles --------------------------------------------// 

    logic [3:0] beam_on;     
    int beam_DistX, beam_DistY;
    assign beam_DistX = DrawX - beam_X;
    assign beam_DistY = DrawY - beam_Y;
      
    always_comb
    begin:beam_on_proc
        if (lost_game == 0  && level == 1 && (beam_enable == 1) && (beam_DistX<=Size) && (beam_DistX>=0) && (beam_DistY<=Size) && (beam_DistY>=0) ) 
            beam_on = player_missile[beam_DistY][beam_DistX];
        else 
            beam_on = 4'd0;
    end 
    //-----------------------------------------Draw Explosions --------------------------------------------------//
    
    logic [3:0] explosion_0_on;     
    int explosion_0_DistX, explosion_0_DistY;
    assign explosion_0_DistX = DrawX - ShipX;
    assign explosion_0_DistY = DrawY - ShipY;
    int explosion_Size = 31;
   
      
    always_comb
    begin:explosion_0_on_proc
        if (explosion0 == 1 && lost_game == 0  && level == 1 && (explosion_0_DistX<=explosion_Size) && (explosion_0_DistX>=0) && (explosion_0_DistY<=explosion_Size) && (explosion_0_DistY>=0) ) 
            explosion_0_on = explosion_0[explosion_0_DistY][explosion_0_DistX];
        else 
            explosion_0_on = 4'd0;
    end 


    logic [3:0] explosion_1_on;     
    int explosion_1_DistX, explosion_1_DistY;
    assign explosion_1_DistX = DrawX - ShipX;
    assign explosion_1_DistY = DrawY - ShipY;
   
      
    always_comb
    begin:explosion_1_on_proc
        if (explosion1 == 1 && lost_game == 0  && level == 1 && (explosion_1_DistX<=explosion_Size) && (explosion_1_DistX>=0) && (explosion_1_DistY<=explosion_Size) && (explosion_1_DistY>=0) ) 
            explosion_1_on = explosion_1[explosion_1_DistY][explosion_1_DistX];
        else 
            explosion_1_on = 4'd0;
    end 
	 

    logic [3:0] explosion_2_on;     
    int explosion_2_DistX, explosion_2_DistY;
    assign explosion_2_DistX = DrawX - ShipX;
    assign explosion_2_DistY = DrawY - ShipY;
   
      
    always_comb
    begin:explosion_2_on_proc
        if (explosion2 == 1 && lost_game == 0  && level == 1 && (explosion_2_DistX<=explosion_Size) && (explosion_2_DistX>=0) && (explosion_2_DistY<=explosion_Size) && (explosion_2_DistY>=0) ) 
            explosion_2_on = explosion_2[explosion_2_DistY][explosion_2_DistX];
        else 
            explosion_2_on = 4'd0;
    end 

    logic [3:0] explosion_3_on;     
    int explosion_3_DistX, explosion_3_DistY;
    assign explosion_3_DistX = DrawX - ShipX;
    assign explosion_3_DistY = DrawY - ShipY;
   
    always_comb
    begin:explosion_3_on_proc
        if (explosion3 == 1 && lost_game == 0  && level == 1 && (explosion_3_DistX<=explosion_Size) && (explosion_3_DistX>=0) && (explosion_3_DistY<=explosion_Size) && (explosion_3_DistY>=0) ) 
            explosion_3_on = explosion_3[explosion_3_DistY][explosion_3_DistX];
        else 
            explosion_3_on = 4'd0;
    end 


    //-----------------------------------------Draw Enemy --------------------------------------------------//
    
    // Select enemy to draw using input enemy_type
    logic [0:15][0:15][0:3] Enemy_to_draw, Enemy_to_draw2, Enemy_to_draw3;
    always_comb
    begin: Select_Enemy
        if (enemy_type == 4'd1)
            Enemy_to_draw = enemy_0_0;
        else if (enemy_type == 4'd2)
            Enemy_to_draw = enemy_0_1;
        else if (enemy_type == 4'd3)
            Enemy_to_draw = enemy_1_0;
        else if (enemy_type == 4'd4)
            Enemy_to_draw = enemy_1_1;
        else if (enemy_type == 4'd5)
            Enemy_to_draw = enemy_2_0;
        else if (enemy_type == 4'd6)
            Enemy_to_draw = enemy_2_1;
        else if (enemy_type == 4'd7)
            Enemy_to_draw = enemy_3_0;
        else if (enemy_type == 4'd8)
            Enemy_to_draw = enemy_3_1;
        else if (enemy_type == 4'd9)
            Enemy_to_draw = enemy_8_0;
        else if (enemy_type == 4'd10)
            Enemy_to_draw = enemy_8_1;
        else //If enemy_type = 0, enemies are disabled
            Enemy_to_draw = enemy_0_0; 
    end

    always_comb
    begin: Select_Enemy2
        if (enemy_type2 == 4'd1)
            Enemy_to_draw2 = enemy_0_0;
        else if (enemy_type2 == 4'd2)
            Enemy_to_draw2 = enemy_0_1;
        else if (enemy_type2 == 4'd3)
            Enemy_to_draw2 = enemy_1_0;
        else if (enemy_type2 == 4'd4)
            Enemy_to_draw2 = enemy_1_1;
        else if (enemy_type2 == 4'd5)
            Enemy_to_draw2 = enemy_2_0;
        else if (enemy_type2 == 4'd6)
            Enemy_to_draw2 = enemy_2_1;
        else if (enemy_type2 == 4'd7)
            Enemy_to_draw2 = enemy_3_0;
        else if (enemy_type2 == 4'd8)
            Enemy_to_draw2 = enemy_3_1;
        else if (enemy_type2 == 4'd9)
            Enemy_to_draw2 = enemy_8_0;
        else if (enemy_type2 == 4'd10)
            Enemy_to_draw2 = enemy_8_1;
        else //If enemy_type = 0, enemies are disabled
            Enemy_to_draw2 = enemy_0_0; 
    end

    always_comb
    begin: Select_Enemy3
        if (enemy_type3 == 4'd1)
            Enemy_to_draw3 = enemy_0_0;
        else if (enemy_type3 == 4'd2)
            Enemy_to_draw3 = enemy_0_1;
        else if (enemy_type3 == 4'd3)
            Enemy_to_draw3 = enemy_1_0;
        else if (enemy_type3 == 4'd4)
            Enemy_to_draw3 = enemy_1_1;
        else if (enemy_type3 == 4'd5)
            Enemy_to_draw3 = enemy_2_0;
        else if (enemy_type3 == 4'd6)
            Enemy_to_draw3 = enemy_2_1;
        else if (enemy_type3 == 4'd7)
            Enemy_to_draw3 = enemy_3_0;
        else if (enemy_type3 == 4'd8)
            Enemy_to_draw3 = enemy_3_1;
        else if (enemy_type3 == 4'd9)
            Enemy_to_draw3 = enemy_8_0;
        else if (enemy_type3 == 4'd10)
            Enemy_to_draw3 = enemy_8_1;
        else //If enemy_type = 0, enemies are disabled
            Enemy_to_draw3 = enemy_0_0; 
    end

    //------------- Specify 8 x 3 enemy coordinations for 24 enemies 

    // At location 0
    logic [3:0] Enemy_at_0_on;
    logic [9:0] Enemy_at_0_x;
    assign Enemy_at_0_x = enemy_posX[0]; 
    logic[9:0] Enemy_at_0_y;
    assign Enemy_at_0_y = enemy_posY[0];

    // At location 1
    logic [3:0] Enemy_at_1_on;
    logic[9:0] Enemy_at_1_x;
    assign Enemy_at_1_x = enemy_posX[1]; 
    logic[9:0] Enemy_at_1_y;
    assign Enemy_at_1_y = enemy_posY[1];

    // At location 2
    logic [3:0] Enemy_at_2_on;
    logic[9:0] Enemy_at_2_x;
    assign Enemy_at_2_x = enemy_posX[2]; 
    logic[9:0] Enemy_at_2_y;
    assign Enemy_at_2_y = enemy_posY[2];

    // At location 3
    logic [3:0] Enemy_at_3_on;
    logic[9:0] Enemy_at_3_x;
    assign Enemy_at_3_x = enemy_posX[3]; 
    logic[9:0] Enemy_at_3_y;
    assign Enemy_at_3_y = enemy_posY[3];

    // At location 4
    logic [3:0] Enemy_at_4_on;
    logic[9:0] Enemy_at_4_x;
    assign Enemy_at_4_x = enemy_posX[4]; 
    logic[9:0] Enemy_at_4_y;
    assign Enemy_at_4_y = enemy_posY[4];

    // At location 5
    logic [3:0] Enemy_at_5_on;
    logic[9:0] Enemy_at_5_x;
    assign Enemy_at_5_x = enemy_posX[5]; 
    logic[9:0] Enemy_at_5_y;
    assign Enemy_at_5_y = enemy_posY[5];

    // At location 6
    logic [3:0] Enemy_at_6_on;
    logic[9:0] Enemy_at_6_x;
    assign Enemy_at_6_x = enemy_posX[6]; 
    logic[9:0] Enemy_at_6_y;
    assign Enemy_at_6_y = enemy_posY[6];

    // At location 7
    logic [3:0] Enemy_at_7_on;
    logic[9:0] Enemy_at_7_x;
    assign Enemy_at_7_x = enemy_posX[7]; 
    logic[9:0] Enemy_at_7_y;
    assign Enemy_at_7_y = enemy_posY[7];

    // At location 8
    logic [3:0] Enemy_at_8_on;
    logic[9:0] Enemy_at_8_x;
    assign Enemy_at_8_x = enemy_posX[8]; 
    logic[9:0] Enemy_at_8_y;
    assign Enemy_at_8_y = enemy_posY[8];

    // At location 9
    logic [3:0] Enemy_at_9_on;
    logic[9:0] Enemy_at_9_x;
    assign Enemy_at_9_x = enemy_posX[9];
    logic[9:0] Enemy_at_9_y;
    assign Enemy_at_9_y = enemy_posY[9];

    // At location 10
    logic [3:0] Enemy_at_10_on;
    logic[9:0] Enemy_at_10_x;
    assign Enemy_at_10_x = enemy_posX[10]; 
    logic[9:0] Enemy_at_10_y;
    assign Enemy_at_10_y = enemy_posY[10];

    // At location 11
    logic [3:0] Enemy_at_11_on;
    logic[9:0] Enemy_at_11_x;
    assign Enemy_at_11_x = enemy_posX[11]; 
    logic[9:0] Enemy_at_11_y;
    assign Enemy_at_11_y = enemy_posY[11];

    // At location 12
    logic [3:0] Enemy_at_12_on;
    logic[9:0] Enemy_at_12_x;
    assign Enemy_at_12_x = enemy_posX[12]; 
    logic[9:0] Enemy_at_12_y;
    assign Enemy_at_12_y = enemy_posY[12];

    // At location 13
    logic [3:0] Enemy_at_13_on;
    logic[9:0] Enemy_at_13_x;
    assign Enemy_at_13_x = enemy_posX[13]; 
    logic[9:0] Enemy_at_13_y;
    assign Enemy_at_13_y = enemy_posY[13];

    // At location 14
    logic [3:0] Enemy_at_14_on;
    logic[9:0] Enemy_at_14_x;
    assign Enemy_at_14_x = enemy_posX[14]; 
    logic[9:0] Enemy_at_14_y;
    assign Enemy_at_14_y = enemy_posY[14];

    // At location 15
    logic [3:0] Enemy_at_15_on;
    logic[9:0] Enemy_at_15_x;
    assign Enemy_at_15_x = enemy_posX[15]; 
    logic[9:0] Enemy_at_15_y;
    assign Enemy_at_15_y = enemy_posY[15];

    // At location 16
    logic [3:0] Enemy_at_16_on;
    logic[9:0] Enemy_at_16_x;
    assign Enemy_at_16_x = enemy_posX[16]; 
    logic[9:0] Enemy_at_16_y;
    assign Enemy_at_16_y = enemy_posY[16];

    // At location 17
    logic [3:0] Enemy_at_17_on;
    logic[9:0] Enemy_at_17_x;
    assign Enemy_at_17_x = enemy_posX[17]; 
    logic[9:0] Enemy_at_17_y;
    assign Enemy_at_17_y = enemy_posY[17];

    // At location 18
    logic [3:0] Enemy_at_18_on;
    logic[9:0] Enemy_at_18_x;
    assign Enemy_at_18_x = enemy_posX[18]; 
    logic[9:0] Enemy_at_18_y;
    assign Enemy_at_18_y = enemy_posY[18];

    // At location 19
    logic [3:0] Enemy_at_19_on;
    logic[9:0] Enemy_at_19_x;
    assign Enemy_at_19_x = enemy_posX[19]; 
    logic[9:0] Enemy_at_19_y;
    assign Enemy_at_19_y = enemy_posY[19];

    // At location 20
    logic [3:0] Enemy_at_20_on;
    logic[9:0] Enemy_at_20_x;
    assign Enemy_at_20_x = enemy_posX[20]; 
    logic[9:0] Enemy_at_20_y;
    assign Enemy_at_20_y = enemy_posY[20];

    // At location 21
    logic [3:0] Enemy_at_21_on;
    logic[9:0] Enemy_at_21_x;
    assign Enemy_at_21_x = enemy_posX[21]; 
    logic[9:0] Enemy_at_21_y;
    assign Enemy_at_21_y = enemy_posY[21];

    // At location 22
    logic [3:0] Enemy_at_22_on;
    logic[9:0] Enemy_at_22_x;
    assign Enemy_at_22_x = enemy_posX[22]; 
    logic[9:0] Enemy_at_22_y;
    assign Enemy_at_22_y = enemy_posY[22];

    // At location 23
    logic [3:0] Enemy_at_23_on;
    logic[9:0] Enemy_at_23_x;
    assign Enemy_at_23_x = enemy_posX[23]; 
    logic[9:0] Enemy_at_23_y;
    assign Enemy_at_23_y = enemy_posY[23];


    //---------------------Draw the 24 Enemies
    
    //Enemy at 0
    always_comb
    begin: enemy_at_0
        
        if (enemy_on_sig_0 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_0_x) && (DrawX <= Enemy_at_0_x + Size) 
            && (DrawY >= Enemy_at_0_y) &&(DrawY <= Enemy_at_0_y + Size)))
            begin
                Enemy_at_0_on = Enemy_to_draw3[DrawY-Enemy_at_0_y][DrawX-Enemy_at_0_x];
            end
        else 
            begin
                Enemy_at_0_on = 4'd0;   
            end   
    end

    //Enemy at 1
    always_comb
    begin: enemy_at_1
        
        if (enemy_on_sig_1 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_1_x) && (DrawX <= Enemy_at_1_x + Size) 
            && (DrawY >= Enemy_at_1_y) &&(DrawY <= Enemy_at_1_y + Size)))
            begin
                Enemy_at_1_on = Enemy_to_draw2[DrawY-Enemy_at_1_y][DrawX-Enemy_at_1_x];
            end
        else 
            begin
                Enemy_at_1_on = 4'd0;   
            end   
    end

    //Enemy at 2
    always_comb
    begin: enemy_at_2
        
        if (enemy_on_sig_2 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_2_x) && (DrawX <= Enemy_at_2_x + Size) 
            && (DrawY >= Enemy_at_2_y) &&(DrawY <= Enemy_at_2_y + Size)))
            begin
                Enemy_at_2_on = Enemy_to_draw2[DrawY-Enemy_at_2_y][DrawX-Enemy_at_2_x];
            end
        else 
            begin
                Enemy_at_2_on = 4'd0;   
            end   
    end

    //Enemy at 3
    always_comb
    begin: enemy_at_3
        
        if (enemy_on_sig_3 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_3_x) && (DrawX <= Enemy_at_3_x + Size) 
            && (DrawY >= Enemy_at_3_y) &&(DrawY <= Enemy_at_3_y + Size)))
            begin
                Enemy_at_3_on = Enemy_to_draw2[DrawY-Enemy_at_3_y][DrawX-Enemy_at_3_x];
            end
        else 
            begin
                Enemy_at_3_on = 4'd0;   
            end   
    end

    //Enemy at 4
    always_comb
    begin: enemy_at_4
        
        if (enemy_on_sig_4 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_4_x) && (DrawX <= Enemy_at_4_x + Size) 
            && (DrawY >= Enemy_at_4_y) &&(DrawY <= Enemy_at_4_y + Size)))
            begin
                Enemy_at_4_on = Enemy_to_draw2[DrawY-Enemy_at_4_y][DrawX-Enemy_at_4_x];
            end
        else 
            begin
                Enemy_at_4_on = 4'd0;   
            end   
    end

    //Enemy at 5
    always_comb
    begin: enemy_at_5
        
        if (enemy_on_sig_5 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_5_x) && (DrawX <= Enemy_at_5_x + Size) 
            && (DrawY >= Enemy_at_5_y) &&(DrawY <= Enemy_at_5_y + Size)))
            begin
                Enemy_at_5_on = Enemy_to_draw2[DrawY-Enemy_at_5_y][DrawX-Enemy_at_5_x];
            end
        else 
            begin
                Enemy_at_5_on = 4'd0;   
            end   
    end

    //Enemy at 6
    always_comb
    begin: enemy_at_6
        
        if (enemy_on_sig_6 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_6_x) && (DrawX <= Enemy_at_6_x + Size) 
            && (DrawY >= Enemy_at_6_y) &&(DrawY <= Enemy_at_6_y + Size)))
            begin
                Enemy_at_6_on = Enemy_to_draw2[DrawY-Enemy_at_6_y][DrawX-Enemy_at_6_x];
            end
        else 
            begin
                Enemy_at_6_on = 4'd0;   
            end   
    end

    //Enemy at 7
    always_comb
    begin: enemy_at_7
        
        if (enemy_on_sig_7 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_7_x) && (DrawX <= Enemy_at_7_x + Size) 
            && (DrawY >= Enemy_at_7_y) &&(DrawY <= Enemy_at_7_y + Size)))
            begin
                Enemy_at_7_on = Enemy_to_draw3[DrawY-Enemy_at_7_y][DrawX-Enemy_at_7_x];
            end
        else 
            begin
                Enemy_at_7_on = 4'd0;   
            end   
    end

    //Enemy at 8
    always_comb
    begin: enemy_at_8
        
        if (enemy_on_sig_8 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_8_x) && (DrawX <= Enemy_at_8_x + Size) 
            && (DrawY >= Enemy_at_8_y) &&(DrawY <= Enemy_at_8_y + Size)))
            begin
                Enemy_at_8_on = Enemy_to_draw[DrawY-Enemy_at_8_y][DrawX-Enemy_at_8_x];
            end
        else 
            begin
                Enemy_at_8_on = 4'd0;   
            end   
    end

    //Enemy at 9
    always_comb
    begin: enemy_at_9
        
        if (enemy_on_sig_9 && lost_game == 0&& level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_9_x) && (DrawX <= Enemy_at_9_x + Size) 
            && (DrawY >= Enemy_at_9_y) &&(DrawY <= Enemy_at_9_y + Size)))
            begin
                Enemy_at_9_on = Enemy_to_draw[DrawY-Enemy_at_9_y][DrawX-Enemy_at_9_x];
            end
        else 
            begin
                Enemy_at_9_on = 4'd0;   
            end   
    end

    //Enemy at 10
    always_comb
    begin: enemy_at_10
        
        if (enemy_on_sig_10 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_10_x) && (DrawX <= Enemy_at_10_x + Size) 
            && (DrawY >= Enemy_at_10_y) &&(DrawY <= Enemy_at_10_y + Size)))
            begin
                Enemy_at_10_on = Enemy_to_draw[DrawY-Enemy_at_10_y][DrawX-Enemy_at_10_x];
            end
        else 
            begin
                Enemy_at_10_on = 4'd0;   
            end   
    end

    //Enemy at 11
    always_comb
    begin: enemy_at_11
        
        if (enemy_on_sig_11 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_11_x) && (DrawX <= Enemy_at_11_x + Size) 
            && (DrawY >= Enemy_at_11_y) &&(DrawY <= Enemy_at_11_y + Size)))
            begin
                Enemy_at_11_on = Enemy_to_draw[DrawY-Enemy_at_11_y][DrawX-Enemy_at_11_x];
            end
        else 
            begin
                Enemy_at_11_on = 4'd0;   
            end   
    end

    //Enemy at 12
    always_comb
    begin: enemy_at_12
        
        if (enemy_on_sig_12 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_12_x) && (DrawX <= Enemy_at_12_x + Size) 
            && (DrawY >= Enemy_at_12_y) &&(DrawY <= Enemy_at_12_y + Size)))
            begin
                Enemy_at_12_on = Enemy_to_draw[DrawY-Enemy_at_12_y][DrawX-Enemy_at_12_x];
            end
        else 
            begin
                Enemy_at_12_on = 4'd0;   
            end   
    end

    //Enemy at 13
    always_comb
    begin: enemy_at_13
        
        if (enemy_on_sig_13 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_13_x) && (DrawX <= Enemy_at_13_x + Size) 
            && (DrawY >= Enemy_at_13_y) &&(DrawY <= Enemy_at_13_y + Size)))
            begin
                Enemy_at_13_on = Enemy_to_draw[DrawY-Enemy_at_13_y][DrawX-Enemy_at_13_x];
            end
        else 
            begin
                Enemy_at_13_on = 4'd0;   
            end   
    end

    //Enemy at 14
    always_comb
    begin: enemy_at_14
        
        if (enemy_on_sig_14 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_14_x) && (DrawX <= Enemy_at_14_x + Size) 
            && (DrawY >= Enemy_at_14_y) &&(DrawY <= Enemy_at_14_y + Size)))
            begin
                Enemy_at_14_on = Enemy_to_draw[DrawY-Enemy_at_14_y][DrawX-Enemy_at_14_x];
            end
        else 
            begin
                Enemy_at_14_on = 4'd0;   
            end   
    end

    //Enemy at 15
    always_comb
    begin: enemy_at_15
        
        if (enemy_on_sig_15 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_15_x) && (DrawX <= Enemy_at_15_x + Size) 
            && (DrawY >= Enemy_at_15_y) &&(DrawY <= Enemy_at_15_y + Size)))
            begin
                Enemy_at_15_on = Enemy_to_draw[DrawY-Enemy_at_15_y][DrawX-Enemy_at_15_x];
            end
        else 
            begin
                Enemy_at_15_on = 4'd0;   
            end   
    end
    
    //Enemy at 16
    always_comb
    begin: enemy_at_16
        
        if (enemy_on_sig_16 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_16_x) && (DrawX <= Enemy_at_16_x + Size) 
            && (DrawY >= Enemy_at_16_y) &&(DrawY <= Enemy_at_16_y + Size)))
            begin
                Enemy_at_16_on = Enemy_to_draw[DrawY-Enemy_at_16_y][DrawX-Enemy_at_16_x];
            end
        else 
            begin
                Enemy_at_16_on = 4'd0;   
            end   
    end

    //Enemy at 17
    always_comb
    begin: enemy_at_17
        
        if (enemy_on_sig_17 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_17_x) && (DrawX <= Enemy_at_17_x + Size) 
            && (DrawY >= Enemy_at_17_y) &&(DrawY <= Enemy_at_17_y + Size)))
            begin
                Enemy_at_17_on = Enemy_to_draw[DrawY-Enemy_at_17_y][DrawX-Enemy_at_17_x];
            end
        else 
            begin
                Enemy_at_17_on = 4'd0;   
            end   
    end

    //Enemy at 18
    always_comb
    begin: enemy_at_18
        
        if (enemy_on_sig_18 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_18_x) && (DrawX <= Enemy_at_18_x + Size) 
            && (DrawY >= Enemy_at_18_y) &&(DrawY <= Enemy_at_18_y + Size)))
            begin
                Enemy_at_18_on = Enemy_to_draw[DrawY-Enemy_at_18_y][DrawX-Enemy_at_18_x];
            end
        else 
            begin
                Enemy_at_18_on = 4'd0;   
            end   
    end

    //Enemy at 19
    always_comb
    begin: enemy_at_19
        
        if (enemy_on_sig_19 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_19_x) && (DrawX <= Enemy_at_19_x + Size) 
            && (DrawY >= Enemy_at_19_y) &&(DrawY <= Enemy_at_19_y + Size)))
            begin
                Enemy_at_19_on = Enemy_to_draw[DrawY-Enemy_at_19_y][DrawX-Enemy_at_19_x];
            end
        else 
            begin
                Enemy_at_19_on = 4'd0;   
            end   
    end

    //Enemy at 20
    always_comb
    begin: enemy_at_20
        
        if (enemy_on_sig_20 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_20_x) && (DrawX <= Enemy_at_20_x + Size) 
            && (DrawY >= Enemy_at_20_y) &&(DrawY <= Enemy_at_20_y + Size)))
            begin
                Enemy_at_20_on = Enemy_to_draw[DrawY-Enemy_at_20_y][DrawX-Enemy_at_20_x];
            end
        else 
            begin
                Enemy_at_20_on = 4'd0;   
            end   
    end

    //Enemy at 21
    always_comb
    begin: enemy_at_21
        
        if (enemy_on_sig_21 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_21_x) && (DrawX <= Enemy_at_21_x + Size) 
            && (DrawY >= Enemy_at_21_y) &&(DrawY <= Enemy_at_21_y + Size)))
            begin
                Enemy_at_21_on = Enemy_to_draw[DrawY-Enemy_at_21_y][DrawX-Enemy_at_21_x];
            end
        else 
            begin
                Enemy_at_21_on = 4'd0;   
            end   
    end

    //Enemy at 22
    always_comb
    begin: enemy_at_22
        
        if (enemy_on_sig_22 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_22_x) && (DrawX <= Enemy_at_22_x + Size) 
            && (DrawY >= Enemy_at_22_y) &&(DrawY <= Enemy_at_22_y + Size)))
            begin
                Enemy_at_22_on = Enemy_to_draw[DrawY-Enemy_at_22_y][DrawX-Enemy_at_22_x];
            end
        else 
            begin
                Enemy_at_22_on = 4'd0;   
            end   
    end

    //Enemy at 23
    always_comb
    begin: enemy_at_23
        
        if (enemy_on_sig_23 && lost_game == 0 && level == 1 && enemy_type != 4'd0 && ((DrawX >= Enemy_at_23_x) && (DrawX <= Enemy_at_23_x + Size) 
            && (DrawY >= Enemy_at_23_y) &&(DrawY <= Enemy_at_23_y + Size)))
            begin
                Enemy_at_23_on = Enemy_to_draw[DrawY-Enemy_at_23_y][DrawX-Enemy_at_23_x];
            end
        else 
            begin
                Enemy_at_23_on = 4'd0;   
            end   
    end
     
    /************************************************************************************************************/              
    /**************************************Assess the On Signals and Map them to color***************************/
    
    //logic collision_detect;
    logic [3:0] color_key;
    
    always_comb
    begin:color_key_assignment
            
            if (DrawX > 223 || DrawY > 287)
                color_key = 4'd14;

            else if(Ship_on != 4'd0)
                color_key = Ship_on;

            else if (missile_on != 4'd0)
                color_key = missile_on;

            else if (beam_on != 4'd0)
                color_key = beam_on;

            else if (explosion_0_on != 4'd0)
                color_key = explosion_0_on;

            else if (explosion_1_on != 4'd0)
                color_key = explosion_1_on;

            else if (explosion_2_on != 4'd0)
                color_key = explosion_2_on;

            else if (explosion_3_on != 4'd0)
                color_key = explosion_3_on;
            
            else if(Enemy_at_0_on != 4'd0)
                color_key = Enemy_at_0_on;
            
            else if(Enemy_at_1_on != 4'd0)
                color_key = Enemy_at_1_on;
            
            else if(Enemy_at_2_on != 4'd0)
                color_key = Enemy_at_2_on;
            
            else if(Enemy_at_3_on != 4'd0)
                color_key = Enemy_at_3_on;
            
            else if(Enemy_at_4_on != 4'd0)
                color_key = Enemy_at_4_on;
            
            else if(Enemy_at_5_on != 4'd0)
                color_key = Enemy_at_5_on;
            
            else if(Enemy_at_6_on != 4'd0)
                color_key = Enemy_at_6_on;
            
            else if(Enemy_at_7_on != 4'd0)
                color_key = Enemy_at_7_on;
            
            else if(Enemy_at_8_on != 4'd0)
                color_key = Enemy_at_8_on;
            
            else if(Enemy_at_9_on != 4'd0)
                color_key = Enemy_at_9_on;
            
            else if(Enemy_at_10_on != 4'd0)
                color_key = Enemy_at_10_on;
            
            else if(Enemy_at_11_on != 4'd0)
                color_key = Enemy_at_11_on;
            
            else if(Enemy_at_12_on != 4'd0)
                color_key = Enemy_at_12_on;
            
            else if(Enemy_at_13_on != 4'd0)
                color_key = Enemy_at_13_on;
            
            else if(Enemy_at_14_on != 4'd0)
                color_key = Enemy_at_14_on;
            
            else if(Enemy_at_15_on != 4'd0)
                color_key = Enemy_at_15_on;

            else if(Enemy_at_16_on != 4'd0)
                color_key = Enemy_at_16_on;
            
            else if(Enemy_at_17_on != 4'd0)
                color_key = Enemy_at_17_on;

            else if(Enemy_at_18_on != 4'd0)
                color_key = Enemy_at_18_on;

            else if(Enemy_at_19_on != 4'd0)
                color_key = Enemy_at_19_on;

            else if(Enemy_at_20_on != 4'd0)
                color_key = Enemy_at_20_on;

            else if(Enemy_at_21_on != 4'd0)
                color_key = Enemy_at_21_on;

            else if(Enemy_at_22_on != 4'd0)
                color_key = Enemy_at_22_on; 
                        
            else if(Enemy_at_23_on != 4'd0)
                color_key = Enemy_at_23_on;

            else if(Logo_Gameover_on != 4'd0)
                color_key = Logo_Gameover_on;

            //else if(Logo_Retry_on != 4'd0)
             //   color_key = Logo_Retry_on;

            else if(Logo_Galaxian_on != 4'd0)
                color_key = Logo_Galaxian_on;

            else if(Logo_Credits_on != 4'd0)
                color_key = Logo_Credits_on;
            else
                color_key = 4'd0;       

    end 

    //____________________________Color Mapper using the color_key______________________________//
    always_comb
    begin: RGB_display
        case(color_key)

            4'd0 : //0x000000 
                begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00; 
                end  
            4'd1 : //0x0D35DA
                begin
                    Red = 8'h0D;
                    Green = 8'h35;
                    Blue = 8'hDA;
                end
            4'd2 : //0x116BDB
                begin
                    Red = 8'h11;
                    Green = 8'h6B;
                    Blue = 8'hDB;
                end
            4'd3 : //0x2BFBDE
                begin
                    Red = 8'h2B;
                    Green = 8'hFB;
                    Blue = 8'hDE;
                end
            4'd4 : //0x1EB9DC
                begin
                    Red = 8'h1E;
                    Green = 8'hB9;
                    Blue = 8'hDC;
                end
            4'd5 : //0xDEDEDE 
                begin
                    Red = 8'hDE;
                    Green = 8'hDE;
                    Blue = 8'hDE;
                end
            4'd6 : //0xFC291C
                begin
                    Red = 8'hFC;
                    Green = 8'h29;
                    Blue = 8'h1C;
                end
            4'd7 : //0x2AF72D
                begin
                    Red = 8'h2A;
                    Green = 8'hF7;
                    Blue = 8'h2D;
                end
            4'd8 : //0xFC44DC
                begin
                    Red = 8'hFC;
                    Green = 8'h44;
                    Blue = 8'hDC;
                end
            4'd9 : //0xFDB72B
                begin
                    Red = 8'hFD;
                    Green = 8'hB7;
                    Blue = 8'h2B; 
                end
            4'd10 : //0xDB4819
                begin
                    Red = 8'hDB;
                    Green = 8'h48;
                    Blue = 8'h19; 
                end
            4'd11 : //0xFEF937
                begin
                    Red = 8'hFE;
                    Green = 8'hF9;
                    Blue = 8'h37; 
                end
            4'd12 : //0x963ADB
                begin
                    Red = 8'h96;
                    Green = 8'h3A;
                    Blue = 8'hDB;
                end
            4'd13 : //0x169696
                begin
                    Red = 8'h16;
                    Green = 8'h96;
                    Blue = 8'h96;
                end  
            4'd14 : //1D1D1D            
                begin
                    Red = 8'h1D;
                    Green = 8'h1D;
                    Blue = 8'h1D;
                end  
            default : //0x0000000
                begin
                    Red = 8'h00;
                    Green = 8'h00;
                    Blue = 8'h00;            
                end
        endcase 
    end
     
endmodule
