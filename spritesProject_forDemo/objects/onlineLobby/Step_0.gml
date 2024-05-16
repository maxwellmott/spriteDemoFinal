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
}
#endregion

#region LOBBY STEP
if (inLobby) {
	// if labelSprite has not yet been set, set it according to player's clientScope
	if (labelSprite == -1) {
		if	player.clientScope == CLIENT_SCOPES.RANKED		labelSprite = spr_rankedMatchLabel;
		if	player.clientScope == CLIENT_SCOPES.PRIVATE		labelSprite = spr_privateRoomLabel;
	}
	
	if (player.clientType == CLIENT_TYPES.HOST)
	&& !(instance_exists(onlineEnemy)) {
		if !(global.gameTime mod 120) send_guest_check();
	}
	
	if (player.clientScope == CLIENT_SCOPES.PRIVATE) {
		if (instance_exists(onlineEnemy)) 
		&& !(testActive) {
			connection_test_begin();	
			testActive = true;
		}
	}
}
#endregion