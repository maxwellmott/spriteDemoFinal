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
	
	// set all globals accordingly
	global.bestSpellID	= bestSpell;
	global.bestTargetID = bestTarg;
	global.bestDamage	= bestDamage;
	
	// return the best spell ID
	return bestSpell;
	
}

function enemy_ai_get_strongest_spell_within_mp(_spriteInst) {
	// store args in locals
	
	// get the attacker's team
	
	// store the list of nearby enemies in a local variable
	
	// initialize the variable to store the most powerful attack
	
	// initialize the variable to store the most powerful attack ID
	
	// initialize the variable to store the best target ID
	
	// use a repeat loop to check each sprite on the enemy list
		// use a repeat loop to check each spell on the spellbook (and basic attacks)
			// check if the spell is within the team's current MP			
		
	// store the best target ID in global.bestTargetID
	
	// return the strongest attack ID
	
}

function enemy_ai_get_strongest_spell_given_target(_atkr, _targ) {
	// store args in locals
	
	// initialize the variable to store the most powerful attack
	
	// initialize the variable to store the most powerful attack ID
	
	// use a repeat loop to check each spell on the spellbook (and basic attacks)
	
	// return the strongest attack ID
}

function enemy_ai_get_strongest_spell_given_target_within_mp(_atkr, _targ) {
	// store args in locals
	
	// initialize the variable to store the most powerful attack
	
	// initialize the variable to store the most powerful attack ID
	
	// use a repeat loop to check each spell on the spellbook (and basic attacks)
		// check if the spell is within the team's current MP

	// return the strongest attack ID
}

function enemy_ai_get_best_swap_overall(_spriteInst) {
	// store args in locals
	
	// get the team of the given sprite
	
	// get the list of allies for the given team
	
	// initialize the variable to store the best swap score
	
	// initialize the variable to store the best swap partner
	
	// use a repeat loop to calculate the swap score of each ally
	
	// store the best swap score in global.bestSwapScore
	
	// return the best swap partner ID
}

function enemy_ai_get_all_threat_levels() {
	
}

function enemy_ai_get_all_danger_levels() {
	
}

#endregion

function ai_mercurio_day_one() {
	
}