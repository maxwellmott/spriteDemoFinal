/// @description Insert description here
// You can write your code in this editor


#region MAIN MENU DRAW



if !(inLobby) {
	
	// draw background
	draw_sprite(spr_onlineMainMenuBG, 0, 0, 0);
	
	// draw buttons
	draw_sprite(spr_onlineMainMenuButton, mmButtonOneFrame,		mmButtonX, mmButtonOneY);
	draw_sprite(spr_onlineMainMenuButton, mmButtonTwoFrame,		mmButtonX, mmButtonTwoY);
	draw_sprite(spr_onlineMainMenuButton, mmButtonThreeFrame,	mmButtonX, mmButtonThreeY);

	draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

	// draw button names
	if (mmButtonOneFrame)	draw_set_color(COL_WHITE);
	draw_text(mmButtonX, mmButtonOneY,		mmButtonOneName);
	draw_set_color(COL_BLACK);

	if (mmButtonTwoFrame)	draw_set_color(COL_WHITE);
	draw_text(mmButtonX, mmButtonTwoY,		mmButtonTwoName);
	draw_set_color(COL_BLACK);

	if (mmButtonThreeFrame)	draw_set_color(COL_WHITE);
	draw_text(mmButtonX, mmButtonThreeY,	mmButtonThreeName);
	draw_set_color(COL_BLACK);
}
#endregion


#region LOBBY DRAW
if (inLobby) {
	
	// draw background
	draw_sprite(spr_onlineLobbyBG, 0, 0, 0);
	
	// if labelSprite has been set, draw labelSprite
	if (labelSprite >= 0)	draw_sprite(labelSprite, 0, labelX, labelY);
	
	// draw nameSlotOne
	draw_sprite(spr_playerInfoDisplay, 0, nameSlotOneX, nameSlotOneY);
	
	// draw player info
	draw_text(nameSlotOneX, nameSlotOneY, player.name);
	
	// draw nameSlotTwo
	draw_sprite(spr_playerInfoDisplay, 0, nameSlotTwoX, nameSlotTwoY);
	
	// draw guest info
	if (instance_exists(onlineEnemy)) {
		draw_text(nameSlotTwoX, nameSlotTwoY, onlineEnemy.name);
	}
	
	// draw VS sign
	
	// set draw parameters
	draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
	
	// set font
	draw_set_font(lobbyFont);
	
	// if clientScope is ranked, draw rank info
	
	// if clientScope is private, draw room number
	if (player.clientScope == CLIENT_SCOPES.PRIVATE) {
		draw_sprite(spr_roomIDdisplay, 0, roomNumX, roomNumY);
		
		draw_text(roomStringX, roomStringY, string(player.roomID));
	}
}
#endregion