/// @desc

// spar phase switch statement
switch (sparPhase) {
	case sparPhases.height:
	
	break;
	
	case sparPhases.turnEnd:
		turnProcessCount = 0;
		processPhase = PROCESS_PHASES.SWAP;
	break;
	
	case sparPhases.process:
		// sort turnGrid by agility
	
		// get current height of turnGrid
		var h = ds_grid_height(turnGrid);
		
		switch (processPhase) {
			
			case PROCESS_PHASES.PREPROCESS:
				all_sprites_get_luck_roll();
				processPhase = PROCESS_PHASES.SWAP;
			break;
			
			case PROCESS_PHASES.SWAP:
				if (ds_grid_value_exists(turnGrid, selectionPhases.action, 0, selectionPhases.action, h, sparActions.swap)) {
					// set these built-ins so that the gms2 animation works
					sprite_index = spr_sparSwapCloud;
					image_speed = 1;
					
					// if so, create the sparSwapProcessor
					create_once(0, 0, LAYER.meta, sparSwapProcessor);
				}
				
			break;
			
			case PROCESS_PHASES.REST:
				// check if any sprites are resting
				if (ds_grid_value_exists(turnGrid, selectionPhases.action, 0, selectionPhases.action, h, sparActions.rest)) {
					// set these built-ins so that the gms2 animation works
					sprite_index = spr_sparRestEye;
					image_speed = 1;
					
					// if so, create the sparRestProcessor
					create_once(0, 0, LAYER.meta, sparRestProcessor);
				}
				else {
					if !(instance_exists(sparRestProcessor))	processPhase = PROCESS_PHASES.DODGE;
				}
				
				if (instance_exists(sparRestProcessor)) {
					spar_correct_hpmp();
				}
			break;
			
			case PROCESS_PHASES.DODGE:
				// check if any sprites are dodging
				if (ds_grid_value_exists(turnGrid, selectionPhases.action, 0, selectionPhases.action, h, sparActions.dodge)) {
					// if so, create the sparDodgeAnnouncer
				}
			break;
			
			case PROCESS_PHASES.PRIORITY:
			break;
			
			case PROCESS_PHASES.ATTACK:
			break;
			
			case PROCESS_PHASES.END:
			break;
		}
		
	break;
	
	#region SELECTION PHASE
		case sparPhases.select:
			// use a switch statement to manage all selectionPhases
			switch(selectionPhase) {
				case selectionPhases.ally:
					// set selection message
					selectionMsg = "Select a sprite to command";
					
					// create ready button if all sprites are ready
					if check_all_allies_ready() {
						create_once(0, 0, LAYER.ui, sparReadyButton);	
					}
				break;
				
				case selectionPhases.action:
					// destroy readyButton if it exists
					destroy_if_possible(sparReadyButton);
					
					// check if spellMenu is present
					if (instance_exists(sparSpellMenu)) {
						// if so, destroy actionMenu
						destroy_if_possible(sparActionMenu);
						
						// set selectionMsg to blank
						selectionMsg = "";
					}
					else {
						// if not, create action menu
						create_once(x, y, LAYER.meta, sparActionMenu);
						
						// set selection message
						selectionMsg = "What should " + player.selectedAlly.name + " do this turn?";
					}
				break;
				
				case selectionPhases.target:
					var a = global.action;
					
					// switch statement to set selectionMsg text
					switch(a) {
						case sparActions.attack:
							selectionMsg = "Select a sprite within range to target with a basic attack";
						break;
						
						case sparActions.spell:
							selectionMsg = "Select a sprite within range to target with a spell";
						break;
						
						case sparActions.swap:
							selectionMsg = "Select the sprite with whom " + player.selectedAlly.name + " should swap";
						break;
					}
					
					// handle backspace input
					if (global.back) {
						selectionPhase = selectionPhases.action;
					}
				break;
			}
				
			if (player.ready) {
				destroy_if_possible(sparReadyButton);
				
				switch (global.sparType) {
					case sparTypes.inGame:
						sparPhase = sparPhases.process;
					break;
				}
				
				selectionMsg = "Waiting for the other player...";
			}
		break;
	#endregion
	
	#region TURN BEGIN PHASE
		case sparPhases.turnBegin:
			sparPhase = sparPhases.select;
		break;
	#endregion
}

// sparComplete logic
