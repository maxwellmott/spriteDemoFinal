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
		if !(instance_exists(processorParent)) {
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
	else	{
		spar_correct_hpmp();	
	}
}

// spar phase switch statement
switch (sparPhase) {
	case SPAR_PHASES.HEIGHT:
	
	break;
	
	case SPAR_PHASES.TURN_END:
		// check if you've already reset everything and performed all the checks
		if (processPhase != PROCESS_PHASES.PREPROCESS) {
			turnProcessCount = 0;
			processPhase = PROCESS_PHASES.PREPROCESS;
		
			playerOne.ready = false;
			playerTwo.ready = false;
		
			// set synchronizedSoldiersActive to false for both players
			playerOne.synchronizedSoldiersActive = false; 
			playerTwo.synchronizedSoldiersActive = false; 
		
			spar_check_sneaking_deal_damage();
			spar_check_skydiving_deal_damage();		
			spar_check_black_hole_deal_damage();
			spar_check_ball_lightning_deal_damage();
			spar_check_effect_timers();
			spar_check_timed_blasts();
			
			// perform an ability check for turn end
			ability_check(ABILITY_TYPES.TURN_END);
		}
		
		// check that there are no alerts waiting to be displayed
		if (ds_list_size(effectAlertList) == 0) {
			// increment turnCounter
			turnCounter++;
			
			sparPhase = SPAR_PHASES.TURN_BEGIN;
		}
		
	break;
	
	case SPAR_PHASES.PROCESS:
		// destroy readyButton if possible
		destroy_if_possible(sparReadyButton);
	
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
				ability_check(ABILITY_TYPES.PROCESS_BEGIN);
				processPhase = PROCESS_PHASES.SWAP;
			break;
			
			case PROCESS_PHASES.SWAP:
				if (ds_grid_value_exists(turnGrid, SELECTION_PHASES.ACTION, 0, SELECTION_PHASES.ACTION, h, sparActions.swap)) {
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
				if (ds_grid_value_exists(turnGrid, SELECTION_PHASES.ACTION, 0, SELECTION_PHASES.ACTION, h, sparActions.rest)) {
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
				if (ds_grid_value_exists(turnGrid, SELECTION_PHASES.ACTION, 0, SELECTION_PHASES.ACTION, h, sparActions.dodge)) {
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
							// check that the ability check hasn't been performed yet
							if !(abilityChecked_priorityCheck) {
								// perform an ability check for priority check
								ability_check(ABILITY_TYPES.PRIORITY_CHECK);
								
								abilityChecked_priorityCheck = true;
							}
							
							// if both teams are synchronized, determine who will go first
							// and then perform both players' turns in order
							if (playerOne.synchronizedSoldiersActive) 
							&& (playerTwo.synchronizedSoldiersActive) {
								// initialize firstPlayer
								var firstPlayer = -1;
								var secondPlayer = -1;
								
								// determine who wins the tie using the turnCounter
								// check if turnCounter is an even number
								if (turnCounter mod 2 == 0) {
									// check if player is the host
									if (playerOne.clientType == CLIENT_TYPES.HOST) {
										firstPlayer = playerOne;	
										secondPlayer = playerTwo;
									}
									// if player is not the host
									else {
										firstPlayer = playerTwo;	
										secondPlayer = playerOne;
									}
								}
								// if turnCounter is an odd number
								else {
									// check if player is the guest
									if (playerOne.clientType == CLIENT_TYPES.GUEST) {
										firstPlayer = playerOne;
										secondPlayer = playerTwo;
									}
									// if player is not the guest
									else {
										firstPlayer = playerTwo;	
										secondPlayer = playerOne;
									}
								}
								
								// initialize first player list and second player list
								var fpl = -1;
								var spl = -1;
								
								// get first player list and second player list
								if (firstPlayer == playerOne) {
									fpl = allyList;
									spl = enemyList;
								}
								else {
									fpl = enemyList;
									spl = allyList;
								}
								
								// use a repeat loop to arbitrate all turns for first player
								var i = 0;	repeat (ds_list_size(fpl)) {
									var inst = fpl[| i];
									
									if (turnGrid[# SELECTION_PHASES.ACTION, inst.spotNum] != -1) {
										// push a spar effect alert for arbitrate turn
										spar_effect_push_alert(SPAR_EFFECTS.ARBITRATE_TURN, inst);
									}
									
									i++;
								}
								
								// use a repeat loop to arbitrate all turns for second player
								var i = 0;	repeat (ds_list_size(spl)) {
									var inst = spl[| i];
									
									if (turnGrid[# SELECTION_PHASES.ACTION, inst.spotNum] != -1) {
										// push a spar effect alert for arbitrate turn
										spar_effect_push_alert(SPAR_EFFECTS.ARBITRATE_TURN, inst);
									}
									
									i++;
								}
							}
							else {
								// check if playerOne's sprites are synchronized
								if (playerOne.synchronizedSoldiersActive) {
									// use a repeat loop to arbitrate all turns
									var i = 0;	repeat (ds_list_size(allyList)) {
										var inst = allyList[| i];
										
										if (turnGrid[# SELECTION_PHASES.ACTION, inst.spotNum] != -1) {
											// push a spar effect alert for arbitrate turn
											spar_effect_push_alert(SPAR_EFFECTS.ARBITRATE_TURN, inst);
										}
										
										i++;
									}
								}
								
								// check if playerTwo's sprites are synchronized
								if (playerTwo.synchronizedSoldiersActive) {
									// use a repeat loop to arbitrate all turns
									var i = 0;	repeat (ds_list_size(enemyList)) {
										var inst = enemyList[| i];
										
										if (turnGrid[# SELECTION_PHASES.ACTION, inst.spotNum] != -1) {
											// push a spar effect alert for arbitrate turn
											spar_effect_push_alert(SPAR_EFFECTS.ARBITRATE_TURN, inst);
										}
										
										i++;
									}
								}
							}
							
							// check if the actionProcessor is already active
							if !(instance_exists(processorParent)) {
								// create a variable to store the highest stat found so far
								var highest = 0;
								
								// create a variable to store the nextSprite
								var nextSprite = -1;
								
								var i = 0;	repeat (ds_grid_height(turnGrid)) {
									// get the current spotnum
									var sn = turnGrid[# SELECTION_PHASES.ALLY, i];
									
									// get the current instance
									var inst = spriteList[| sn];
									
									// get action
									var a = turnGrid[# SELECTION_PHASES.ACTION, i];
									
									// check if action is a spell
									if (action_check_spell(a)) {
										// get spellID
										var sid = action_get_spell_id(a);
										
										// create the priority list
										var pl = ds_list_create();
										decode_list(global.prioritySpellList, pl);
										
										// check if the spell id is on the priority list
										if (ds_list_find_index(pl, sid) >= 0) 
										&& !(inst.team.synchronizedSoldiersActive) {
											// use a switch statement to check the proper stat
											// depending on the current arena
											switch (currentArena) {
												case ARENAS.OCEAN:
													if (inst.currentWater > highest) {
														highest		= inst.currentWater;
														nextSprite	= i;
													}
													
													if (inst.currentWater == highest) {
														if (inst.luckRoll > spriteList[| nextSprite].luckRoll) {
															highest = inst.currentWater;
															nextSprite = i;
														}
														
														// tiebreaker logic for ocean
														if (inst.luckRoll == spriteList[| nextSprite].luckRoll) {
															// if this is an online match
															if (instance_exists(onlineEnemy)) {
																// check for whose sprite this is
																var t = inst.team;
																
																// check if these sprites are both on different teams
																if !(t == spriteList[| nextSprite].team) {																	
																	// initialize firstPlayer
																	var firstPlayer = -1;
																	
																	// determine who wins the tie using the turnCounter
																	// check if turnCounter is an even number
																	if (turnCounter mod 2 == 0) {
																		// check if player is the host
																		if (playerOne.clientType == CLIENT_TYPES.HOST) {
																			firstPlayer = playerOne;	
																		}
																		// if player is not the host
																		else {
																			firstPlayer = playerTwo;	
																		}
																	}
																	// if turnCounter is an odd number
																	else {
																		// check if player is the guest
																		if (playerOne.clientType == CLIENT_TYPES.GUEST) {
																			firstPlayer = playerOne;
																		}
																		// if player is not the guest
																		else {
																			firstPlayer = playerTwo;	
																		}
																	}
																	
																	// highest and nextSprite
																	highest = inst.currentWater;
																	nextSprite = i;
																}
															}
															// if this is a local match
															else {
																// in local matches, the tie always goes to the npc
																var t = inst.team;
																
																if (t == playerTwo) {
																	if (spriteList[| nextSprite].team != t) {
																		highest = inst.currentWater;
																		nextSprite = i;
																	}
																}
															}
														}
													}
												break;
												
												case ARENAS.CLOUDS:
													if (inst.currentStorm > highest) {
														highest		= inst.currentStorm;
														nextSprite	= i;
													}
													
													if (inst.currentStorm == highest) {
														if (inst.luckRoll > spriteList[| nextSprite].luckRoll) {
															highest = inst.currentStorm;
															nextSprite = i;
														}
														
														// tiebreaker logic for clouds
														if (inst.luckRoll == spriteList[| nextSprite].luckRoll) {
															// if this is an online match
															if (instance_exists(onlineEnemy)) {
																// check for whose sprite this is
																var t = inst.team;
																
																// check if these sprites are both on different teams
																if !(t == spriteList[| nextSprite].team) {								
																	// initialize firstPlayer
																	var firstPlayer = -1;
																	
																	// determine who wins the tie using the turnCounter
																	// check if turnCounter is an even number
																	if (turnCounter mod 2 == 0) {
																		// check if player is the host
																		if (playerOne.clientType == CLIENT_TYPES.HOST) {
																			firstPlayer = playerOne;	
																		}
																		// if player is not the host
																		else {
																			firstPlayer = playerTwo;	
																		}
																	}
																	// if turnCounter is an odd number
																	else {
																		// check if player is the guest
																		if (playerOne.clientType == CLIENT_TYPES.GUEST) {
																			firstPlayer = playerOne;
																		}
																		// if player is not the guest
																		else {
																			firstPlayer = playerTwo;	
																		}
																	}
																	
																	// highest and nextSprite
																	highest = inst.currentStorm;
																	nextSprite = i;
																}
															}
															// if this is a local match
															else {
																// in local matches, the tie always goes to the npc
																var t = inst.team;
																
																if (t == playerTwo) {
																	if (spriteList[| nextSprite].team != t) {
																		highest = inst.currentStorm;
																		nextSprite = i;
																	}
																}
															}
														}
													}
												break;
												
												default:
													if (inst.currentAgility > highest) {
														highest		= inst.currentAgility;
														nextSprite	= i;
													}
													
													if (inst.currentAgility == highest) {
														if (inst.luckRoll > spriteList[| nextSprite].luckRoll) {
															highest = inst.currentAgility;
															nextSprite = i;
														}
														
														// tiebreaker logic for normal arena
														if (inst.luckRoll == spriteList[| nextSprite].luckRoll) {
															// if this is an online match
															if (instance_exists(onlineEnemy)) {
																// check for whose sprite this is
																var t = inst.team;
																
																// check if these sprites are both on different teams
																if !(t == spriteList[| nextSprite].team) {								
																	// initialize firstPlayer
																	var firstPlayer = -1;
																	
																	// determine who wins the tie using the turnCounter
																	// check if turnCounter is an even number
																	if (turnCounter mod 2 == 0) {
																		// check if player is the host
																		if (playerOne.clientType == CLIENT_TYPES.HOST) {
																			firstPlayer = playerOne;	
																		}
																		// if player is not the host
																		else {
																			firstPlayer = playerTwo;	
																		}
																	}
																	// if turnCounter is an odd number
																	else {
																		// check if player is the guest
																		if (playerOne.clientType == CLIENT_TYPES.GUEST) {
																			firstPlayer = playerOne;
																		}
																		// if player is not the guest
																		else {
																			firstPlayer = playerTwo;	
																		}
																	}
																	
																	// highest and nextSprite
																	highest = inst.currentWater;
																	nextSprite = i;
																}
															}
															// if this is a local match
															else {
																// in local matches, the tie always goes to the npc
																var t = inst.team;
																
																if (t == playerTwo) {
																	if (spriteList[| nextSprite].team != t) {
																		highest = inst.currentAgility;
																		nextSprite = i;
																	}
																}
															}
														}
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
				// reset abilityChecked_priorityCheck
				abilityChecked_priorityCheck = false;
				
				// check that all sprites are done flashing
				if (check_sprites_done_flashing()) {
					// check that HPMP bars are up to date
					if (spar_check_hpmp()) {
						// check that there are no sparEffect alerts
						if (ds_list_size(effectAlertList) == 0) {
							if !(instance_exists(processorParent)) {
								// initialize a variable to store whether there are actions left to process
								var actionsRemaining = false;
								
								// use a repeat loop to check the whole grid for remaining actions
								var i = 0;	repeat (ds_grid_height(turnGrid)) {
									var a = turnGrid[# SELECTION_PHASES.ACTION, i];
									
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
										var a = turnGrid[# SELECTION_PHASES.ACTION, i];
										if (a >= 0) {
											// get current spotNum
											var sn = turnGrid[# SELECTION_PHASES.ALLY, i];
											
											// get the current instance
											var inst = spriteList[| sn];
											
											// use a switch statement to check the proper stat
											// depending on the arena
											switch (currentArena) {
												case ARENAS.OCEAN:
													if (inst.currentWater > highest) {
														highest		= inst.currentWater;
														nextSprite	= i;
													}
													
													if (inst.currentWater == highest) {
														if (inst.luckRoll > spriteList[| nextSprite].luckRoll) {
															highest = inst.currentWater;
															nextSprite = i;
														}
													}
												break;
												
												case ARENAS.CLOUDS:
													if (inst.currentStorm > highest) {
														highest		= inst.currentStorm;
														nextSprite	= i;
													}
													
													if (inst.currentStorm == highest) {
														if (inst.luckRoll > spriteList[| nextSprite].luckRoll) {
															highest = inst.currentStorm;
															nextSprite = i;
														}
													}
												break;
												
												default:
													if (inst.currentAgility > highest) {
														highest		= inst.currentAgility;
														nextSprite	= i;
														
														if (inst.currentAgility == highest) {
															if (inst.luckRoll > spriteList[| nextSprite].luckRoll) {
																highest = inst.currentAgility;
																nextSprite = i;
															}
														}
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
			
				sparPhase = SPAR_PHASES.TURN_END;
			break;
		}

		
	break;
	
	#region SELECTION PHASE
		case SPAR_PHASES.SELECT:
			sprite_index = spr_sparFlashingSliver;	
		
			// use a switch statement to manage all SELECTION_PHASES
			switch(selectionPhase) {
				case SELECTION_PHASES.ALLY:
				
					// set selection message
					selectionMsg = "Select a sprite to command";
					
					// create ready button if all sprites are ready
					if check_all_allies_ready() {
						create_once(0, 0, LAYER.ui, sparReadyButton);	
					}
				break;
				
				case SELECTION_PHASES.ACTION:
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
				
				case SELECTION_PHASES.TARGET:
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
						selectionPhase = SELECTION_PHASES.ACTION;
					}
				break;
			}
				
			// check if player is ready
			if (playerOne.ready) {
				// check if this is an online match
				if (playerTwo == onlineEnemy) {
					// check if onlineWaiting is false
					if !(onlineWaiting) {
						// set onlineWaiting to true
						onlineWaiting = true;
					}
					// if onlineWaiting is true
					else {	
						// check if it's been 5 seconds
						if !(global.gameTime mod 300) {
							// submit a request for the enemy turn data
							request_turn_begin();
						}
					}
				}
				
				// if player two is also ready
				if (playerTwo.ready) {
					onlineWaiting = false;
					playerTwo.ready = false;
					playerOne.ready = false;
					
					// move to the process phase
					sparPhase = SPAR_PHASES.PROCESS;
				}
			}
		break;
	#endregion
	
	#region TURN BEGIN PHASE
		case SPAR_PHASES.TURN_BEGIN:
			// perform an ability check for turn begin
			ability_check(ABILITY_TYPES.TURN_BEGIN);
		
			spar_check_hail_sphera();
			spar_check_miasma();	
			
			with (sparAlly) {
				var ID = id;
				
				if !(turnReady) {
					if (turnRepeat) {
						selectedTarget = lastTarget;
						selectedAction = lastAction;
					
						if (selectedAction == sparActions.swap) {
							spar.spriteList[| selectedTarget].turnRepeat = true;
						}
						
						sprite_build_ready_display();
						
						turnReady = true;
					}
					else {
						if (lastAction == sparActions.swap) {
							var targ = spar.spriteList[| lastTarget];
							
							if (targ.turnRepeat) {
								selectedTarget = lastTarget;
								selectedAction = lastAction;
								
								turnRepeat = true;
								
								sprite_build_ready_display();
								
								turnReady = true;
							}
						}
					}
				}
			}
			
			with (sparEnemy) {
				if !(turnReady) {
					if (turnRepeat) {
						selectedTarget = lastTarget;
						selectedAction = lastAction;
					
						if (selectedAction == sparActions.swap) {
							spar.spriteList[| selectedTarget].turnRepeat = true;
						}
						
						turnReady = true;
					}
					else {
						if (lastAction == sparActions.swap) {
							var targ = spar.spriteList[| lastTarget];
							
							if (targ.turnRepeat) {
								selectedTarget = lastTarget;
								selectedAction = lastAction;
								
								turnReady = true;
							}
						}
					}
				}
			}
			
			sparPhase = SPAR_PHASES.SELECT;
		break;
	#endregion
}

correct_uiAlpha();

// sparComplete logic
// check that all sprites are done flashing
if (check_sprites_done_flashing()) {
	// check that hpmp bars are up to date
	if (spar_check_hpmp()) {
		if (spar_check_complete()) {
			create_once(0, 0, LAYER.meta, winLoseDisplay);	
		}
	}
}
		