/// @desc

// spar phase switch statement
switch (sparPhase) {
	case sparPhases.height:
	
	break;
	
	case sparPhases.turnEnd:
		turnProcessCount = 0;
		processPhase = PROCESS_PHASES.SWAP;		
		sparPhase = sparPhases.turnBegin;
	break;
	
	case sparPhases.process:
		// reset all sprites' turn selections
		with (sparAlly) {
			turnReady = false;
			readyDisplayBuilt = false;
			readyDisplay = "";
			selectedAction = -4;
			selectedTarget = -4;
		}
		
		player.ready = false;
	
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
				else {
					if !(instance_exists(sparSwapProcessor))	processPhase = PROCESS_PHASES.REST;	
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
					// set these built_ins so that the gms2 animation works
					sprite_index = spr_sparDodge;
					image_speed = 1;
					
					// if so, create the sparDodgeAnnouncer
					create_once(0, 0, LAYER.meta, sparDodgeAnnouncer);
				}
				else {
					if !(instance_exists(sparDodgeAnnouncer))	processPhase = PROCESS_PHASES.PRIORITY;	
				}
			break;
			
			case PROCESS_PHASES.PRIORITY:
				// check if the actionProcessor is already active
				if !(instance_exists(sparActionProcessor)) {
					// create a variable to store the highest stat found so far
					var highest = 0;
					
					// create a variable to store the nextSprite
					var nextSprite = -1;
					
					var i = 0;	repeat (ds_grid_height(turnGrid)) {
						// get the current spotnum
						var sn = turnGrid[# selectionPhases.ally, i];
						
						// get the current instance
						var inst = spriteList[| sn];
						
						// get action
						var a = turnGrid[# selectionPhases.action, i];
						
						// check if action is a spell
						if (action_check_spell(a)) {
							// get spellID
							var sid = action_get_spell_id(a);
							
							// create the priority list
							var pl = ds_list_create();
							decode_list(global.prioritySpellList, pl);
							
							// check if the spell id is on the priority list
							if (ds_list_find_index(pl, sid) >= 0) {
								// use a switch statement to check the proper stat
								// depending on the current arena
								switch (currentArena) {
									case arenas.ocean:
										if (inst.currentWater > highest) {
											highest		= inst.currentWater;
											nextSprite	= i;
										}
									break;
									
									case arenas.stratosphere:
										if (inst.currentStorm > highest) {
											highest		= inst.currentStorm;
											nextSprite	= i;
										}
									break;
									
									default:
										if (inst.currentAgility > highest) {
											highest		= inst.currentAgility;
											nextSprite	= i;
										}
									break;
								}								
							}
							
							ds_list_destroy(pl);
						}
						
						// increment i
						i++;
					}
					
					// check if nextSprite was ever set
					if (nextSprite >= 0) {
						// if so, set turnRow to equal nextSprite
						turnRow = nextSprite;
						
						// create the sparActionProcessor
						create_once(0, 0, LAYER.meta, sparActionProcessor);
						
					}	else	processPhase = PROCESS_PHASES.ATTACK;
				}
				
			break;
			
			case PROCESS_PHASES.ATTACK:
			
				spar_correct_hpmp();
			
				if !(instance_exists(sparActionProcessor)) {
					// initialize a variable to store whether there are actions left to process
					var actionsRemaining = false;
					
					var i = 0;	repeat (ds_grid_height(turnGrid)) {
						var a = turnGrid[# selectionPhases.action, i];
						
						// check if the action has been processed and reset to -1 already
						if (a >= 0) {
							// if so, set actionsRemaining to true and break the loop
							actionsRemaining = true;
							break;
						}
						
						// increment i
						i++;
					}
					
					// check if there are actionsRemaining
					if (actionsRemaining) {
						// create a variable to store the highest stat so far
						var highest = 0;
						
						// create a variable to store the turnRow of the next sprite who should act
						var nextSprite = -1;
						
						// use a repeat loop to find the fastest sprite who still needs
						// to take their turn
						var i = 0;	repeat (ds_grid_height(turnGrid)) {
							// check if the next action on the grid has been reset to -1 already
							var a = turnGrid[# selectionPhases.action, i];
							if (a >= 0) {
								// get current spotNum
								var sn = turnGrid[# selectionPhases.ally, i];
								
								// get the current instance
								var inst = spriteList[| sn];
								
								// use a switch statement to check the proper stat
								// depending on the arena
								switch (currentArena) {
									case arenas.ocean:
										if (inst.currentWater > highest) {
											highest		= inst.currentWater;
											nextSprite	= i;
										}
									break;
									
									case arenas.stratosphere:
										if (inst.currentStorm > highest) {
											highest		= inst.currentStorm;
											nextSprite	= i;
										}
									break;
									
									default:
										if (inst.currentAgility > highest) {
											highest		= inst.currentAgility;
											nextSprite	= i;
										}
									break;
								}		
							}
							
							// increment i
							i++;
						}
						
						// set turnRow to match the nextSprite variable
						turnRow = nextSprite;
						
						// create the sparActionProcessor
						create_once(0, 0, LAYER.meta, sparActionProcessor);
						
					}	else	processPhase = PROCESS_PHASES.END;
				
				}
				
			break;
			
			case PROCESS_PHASES.END:
				sparPhase = sparPhases.turnEnd;
			break;
		}

		
	break;
	
	#region SELECTION PHASE
		case sparPhases.select:
			// use a switch statement to manage all selectionPhases
			switch(selectionPhase) {
				case selectionPhases.ally:
					global.potentialMPCost = -1;
				
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
						global.potentialMPCost = -1;
						
						// if not, create action menu
						create_once(x, y, LAYER.meta, sparActionMenu);
						
						// set selection message
						selectionMsg = "What should " + player.selectedAlly.name + " do this turn?";
						
						if (smw != string_width(selectionMsg)) {
							smw = string_width(selectionMsg);	
						}
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
