//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  lab8 		( input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1, HEX2, HEX3, //HEX4, HEX5, HEX6, HEX7,
							  //output [8:0]  LEDG,
							  //output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA virtical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
							  inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
							  output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
							  output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
							  output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
							  output			 DRAM_CAS_N,			// SDRAM Column Address Strobe
							  output			 DRAM_CKE,				// SDRAM Clock Enable
							  output			 DRAM_WE_N,				// SDRAM Write Enable
							  output			 DRAM_CS_N,				// SDRAM Chip Select
							  output			 DRAM_CLK				// SDRAM Clock
											);
    
		//Sprite Logic
    logic [0:15][0:15][0:3] enemy_0_0;
	logic [0:15][0:15][0:3] enemy_0_1;
	logic [0:15][0:15][0:3] enemy_1_0;
	logic [0:15][0:15][0:3] enemy_1_1;
	logic [0:15][0:15][0:3] enemy_2_0;
	logic [0:15][0:15][0:3] enemy_2_1;
	logic [0:15][0:15][0:3] enemy_3_0;
	logic [0:15][0:15][0:3] enemy_3_1;
	logic [0:15][0:15][0:3] enemy_4_00;
	logic [0:15][0:15][0:3] enemy_5_00;
	logic [0:15][0:15][0:3] enemy_6_00;
	logic [0:15][0:15][0:3] enemy_7_00;
	logic [0:15][0:15][0:3] enemy_8_0;
	logic [0:15][0:15][0:3] enemy_8_1;
	logic [0:15][0:15][0:3] enemy_8_2;
	logic [0:15][0:15][0:3] enemy_9_00;
	logic [0:15][0:15][0:3] player;
	logic [0:15][0:15][0:3] player_missile;
	logic [0:43][0:143][0:3] Logo_Galaxian;
	logic [0:9][0:82][0:3] Logo_Gameover;
	logic [0:8][0:119][0:3] Logo_Credits;
	logic [0:8][0:136][0:3] Logo_Retry; 
	logic [0:31][0:31][0:3] explosion_0;
	logic [0:31][0:31][0:3] explosion_1;
	logic [0:31][0:31][0:3] explosion_2;
	logic [0:31][0:31][0:3] explosion_3; 


    logic Reset_h, vssig, Clk;
    logic [9:0] drawxsig, drawysig;
	logic [15:0] keycode;
    
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[0]);  // The push buttons are active low
	 
	 wire [1:0] hpi_addr;
	 wire [15:0] hpi_data_in, hpi_data_out;
	 wire hpi_r, hpi_w,hpi_cs;
	 assign vssig = VGA_VS;

	 //Ship and Enenmy wires
	 wire [9:0] ShipX, ShipY; 			//change back to wire for ship
	 wire [9:0] enemy_posX [0:23];
	 wire [9:0] enemy_posY [0:23];
	 wire [4:0] enemy_type, enemy_type2, enemy_type3;
	 wire present [0:23];
	 wire ship, level, lost_game;

	 wire hit, reset_hit;
	 wire missile;
	 wire [9:0] missile1_x, missile1_y; 
	 wire [8:0] hi_score, score;
	 wire [9:0]  beam_X, beam_Y;
     wire beam_enable;
     wire explosion0, explosion1, explosion2, explosion3, game_over, explode;
     wire clkdiv2;

	 hpi_io_intf hpi_io_inst(   .from_sw_address(hpi_addr),
										 .from_sw_data_in(hpi_data_in),
										 .from_sw_data_out(hpi_data_out),
										 .from_sw_r(hpi_r),
										 .from_sw_w(hpi_w),
										 .from_sw_cs(hpi_cs),
		 								 .OTG_DATA(OTG_DATA),    
										 .OTG_ADDR(OTG_ADDR),    
										 .OTG_RD_N(OTG_RD_N),    
										 .OTG_WR_N(OTG_WR_N),    
										 .OTG_CS_N(OTG_CS_N),    
										 .OTG_RST_N(OTG_RST_N),   
										 .OTG_INT(OTG_INT),
										 .Clk(Clk),
										 .Reset(Reset_h)
	 );
	 
	 //The connections for nios_system might be named different depending on how you set up Qsys
	 nios_system nios_system(
										 .clk_clk(Clk),         
										 .reset_reset_n(KEY[0]),   
										 .sdram_wire_addr(DRAM_ADDR), 
										 .sdram_wire_ba(DRAM_BA),   
										 .sdram_wire_cas_n(DRAM_CAS_N),
										 .sdram_wire_cke(DRAM_CKE),  
										 .sdram_wire_cs_n(DRAM_CS_N), 
										 .sdram_wire_dq(DRAM_DQ),   
										 .sdram_wire_dqm(DRAM_DQM),  
										 .sdram_wire_ras_n(DRAM_RAS_N),
										 .sdram_wire_we_n(DRAM_WE_N), 
										 .sdram_clk_clk(DRAM_CLK),
										 .keycode_export(keycode),  
										 .otg_hpi_address_export(hpi_addr),
										 .otg_hpi_data_in_port(hpi_data_in),
										 .otg_hpi_data_out_port(hpi_data_out),
										 .otg_hpi_cs_export(hpi_cs),
										 .otg_hpi_r_export(hpi_r),
										 .otg_hpi_w_export(hpi_w));
	
	//Fill in the connections for the rest of the modules 
    vga_controller vgasync_instance(
										.Clk(Clk),       // 50 MHz clock
                              .Reset(Reset_h),     // reset signal
										.hs(VGA_HS),        // Horizontal sync pulse.  Active low
								      .vs(VGA_VS),        // Vertical sync pulse.  Active low
										.pixel_clk(VGA_CLK), // 25 MHz pixel clock output
										.blank(VGA_BLANK_N),     // Blanking interval indicator.  Active low.
										.sync(VGA_SYNC_N),      // Composite Sync signal.  Active low.  We don't use it in this lab,
												             //   but the video DAC on the DE2 board requires an input for it.
										.DrawX(drawxsig),     // horizontal coordinate
								      .DrawY(drawysig));
										
	gamestate game_1(			   .Reset(Reset_h), 
										.frame_clk(vssig), 
										.*);
   
    color_mapper color_instance( 			.*,
											.Reset(Reset_h),
    										.DrawX(drawxsig),     // horizontal coordinate
											.DrawY(drawysig), 
											//.missile2(missile_2),
											//.missile2_X(Missile2_X), 
											//.missile2_Y(Missile2_Y),
											.Red(VGA_R),
											.Green(VGA_G),
											.Blue(VGA_B));
		
	ship player1(
										.Reset(Reset_h),
										.frame_clk(vssig),
										.keycode(keycode),
										.SHIPX(ShipX), 
										.SHIPY(ShipY),
										.ship(ship)//,
										//.collision(collision)
										);
	
	enemy enemy_instance(		.*,
										.Reset(Reset_h),
										.frame_clk(vssig));

	enemy_missile 	 enemy_missile_instance
						(				.*,
		 								.Reset(Reset_h),	
		 								.frame_clk(vssig)
		 							      );

	missile missile_instance( 			.*,
										.Reset(Reset_h),
										.frame_clk(vssig),
										.SHIPX(ShipX),
										.SHIPY(ShipY),
										.MISSILE1_X(missile1_x),
										.MISSILE1_Y(missile1_y),
										.missile_1(missile)
										);
	
	explosion explosion_instance(		.*,
		 								.Reset(Reset_h),
		 								.frame_clk(vssig)

								);
						
	sprite_table sprites_instance(		.*,
										.clk(vssig));

										//do two keycode stuff for ship and missile
										//make logic for gamestate connections and connect them
										//update colormapper

															  
	 HexDriver hex_inst_0 (keycode[3:0], HEX0);
	 HexDriver hex_inst_1 (keycode[7:4], HEX1);
	 HexDriver hex_inst_2 (keycode[11:8], HEX2);
	 HexDriver hex_inst_3 (keycode[15:12], HEX3);
endmodule
