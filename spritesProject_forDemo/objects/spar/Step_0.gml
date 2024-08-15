/// @desc

if (instance_exists(sparEffectAlert)) {
	exit;	
}

if (onlineWaiting) {
	if !(global.gameTime mod 480)	request_turn_begin();
}

// check if sprites are done flashing
if (check_sprites_done_flashing()) {
	// check if hpmp bars are up to date
	if (spar_check_hpmp()) {
		// check if there is still a spell being processed
		if !(instance_exists(sparActionProcessor)) {
			// check if there is still a spell being animated
			if !(instance_exists(sparSpellFX)) {
				// check if there are any effect alerts waiting to be
				// announced and displayed
				if (ds_list_size(effectAlertList) > 0)  {
					create_once(0, 0, LAYER.meta, sparEffectAlert);
				}
			}
		}
	}
}

// spar phase switch statement
switch (sparPhase) {
	case sparPhases.height:
	
	break;
	
	case sparPhases.turnEnd:
		turnProcessCount = 0;
		processPhase = PROCESS_PHASES.SWAP;
		
		playerOne.ready = false;
		playerTwo.ready = false;
		
		spar_check_sneaking_deal_damage();
		spar_check_skydiving_deal_damage();		
		spar_check_effect_timers();
		spar_check_timed_blasts();
		
		sparPhase = sparPhases.turnBegin;

	break;
	
	case sparPhases.process:
	
		// reset all sprites' selection data
		with (sparAlly) {
			turnReady = false;
			readyDisplayBuilt = false;
			readyDisplay = "";
			selectedAction = -4;
			selectedTarget = -4;
		}
		
		with (sparEnemy) {
			turnReady = false;
			selectedAction = -4;
			selectedTarget = -4;
		}
		
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
					
					// check if sprites are done flashing
					if (check_sprites_done_flashing()) {
						// check if HPMP bars are up to date
						if (spar_check_hpmp()) {
							// check that there are no sparEffectAlerts
							if (ds_list_size(effectAlertList) == 0) {
								// if so, create the sparSwapProcessor
								create_once(0, 0, LAYER.meta, sparSwapProcessor);
							}
						}
						else {
							spar_correct_hpmp();	
						}
					}
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
					
					// check that sprites are done flashing
					if (check_sprites_done_flashing()) {
						// check that there are no effect alerts
						if (ds_list_size(effectAlertList) == 0) {
							// if so, create the sparRestProcessor
							create_once(0, 0, LAYER.meta, sparRestProcessor);
						}
					}
				}
				
				if !(instance_exists(sparRestProcessor))
				&& !(spar_check_hpmp()) {
					spar_correct_hpmp();
				}
				
				if !(instance_exists(sparRestProcessor))
				&& (spar_check_hpmp()) {
					processPhase = PROCESS_PHASES.DODGE;	
				}
			break;
			
			case PROCESS_PHASES.DODGE:
				// check if any sprites are dodging
				if (ds_grid_value_exists(turnGrid, selectionPhases.action, 0, selectionPhases.action, h, sparActions.dodge)) {
					// set these built_ins so that the gms2 animation works
					sprite_index = spr_sparDodge;
					image_speed = 1;
					
					// check that HPMP bars are up to date
					if (spar_check_hpmp()) {
						// check that no sprites are flashing
						if (check_sprites_done_flashing()) {
							// check that there are no sparEffectAlerts
							if (ds_list_size(effectAlertList) == 0) {
								// if so, create the sparDodgeAnnouncer
								create_once(0, 0, LAYER.meta, sparDodgeAnnouncer);
							}
						}
					}
				}
				else {
					if !(instance_exists(sparDodgeAnnouncer))	processPhase = PROCESS_PHASES.PRIORITY;	
				}
			break;
			
			case PROCESS_PHASES.PRIORITY:
				// check if all sprites are done flashing
				if (check_sprites_done_flashing()) {
					// check if HPMP bars are up to date
					if (spar_check_hpmp()) {
						// check that there are no effectAlerts
						if (ds_list_size(effectAlertList) == 0) {
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
												
												case arenas.skies:
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
						}
					}	else	{
						spar_correct_hpmp();
					}
				}
				
							
				
			break;
			
			case PROCESS_PHASES.ATTACK:
				// check that all sprites are done flashing
				if (check_sprites_done_flashing()) {
					// check that HPMP bars are up to date
					if (spar_check_hpmp()) {
						// check that there are no sparEffect alerts
						if (ds_list_size(effectAlertList) == 0) {
							if !(instance_exists(sparActionProcessor)) {
								// initialize a variable to store whether there are actions left to process
								var actionsRemaining = false;
								
								// use a repeat loop to check the whole grid for remaining actions
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
												
												case arenas.skies:
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
						}	
					}	else	{
						spar_correct_hpmp();
					}
				}
				
			break;
			
			case PROCESS_PHASES.END:
				// reset dodging var for all sprites
				with (sparAlly)		dodging = false;	dodgeCount = 0;
				with (sparEnemy)	dodging = false;	dodgeCount = 0;
			
				sparPhase = sparPhases.turnEnd;
			break;
		}

		
	break;
	
	#region SELECTION PHASE
		case sparPhases.select:
			sprite_index = spr_sparFlashingSliver;	
		
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
						selectionMsg = "What should " + playerOne.selectedAlly.name + " do this turn?";
						
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
						
						case sparActions.swap:
							selectionMsg = "Select the sprite with whom " + player.selectedAlly.name + " should swap";
							
							if (global.hoverSprite < 0)	potentialCost = 0;
						break;
					}
					
					if (a >= sparActions.height)	selectionMsg = "Select a sprite within range to target with a spell";
					
					// handle backspace input
					if (global.back) {
						potentialCost = 0;
						selectionPhase = selectionPhases.action;
					}
				break;
			}
				
			if (playerOne.ready) 
			&& !(onlineWaiting) {
				destroy_if_possible(sparReadyButton);
				
				if (instance_exists(onlineEnemy)) {
					onlineWaiting = true;
				}
				else {
					sparPhase = sparPhases.process;
				}
			}
			
			if (playerOne.ready)
			&& (onlineWaiting) {
				if !(global.gameTime mod 120)	request_turn_begin();	
			}
			
			if (playerOne.ready)
			&& (playerTwo.ready) {
				sparPhase = sparPhases.process;
			}
		break;
	#endregion
	
	#region TURN BEGIN PHASE
		case sparPhases.turnBegin:
			spar_check_hail_mary();
			spar_check_miasma();	
		
			sparPhase = sparPhases.select;
		break;
	#endregion
}

correct_uiAlpha();

// sparComplete logic
// check that all sprites are done flashing
if (check_sprites_done_flashing()) {
	// check that hpmp bars are up to date
	if (spar_check_hpmp()) {
		// check that there are no spar effect alerts
		if (ds_list_size(effectAlertList) == 0) {
			if (spar_check_complete()) {
				create_once(0, 0, LAYER.meta, winLoseDisplay);	
			}
		}
	}
}
		