/// @desc

// if there are no menus open and the alert stack is not empty, create an alert
if (instance_exists(overworld)) 
&& !(instance_exists(menu)) {
	if (ds_list_size(alertStack) > 0) {
		if !(instance_exists(overworldAlert)) instance_create_depth(0, 0, get_layer_depth(LAYER.uiFront), overworldAlert);
	}
}

if global.roomBuilt gate_check_player();

if !(global.roomBuilt) {
	if spritesCreated
	&& sceneryCreated {
		global.roomBuilt = true;	
	}
}

if (player.sundown) && !(lightsOn) {
	with (lamppost) {frame = 1;}
}

if !(player.sundown) && (lightsOn) {
	with (lamppost) {frame = 0;}
}

// check if there are any menus open
if !(instance_exists(menu)) {
	// check if there are activeEmotes
	if (ds_grid_height(activeEmotes) > 0) {
		// use a repeat loop to create all active emotes
		var i = 0;	repeat (ds_grid_height(activeEmotes)) {
			var inst = create_once(0, 0, LAYER.meta, owEmote);
				i++;
		}
	}
	
	// check if dialogue is happening
	if (instance_exists(talkBubble)) {
		// check if there are any dialogueEmotes
		if (ds_grid_height(dialogueEmotes) > 0) {
			// use a repeat loop to check each dialogue emote
			var i = 0;	repeat (ds_grid_height(dialogueEmotes)) {
				// check if the talk bubble is on the page when the emotion should be displayed
				if (talkBubble.pageIndex == dialogueEmotes[# 0, i])
				&& (string_length(talkBubble.currentText) == dialogueEmotes[# 1, i]) {
					// set waitForInput accordingly
					talkBubble.waitForInput = dialogueEmotes[# 2, i];
					
					// get the height of activeEmotes
					var gh = ds_grid_height(activeEmotes);
					
					// add the emotion to the activeEmotes grid
					activeEmotes[# 0, gh] = dialogueEmotes[# 3, i];
					activeEmotes[# 1, gh] = global.speaker;
					
					// increment i
					i++;
				}
				
				// set removeCount
				var removeCount = i;
				
				// delete all processed rows
				ds_grid_remove_top_row(dialogueEmotes, removeCount);
			}
		}
	}
	
	// use a with statement to access all humans
	with (human) {
		// check if each human has emotes on their emote queue
		if (ds_list_size(emoteQueue) > 0) {
			// get the current height of the activeEmote grid
			var gh = ds_grid_height(overworld.activeEmotes);
			
			// set the id of the given emote
			overworld.activeEmotes[# 0, gh] = emoteQueue[| 0];
			
			// set the instance id of the emoting character
			overworld.activeEmotes[# 1, gh] = id;
			
			// delete this emote off the emote queue
			ds_list_delete(emoteQueue, 0);
		}
	}
	
	// use a with statement to access all overworld sprites
	with (owSprite) {
		//  check if each overworld sprite has emotes on their emote queue
		if (ds_list_size(emoteQueue) > 0) {
			// get the current height of the activeEmote grid
			var gh = ds_grid_height(overworld.activeEmotes);
			
			// set the id of the given emote
			overworld.activeEmotes[# 0, gh] = emoteQueue[| 0];
			
			// set the instance id of the emoting character
			overworld.activeEmotes[# 1, gh] = id;
			
			// delete this emote off the emote queue
			ds_list_delete(emoteQueue, 0);
		}
	}
}