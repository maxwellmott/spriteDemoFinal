global.bestSpellID	= -1;
global.bestTargetID = -1;
global.bestCasterID = -1;
global.bestDamage	= -1;

function enemyAI_get_params() {
	// create temporary grid
	var grid = ds_grid_create(npcParams.height, npcs.height);
	
	// decode npcGrid
	decode_grid(global.allNPCs, grid);
	
	// use npcID to get params
	talismanString	= grid[# npcParams.talismans,	ID];
	name			= grid[# npcParams.name,		ID];
	spellBookString	= grid[# npcParams.spells,		ID];
	
	// decode talismanString and spellString
	decode_list(talismanString, roster);
	
	// delete temporary grid
	ds_grid_destroy(grid);
}

// create an enumerator for the enemy ai grid's x axis
enum ENEMY_AI_PARAMS {
	NPC_ID,
	ROSTER_LIST,
	SPELLBOOK_LIST,
	SELECTION_ALGO_LIST,
	HEIGHT
}

	/*	
		the enemy ai grid will contain lists of different items used to construct their
		enemy ai during a spar. 
		
		each list will collectively house groups of items with matching indeces. I may end up creating
		enumerators for each NPCs respective ai parameter groups to make it easier.
		
		the idea is that when the player passes certain landmarks in the game, different NPCs might become
		stronger or more experienced. When this happens, the next group of ai parameters should be taken from
		the lists on this grid and placed on the npc grid (which will then be saved/loaded by the player)
	*/ 

// create the enemy ai grid
global.enemyAiGrid = ds_grid_create(ENEMY_AI_PARAMS.HEIGHT, npcs.height);

// create a function to add to the enemy ai grid
function master_grid_add_enemy_ai(_ID) {
	// use a repeat loop to add all items
	var i = 0;	repeat (ENEMY_AI_PARAMS.HEIGHT) {
		ds_grid_add(global.enemyAiGrid, i, _ID, argument[i]);
	
		// increment i
		i++;
	}
}

#region DEFINE ALL AI CORE FUNCTIONS
function sprite_check_present(_spriteID) {
	// store args in locals
	var sid = _spriteID;
	
	var i = 0;	repeat (ds_list_size(spar.spriteList)) {
		// check if this sprite is of the given id
		if (spar.spriteList[| i].spriteID == sid) {
			return true;	
		}
		
		// increment i
		i++;
	}
	
	return false;
}

///@desc This function takes either enemyList or allyList and a stat from
/// SPRITE_PARAMS and returns the average of that stat on the given team.
function team_get_stat_average(_allyInstList, _spriteStat) {
	// store args in locals
	var l = _allyInstList;
	var s = _spriteStat;
	
	// ensure that this is a sprite stat and not a different param
	if (s < SPRITE_PARAMS.POWER)
	|| (s > SPRITE_PARAMS.LUCK) {
		return -1;	
	}
	
	// initialize variable to store the average
	var avg = 0;
	
	// use a repeat loop to add all stats to the average
	var i = 0;	repeat (ds_list_size(l)) {
		switch (s) {
			case SPRITE_PARAMS.POWER:
				avg += l[| i].currentPower;
			break;
			
			case SPRITE_PARAMS.RESISTANCE:
				avg += l[| i].currentResistance;
			break;
			
			case SPRITE_PARAMS.AGILITY:
				avg += l[| i].currentAgility;
			break;
			
			case SPRITE_PARAMS.FIRE:
				avg += l[| i].currentFire;
			break;
			
			case SPRITE_PARAMS.WATER:
				avg += l[| i].currentWater;
			break;
			
			case SPRITE_PARAMS.STORM:
				avg += l[| i].currentStorm;
			break;
			
			case SPRITE_PARAMS.EARTH:
				avg += l[| i].currentEarth;
			break;
			
			case SPRITE_PARAMS.LUCK:
				avg += l[| i].currentLuck;
			break;
		}
		
		// increment i
		i++;
	}
	
	avg = avg / ds_list_size(l);
	
	return avg;
}

///@desc This function rebuilds the list of player spells. It contains 
/// all seenSpells as well as any unseen "favorites"
function enemy_ai_build_player_spell_list() {
	// reset the list of potentialPlayerSpells
	ds_list_reset(potentialPlayerSpells);
	
	// check if the list of seenSpells is greater than or equal to the size of the player's spellbook grid
	if (ds_list_size(seenSpells) >= ds_grid_height(player.spellBookGrid)) {
		// add all seen spells to potential spells
		ds_list_copy(potentialPlayerSpells, seenSpells);
	}
	// if the list of seenSpells is not greater or equal to the size of the player's spellbook grid
	else {
		// add all seen spells to potential spells
		ds_list_copy(potentialPlayerSpells, seenSpells);
		
		// check if player has any favorite spells
		if (ds_list_size(player.favoriteSpells) > 0) {
			// use a repeat loop to check all favorite spells
			var i = 0;	repeat (ds_list_size(player.favoriteSpells)) {
				// check that this spell is NOT already on the list of potential spells
				if (ds_list_find_index(potentialPlayerSpells, player.favoriteSpells[| i]) == -1) {
					// add this spell to potential spell list
					ds_list_add(potentialPlayerSpells, player.favoriteSpells[| i]);
				}
				
				// increment i
				i++;
			}
		}
	}
}

///@desc This function takes a sprite instance ID and returns the ID for 
/// the strongest spell this sprite could use.
function enemy_ai_get_strongest_spell(_spriteInst) {
	// store args in locals
	var inst = _spriteInst;
	
	// get the team of this sprite
	var t = inst.team;
	
	// store the list of nearby enemies in a local variable
	var l = inst.nearbyEnemies;
	
	// initialize the variable to store the most powerful attack
	var bestDamage = 0;
	
	// initialize the variable to store the most powerful attack ID
	var bestSpell = -1;
	
	// initialize the variable to store the best target ID
	var bestTarg = -1;
	
	// initialize the damage variable
	var damage = 0;
	
	// use a repeat loop to check each sprite on the enemy list
	var i = 0;	repeat (ds_list_size(l)) {	
		// use a repeat loop to check each spell on the spellbook (and basic attacks)
		var j = 0;	repeat (ds_grid_height(t.spellBookGrid)) {
			// get spell ID
			var sid = t.spellBookGrid[# SPELL_PARAMS.ID, j];
			
			// check if spell is one of this sprite's usable spells
			if (ds_list_find_index(inst.usableSpells, sid) != -1) {
				// check if this is a damaging spell
				if (t.spellBookGrid[# SPELL_PARAMS.POWER, j] > 0) {
					// check if this is a physical spell
					if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] == SPELL_TYPES.PHYSICAL) {
						damage = get_physical_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
					}
					// else check if this is an elemental spell
					else if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] != SPELL_TYPES.TRICK) {
						damage = get_elemental_damage(l[| i], inst, spellBookGrid[# SPELL_PARAMS.TYPE, j], spellBookGrid[# SPELL_PARAMS.POWER, j]);
					}
					// else check if this is a "psychic" spell 
					else if (sid == SPELLS.PSYCHIC_IMPACT)
					|| (sid == SPELLS.PSYCHIC_FISSURE) {
						damage = get_psychic_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
					}
					
					// check if the current best damage was exceded
					if (damage > bestDamage) {
						bestDamage = damage;
						bestSpell = sid;
						bestTarg = l[| i];
					}
				}
			}
			
			// increment j
			j++;
		}
	
		// increment i
		i++;
	}
	
	if (bestSpell >= 0) {				
		// set all globals accordingly
		global.bestSpellID	= bestSpell;
		global.bestTargetID = bestTarg;
		global.bestDamage	= bestDamage;
		
		// return the best spell ID
		return bestSpell;
	}	
}

///@desc This function takes a sprite instance ID and returns the ID for
/// the strongest spell this sprite could use within the current MP
function enemy_ai_get_strongest_spell_within_mp(_spriteInst) {
	// store args in locals
	var inst = _spriteInst;
	
	// get the team of this sprite
	var t = inst.team;
	
	// store the list of nearby enemies in a local variable
	var l = inst.nearbyEnemies;
	
	// initialize the variable to store the most powerful attack
	var bestDamage = 0;
	
	// initialize the variable to store the most powerful attack ID
	var bestSpell = -1;
	
	// initialize the variable to store the best target ID
	var bestTarg = -1;
	
	// initialize the damage variable
	var damage = 0;
	
	// use a repeat loop to check each sprite on the enemy list
	var i = 0;	repeat (ds_list_size(l)) {	
		// use a repeat loop to check each spell on the spellbook (and basic attacks)
		var j = 0;	repeat (ds_grid_height(t.spellBookGrid)) {
			// get spell ID
			var sid = t.spellBookGrid[# SPELL_PARAMS.ID, j];
			
			// check if spell is one of this sprite's usable spells
			if (ds_list_find_index(inst.usableSpells, sid) != -1) {
				// check if this is a damaging spell
				if (t.spellBookGrid[# SPELL_PARAMS.POWER, j] > 0) {
					// check if there is enough MP to use this spell
					if (spellBookGrid[# SPELL_PARAMS.COST, j] <= t.currentMP) {
						// check if this is a physical spell
						if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] == SPELL_TYPES.PHYSICAL) {
							damage = get_physical_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
						}
						// else check if this is an elemental spell
						else if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] != SPELL_TYPES.TRICK) {
							damage = get_elemental_damage(l[| i], inst, spellBookGrid[# SPELL_PARAMS.TYPE, j], spellBookGrid[# SPELL_PARAMS.POWER, j]);
						}
						// else check if this is a "psychic" spell 
						else if (sid == SPELLS.PSYCHIC_IMPACT)
						|| (sid == SPELLS.PSYCHIC_FISSURE) {
							damage = get_psychic_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
						}
						
						// check if the current best damage was exceded
						if (damage > bestDamage) {
							bestDamage = damage;
							bestSpell = sid;
							bestTarg = l[| i];
						}
					}
				}
			}			
			
			// increment j
			j++;
		}
	
		// increment i
		i++;
	}
	
	if (bestSpell >= 0) {
		// set all globals accordingly
		global.bestSpellID	= bestSpell;
		global.bestTargetID = bestTarg;
		global.bestDamage	= bestDamage;
		
		// return the best spell ID
		return bestSpell;
	}	
}

///@desc This function takes a sprite instance ID and returns the ID for
/// the strongest spell given a specific target.
function enemy_ai_get_strongest_spell_given_target(_atkr, _targ) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	
	// initialize the variable to store the most powerful attack
	var bestSpell = -1;
	
	// initialize the variable to store the most powerful attack ID
	var bestDamage = 0;
	
	// initialize the variable to store the best target inst ID
	var bestTarg = -1;
	
	// get the team of the attacker
	var t = atkr.team;
	
	// initialize the damage val
	var damage = 0;
	
	// use a repeat loop to check each spell on the spellbook
	var i = 0;	repeat (ds_grid_height(t.spellBookGrid)) {
		// get the current spell
		var sid = spellBookGrid[# 0, i];
		
		// check if this is a damaging spell
		if (t.spellBookGrid[# SPELL_PARAMS.POWER, i] > 0) {
			// check if this spell is usable by the attacking sprite
			if (ds_list_find_index(atkr.usableSpells, sid) != -1) {
				// check if this is a physical spell
				if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] == SPELL_TYPES.PHYSICAL) {
					damage = get_physical_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
				}
				// else check if this is an elemental spell
				else if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] != SPELL_TYPES.TRICK) {
					damage = get_elemental_damage(l[| i], inst, spellBookGrid[# SPELL_PARAMS.TYPE, j], spellBookGrid[# SPELL_PARAMS.POWER, j]);
				}
				// else check if this is a "psychic" spell 
				else if (sid == SPELLS.PSYCHIC_IMPACT)
				|| (sid == SPELLS.PSYCHIC_FISSURE) {
					damage = get_psychic_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
				}
				
				// check if the current best damage was exceded
				if (damage > bestDamage) {
					bestDamage = damage;
					bestSpell = sid;
					bestTarg = l[| i];
				}
				
			}				
		}
	
		// increment i
		i++;
	}
	
	if (bestSpell >= 0) {
		// return the strongest attack ID
		// set all globals accordingly
		global.bestSpellID	= bestSpell;
		global.bestTargetID = bestTarg;
		global.bestDamage	= bestDamage;
		
		// return the best spell ID
		return bestSpell;
	}	
}

///@desc This function takes a sprite instance ID and returns the ID for
/// the strongest spell within the current mp given a specific target.
function enemy_ai_get_strongest_spell_given_target_within_mp(_atkr, _targ) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	
	// initialize the variable to store the most powerful attack
	var bestSpell = -1;
	
	// initialize the variable to store the most powerful attack ID
	var bestDamage = 0;
	
	// initialize the variable to store the best target inst ID
	var bestTarg = -1;
	
	// get the team of the attacker
	var t = atkr.team;
	
	// initialize the damage val
	var damage = 0;
	
	// use a repeat loop to check each spell on the spellbook
	var i = 0;	repeat (ds_grid_height(t.spellBookGrid)) {
		// get the current spell
		var sid = spellBookGrid[# 0, i];
		
		// check if this spell is within the current mp
		if (t.spellBookGrid[# SPELL_PARAMS.COST, i] <= t.currentMP) {
			// check if this is a damaging spell
			if (t.spellBookGrid[# SPELL_PARAMS.POWER, i] > 0) {
				// check if this spell is usable by the attacking sprite
				if (ds_list_find_index(atkr.usableSpells, sid) != -1) {
					// check if this is a physical spell
					if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] == SPELL_TYPES.PHYSICAL) {
						damage = get_physical_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
					}
					// else check if this is an elemental spell
					else if (t.spellBookGrid[# SPELL_PARAMS.TYPE, j] != SPELL_TYPES.TRICK) {
						damage = get_elemental_damage(l[| i], inst, spellBookGrid[# SPELL_PARAMS.TYPE, j], spellBookGrid[# SPELL_PARAMS.POWER, j]);
					}
					// else check if this is a "psychic" spell 
					else if (sid == SPELLS.PSYCHIC_IMPACT)
					|| (sid == SPELLS.PSYCHIC_FISSURE) {
						damage = get_psychic_damage(inst, l[| i], spellBookGrid[# SPELL_PARAMS.POWER, j]);
					}
					
					// check if the current best damage was exceded
					if (damage > bestDamage) {
						bestDamage = damage;
						bestSpell = sid;
						bestTarg = l[| i];
					}
				}				
			}				
		}
	
		// increment i
		i++;
	}
	
	if (bestSpell >= 0) {
	
		// return the strongest attack ID
		// set all globals accordingly
		global.bestSpellID	= bestSpell;
		global.bestTargetID = bestTarg;
		global.bestDamage	= bestDamage;
		
		// return the best spell ID
		return bestSpell;
	}
}

///@desc This function takes a sprite instance ID and returns the ID for
/// the strongest spell of a given type.
function enemy_ai_get_strongest_spell_given_type(_atkr, _spellType) {
	
}

///@desc This function takes a sprite instance ID and returns the ID for
/// the strongest spell within the current mp given a specific type.
function enemy_ai_get_strongest_spell_within_mp_given_type(_atkr, _spellType) {
	
}

///@desc This function takes a sprite and returns a score that represents how much of 
/// a threat that sprite is given the current circumstances
function enemy_ai_get_threat_level(_spriteInst) {
	
}

///@desc This function takes a sprite and returns a score that represents how much of
/// a threat that sprite is given the current circumstances
function enemy_ai_get_danger_level(_spriteInst) {
	
}

#endregion

function ai_mercurio_day_one() {
	// use a repeat loop to check each sprite on the enemyList
	var i = 0;	repeat (spar.enemyList) {
		// get the id of the current sprite
		var inst = spar.enemyList[| i];
		
		// get the enemy list
		var osl = spar.allyList;
		
		// get all of the opponent's avg stats
		var oppAvgPower		= team_get_stat_average(osl, SPRITE_PARAMS.POWER);
		var oppAvgRes		= team_get_stat_average(osl, SPRITE_PARAMS.RESISTANCE);
		var oppAvgFire		= team_get_stat_average(osl, SPRITE_PARAMS.FIRE);
		var oppAvgWater		= team_get_stat_average(osl, SPRITE_PARAMS.WATER);
		var oppAvgStorm		= team_get_stat_average(osl, SPRITE_PARAMS.STORM);
		var oppAvgEarth		= team_get_stat_average(osl, SPRITE_PARAMS.EARTH);
		
		// use a switch statement to manage each possible sprite
		switch (inst) {
			case SPRITES.DEMOLITOPS:
				// check that this sprite hasn't already had its turn selected
				if (inst.selectedAction == -1) {
					// get this sprite's danger level
					var dl = enemy_ai_get_danger_level(inst);
					
					// check that this sprite is NOT in any danger
					if (dl < 12) {
						
						// get the best physical spell
						var bestPhysSpell	= enemy_ai_get_strongest_spell_given_type(inst, SPELL_TYPES.PHYSICAL);
						var bestPhysTarg	= global.bestTargetID;
						var bestPhysDamage	= global.bestDamage;
						
						// get the best fire spell
						var bestFireSpell	= enemy_ai_get_strongest_spell_given_type(inst, SPELL_TYPES.FIRE);
						var bestFireTarg	= global.bestTargetID;
						var bestFireDamage	= global.bestDamage;
						
						// get the best earth spell
						var bestEarthSpell	= enemy_ai_get_strongest_spell_given_type(inst, SPELL_TYPES.EARTH);
						var bestEarthTarg	= global.bestTargetID;
						var bestEarthDamage = global.bestDamage;
						
						// initialize vars to track elemental vals
						var physScore	= 0;
						var fireScore	= 0;
						var earthScore	= 0;
						
						// calculate physical score
						if (bestPhysDamage > 0) {
							physScore = bestPhysDamage / oppAvgRes;	
						}
						
						// calculate fire score
						if (bestFireDamage > 0) {
							fireScore = bestFireDamage / oppAvgFire;
						}
						
						// calculate earth score
						if (bestEarthDamage > 0) {
							earthScore = bestEarthDamage / oppAvgEarth;	
						}
						
						// initialize bestSpell and highestScore vars
						var bestSpell = -1;
						var highestScore = 0;
						
						// determine the highestScore
						if (physScore > highestScore)	highestScore = physScore;	bestSpell = bestPhysSpell;
						if (fireScore > highestScore)	highestScore = fireScore;	bestSpell = bestFireSpell;
						if (earthScore > highestScore)	highestScore = earthScore;	bestSpell = bestEarthSpell;
						
						// find the index of the spell on the spellBookGrid
						var ind = ds_grid_value_y(spellBookGrid, 0, 0, 0, ds_grid_height(spellBookGrid), bestSpell);
						
						// check if the cost of the spell is greater than the current mp of the team
						if (spellBookGrid[# SPELL_PARAMS.COST, ind] > currentMP) {
							// check if the cost of the spell is more than 1 rest's worth of MP away
							if (abs(currentMP - spellBookGrid[# SPELL_PARAMS.COST, ind]) > REST_BASE_MP_REGEN) {
								bestSpell = enemy_ai_get_strongest_spell_within_mp(inst);
								var mpSpellDamage = global.bestDamage;
								var mpSpellTarget = global.bestTargetID;
							}
						}	
					}
					// if this sprite IS in danger
					else {			
						// set this sprite to swap with fishmonger
					}
				}
			break;
			
			case SPRITES.ZEPHIRA:
				// check that this sprite has not already had its turn selected
				if (inst.selectedAction == -1) {
					// check that this sprite is NOT in any danger
					if (dl < 12) {
						// get the best storm spell
						var bestStormSpell	= enemy_ai_get_strongest_spell_given_type(inst, SPELL_TYPES.STORM);
						var bestStormTarg	= global.bestTargetID;
						var bestStormDamage	= global.bestDamage;
						
						// check if the best storm damage is past a certain amount
						if (bestStormDamage > 200) {
							// check if oppAvgStorm is below a certain amount
							if (oppAvgStorm < 120) {	
								// check if oppAvgWater is past a certain range relative to oppAvgEarth
								if ((oppAvgEarth / oppAvgWater) < 0.9) {
									// set this sprite to cast that storm spell
									
								}
							}
						}
					}
					// if this sprite IS in danger
					else {
						// find the best swap for this sprite
						
						// set this sprite to swap
					}
				}
			break;
			
			case SPRITES.FISHMONGER:
				// check that this sprite hasn't already had it's turn selected
				if (inst.selectedAction == -1) {
				// get this sprite's danger level
				
				// get this sprite's threat level
				
				// get the team's current MP
				
				// check if this sprite's threat level excedes it's danger level
					// check if this team has above 50 MP
						// get the best water spell
						
						// get the best physical spell
					// if this team has BELOW 50 MP
						// set this sprite to rest for this turn
						
				// else
					// find the best swap for this sprite
					
					// set this sprite to swap
				}
			break;
			
			case SPRITES.UPROOTER:
				// check that this sprite hasn't already had it's turn selected
				if (inst.selectedAction == -1) {
					// get this sprite's danger level
				
					// get this sprite's threat level
						
					// get the team's current MP
				
					// check if this sprite's threat level excedes it's danger level
						// check if this team has above 50 MP
							// get the best earth spell
						
							// get the best physical spell
						// if this team has BELOW 50 MP
							// set this sprite to rest for this turn
				}			
			break;
		}
		
		// increment i 
		i++;
	}
}