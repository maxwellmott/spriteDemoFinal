/// @desc

switch (state) {
	case transitionStates.fadingIn:
		if (alpha < 1.0)	{
			alpha += 0.05;
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
			#region ROOM BUILDER
			switch(room) {
				case rm_titleScreen:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, titleScreen);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
			/*
				case rm_mainMenu:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, mainMenu);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				*/
				case rm_battleScene:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, spar);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_characterEditor:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, characterEditor);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_teambuilder:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, teambuilder);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_spellbookBuilder:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, spellBookBuilder);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_onlineLobby:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, onlineLobby);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_optionsMenu:
					global.overworld = false;
					create_once(0, 0, LAYER.meta, optionsMenu);
					create_once(0, 0, LAYER.ui, mouse);
					state = transitionStates.fadingOut;
				break;
				
				case rm_overworld:
					global.overworld = true;
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
			if (alpha > 0.0) {alpha -= 0.05;}
			else {
				instance_destroy(id);
			}
		}
	break;
}
