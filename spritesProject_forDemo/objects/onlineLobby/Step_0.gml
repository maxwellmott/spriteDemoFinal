/// @description Insert description here
// You can write your code in this editor

#region MAIN MENU STEP
if !(inLobby) {
	if (global.click) 
	&& !(mmButtonPressed) {
		if (collision_rectangle(mmButton_bboxLeft, mmButtonOne_bboxTop, mmButton_bboxRight, mmButtonOne_bboxBottom, mouse, false, false)) {
			// change button frame
			mmButtonOneFrame = 1;
			
			// set mmSelectedFunction
			mmSelectedFunction = find_ranked_match_begin;
			
			// set alarm[0] (this alarm will reset button frame and run the selected function)
			alarm[0] = 24;
			
			// set mmButtonPressed to true
			mmButtonPressed = true;
		}
		
		if (collision_rectangle(mmButton_bboxLeft, mmButtonTwo_bboxTop, mmButton_bboxRight, mmButtonTwo_bboxBottom, mouse, false, false)) {
			// change button frame
			mmButtonTwoFrame = 1;
			
			// set mmSelectedFunction
			mmSelectedFunction = create_private_room_begin;
			
			// set alarm[0] (this alarm will reset button frame and run the selected function)
			alarm[0] = 24;
			
			// set mmButtonPressed to true
			mmButtonPressed = true;
		}
		
		if (collision_rectangle(mmButton_bboxLeft, mmButtonThree_bboxTop, mmButton_bboxRight, mmButtonThree_bboxBottom, mouse, false, false)) {
			// change button frame
			mmButtonThreeFrame = 1;
			
			// set mmSelectedFunction
			mmSelectedFunction = private_room_search_prompt;
			
			// set alarm[0] (this alarm will reset button frame and run the selected function)
			alarm[0] = 24;
			
			// set mmButtonPressed to true
			mmButtonPressed = true;
		}
	}
	
	// check if the back button is pressed
	if (global.back) {
		room_transition(player.x, player.y, player.facing, rm_overworld, bgm_springRelaxSunny);	
	}	
}
#endregion

#region LOBBY STEP
if (inLobby) {
	// check if labelSprite has not yet been set
	if (labelSprite == -1) {
		// set labelSprite according to player's online scope
		if	player.clientScope == CLIENT_SCOPES.RANKED		labelSprite = spr_rankedMatchLabel;
		if	player.clientScope == CLIENT_SCOPES.PRIVATE		labelSprite = spr_privateRoomLabel;
	}
	
	// check if client type is host and onlineEnemy has been created
	if (player.clientType == CLIENT_TYPES.HOST)
	&& !(instance_exists(onlineEnemy)) {
		// send guest check every four seconds
		if !(global.gameTime mod 240) send_guest_check();
	}
	
	// check if player's online scope is private
	if (player.clientScope == CLIENT_SCOPES.PRIVATE) {
		// check if onlineEnemy is present and test is not currently active
		if (instance_exists(onlineEnemy)) 
		&& !(testActive) {
			// perform connection test
			connection_test_begin();	
			testActive = true;
		}
	}
}
#endregion