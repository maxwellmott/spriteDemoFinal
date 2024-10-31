/// @desc

switch (state) {
	case transitionStates.fadingIn:
		if (alpha < 1.0)	{
			alpha += 0.05;
			
			if (newBGM != -1) 
			&& (audioManager.currentBGM != -1) {
				audioManager.bgmGain = 1.0 - alpha;
				audio_sound_gain(audioManager.currentBGM, audioManager.bgmGain, 0);
			}
		}
		
		else {
			state = transitionStates.transitioning;	
		}
	break;
	
	case transitionStates.transitioning:
		if (room != global.newRoom) {
			room_goto(global.newRoom);
		}
		
		if (room == global.newRoom) {
			audioManager.bgmGain = 1.0;
			audioManager.currentBGM = audio_play_sound(newBGM, 1, 0, audioManager.bgmGain);
			
			#region ROOM BUILDER
			switch(room) {
				case rm_titleScreen:
					create_once(0, 0, LAYER.meta, titleScreen);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;

				case rm_keyboardMenu:
					create_once(0, 0, LAYER.meta, keyboardMenu);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;

				case rm_battleScene:
					create_once(0, 0, LAYER.meta, spar);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_appearanceEditor:
					create_once(0, 0, LAYER.meta, characterCreator);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_teambuilder:
					create_once(0, 0, LAYER.meta, teambuilder);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_spellbookBuilder:
					create_once(0, 0, LAYER.meta, spellBookBuilder);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_onlineLobby:
					create_once(0, 0, LAYER.meta, onlineLobby);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_optionsMenu:
					create_once(0, 0, LAYER.meta, optionsMenu);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_overworld:
					player_change_room();
					create_once(0, 0, LAYER.meta, overworld);
					destroy_if_possible(mouse);
					state = transitionStates.fadingOut;
				break;
				
				default:
					state = transitionStates.fadingOut;
			}
			#endregion
		}
	break;
	
	case transitionStates.fadingOut:
		if (global.roomBuilt) {
			if (alpha > 0.0) {
				alpha -= 0.05;
			}
			else {
				instance_destroy(id);
			}
		}
	break;
}
