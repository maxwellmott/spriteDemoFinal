///@desc This function takes an abilityType
/// ID and processes a check for that abilityType
/// for each sprite in order of agility, water, or
/// storm stat depending on the arena type
function ability_check(_abilityType) {
	// store args in locals
	var type = _abilityType;
	
	// get sprite list
	var l = spar.spriteList;

	// ids of all sprites whos abilities have been checked
	var spritesChecked = ds_list_create();
	
	// while there are still sprites to check	
	while (ds_list_size(spritesChecked) < 8) {
		// the highest stat checked so far
		var highest = 0;
		
		// ID of the sprite with the highest stat checked so far
		var highestID = -1;
		
		// perform an ability check on every sprite
		var i = 0;	repeat (ds_list_size(l)) {
			// get current sprite
			var inst = l[| i];
			
			var t = inst.team;
		
			// if current sprite is not on the list of checked sprites
			if (ds_list_find_index(spritesChecked, inst) == -1) {
				// if arena is normal
				if (spar.currentArena == -1) 
				|| (spar.currentArena == ARENAS.FOREST) 
				|| (spar.currentArena == ARENAS.VOLCANO) {
					// if this sprite has higher Agility than the current highest
					if (inst.currentAgility > highest) {
						// set highestID to inst
						highestID = inst;
						
						// set highest val to inst Agility
						highest = inst.currentAgility;
					}
					
					// tiebreaker logic for normal arena
					// if inst is tied with the current highest's Agility
					if (inst.currentAgility == highest) {
						// check if inst has a higher luck roll
						if (inst.luckRoll > highestID.luckRoll) {
							// set highestID to inst
							highestID = inst;
							
							// set highest val to inst agility
							highest = inst.currentAgility;
						}
						
						// if inst is tied with the current highest's luckroll
						if (inst.luckRoll == highestID.luckRoll) {
							// if this is an online match
							if (instance_exists(onlineEnemy)) {
								// check if these sprites are both on different teams
								if !(t == highestID.team) {								
									// initialize firstPlayer
									var firstPlayer = -1;
									
									// determine who wins the tie using the turnCounter
									// check if turnCounter is an even number
									if (spar.turnCounter mod 2 == 0) {
										// check if player is the host
										if (spar.playerOne.clientType == CLIENT_TYPES.HOST) {
											firstPlayer = spar.playerOne;	
										}
										// if player is not the host
										else {
											firstPlayer = spar.playerTwo;	
										}
									}
									// if turnCounter is an odd number
									else {
										// check if player is the guest
										if (spar.playerOne.clientType == CLIENT_TYPES.GUEST) {
											firstPlayer = spar.playerOne;
										}
										// if player is not the guest
										else {
											firstPlayer = spar.playerTwo;	
										}
									}
									
									// set highest and highestID
									highest = inst.currentAgility;
									highestID = inst;
								}
							}
							// if this is a local match
							else {
								if (t == spar.playerTwo) {
									if (highestID.team != t) {
										// set highest and highestID
										highest = inst.currentAgility;
										highestID = inst;
									}
								}
							}
						}
					}
				}
				
				// if arena is OCEAN
				if (spar.currentArena == ARENAS.OCEAN) {
					if (inst.currentWater > highest) {
						highestID = inst;
						highest = inst.currentWater;
					}
					
					// tiebreaker logic for ocean
					// if inst is tied with the current highest's Water
					if (inst.currentWater == highest) {
						// check if inst has a higher luck roll
						if (inst.luckRoll > highestID.luckRoll) {
							// set highestID to inst
							highestID = inst;
							
							// set highest val to inst Water
							highest = inst.currentWater;
						}
						
						// if inst is tied with the current highest's luckroll
						if (inst.luckRoll == highestID.luckRoll) {
							// if this is an online match
							if (instance_exists(onlineEnemy)) {
								// check if these sprites are both on different teams
								if !(t == highestID.team) {								
									// initialize firstPlayer
									var firstPlayer = -1;
									
									// determine who wins the tie using the turnCounter
									// check if turnCounter is an even number
									if (spar.turnCounter mod 2 == 0) {
										// check if player is the host
										if (spar.playerOne.clientType == CLIENT_TYPES.HOST) {
											firstPlayer = spar.playerOne;	
										}
										// if player is not the host
										else {
											firstPlayer = spar.playerTwo;	
										}
									}
									// if turnCounter is an odd number
									else {
										// check if player is the guest
										if (spar.playerOne.clientType == CLIENT_TYPES.GUEST) {
											firstPlayer = spar.playerOne;
										}
										// if player is not the guest
										else {
											firstPlayer = spar.playerTwo;	
										}
									}
									
									// set highest and highestID
									highest = inst.currentWater;
									highestID = inst;
								}
							}
							// if this is a local match
							else {
								if (t == spar.playerTwo) {
									if (highestID.team != t) {
										// set highest and highestID
										highest = inst.currentWater;
										highestID = inst;
									}
								}
							}
						}
					}
				}
				
				// if arena is CLOUDS
				if (spar.currentArena == ARENAS.CLOUDS) {
					if (inst.currentStorm > highest) {
						highestID = inst;
						highest = inst.currentStorm;
					}
				}
				
				// tiebreaker ocean for clouds
					// if inst is tied with the current highest's Storm
					if (inst.currentStorm == highest) {
						// check if inst has a higher luck roll
						if (inst.luckRoll > highestID.luckRoll) {
							// set highestID to inst
							highestID = inst;
							
							// set highest val to inst Storm
							highest = inst.currentStorm;
						}
						
						// if inst is tied with the current highest's luckroll
						if (inst.luckRoll == highestID.luckRoll) {
							// if this is an online match
							if (instance_exists(onlineEnemy)) {
								// check if these sprites are both on different teams
								if !(t == highestID.team) {								
									// initialize firstPlayer
									var firstPlayer = -1;
									
									// determine who wins the tie using the turnCounter
									// check if turnCounter is an even number
									if (spar.turnCounter mod 2 == 0) {
										// check if player is the host
										if (spar.playerOne.clientType == CLIENT_TYPES.HOST) {
											firstPlayer = spar.playerOne;	
										}
										// if player is not the host
										else {
											firstPlayer = spar.playerTwo;	
										}
									}
									// if turnCounter is an odd number
									else {
										// check if player is the guest
										if (spar.playerOne.clientType == CLIENT_TYPES.GUEST) {
											firstPlayer = spar.playerOne;
										}
										// if player is not the guest
										else {
											firstPlayer = spar.playerTwo;	
										}
									}
									
									// set highest and highestID
									highest = inst.currentStorm;
									highestID = inst;
								}
							}
							// if this is a local match
							else {
								if (t == spar.playerTwo) {
									if (highestID.team != t) {
										// set highest and highestID
										highest = inst.currentStorm;
										highestID = inst;
									}
								}
							}
						}
					}
			}
	
			i++;
		}
		
		// check if this check happens in the sparActionProcessor
		if (t >= ABILITY_TYPES.ACTION_BEGIN)
		&& (t <= ABILITY_TYPES.ACTION_SUCCESS) {
			// check if sparActionProcessor is gone
			if !(instance_exists(sparActionProcessor)) {
				// destroy temp list
				ds_list_destroy(spritesChecked);
			
				// return -1
				return -1;
			}
		}
		
		// perform an ability check on the next sprite
		if (highestID.currentAbilityType == type) {
			highestID.currentAbilityFunction(highestID);	
		}
		
		ds_list_add(spritesChecked, highestID);
	}
	
	// destroy list
	ds_list_destroy(spritesChecked);
}

// enum containing ability IDs
enum ABILITIES {
	HOT_TO_THE_TOUCH,
	WAVY_DANCE,
	STORM_SURFER,
	NATURES_RECLAMATION,
	BATTLE_INSTINCT,
	UNBREAKABLE_SHELL,
	SUPERCHARGED,
	WELL_READ,
	POWER_OF_FRIENDSHIP,
	UNDERSEA_PREDATOR,
	UNSTABLE_POWER,
	FREE_REFILLS,
	REFLECTIVE_SURFACE,
	FLOWERY_SPIRIT,
	GIFT_OF_SONG,
	HANG_TEN,
	TERRITORIAL_HUNTER,
	NATURAL_INGREDIENTS,
	ABSORPTIVE_BODY,
	CREEP_OUT,
	ENDLESS_WICK,
	ALL_SEEING_EYES,
	SORT_AWAY,
	SHORT_FUSE,
	OFFER_REFUGE,
	SIGNAL_JAMMER,
	SYNCHRONIZED_SOLDIERS,
	HERBAL_CONCOCTION,
	HEALING_HAZE,
	AQUATIC_ESSENCE,
	FIERY_AURA,
	THUNDROUS_CRY,
	MASSIVE_BODY,
	UNDERDOG,
	KEEPING_TIDY,
	WRECKING_BALL,
	DRIFT_AWAY,
	TRICKSTER_FAERIE,
	DUMPSTER_DIVER,
	SPRING_LOADED,
	FLOOD_SHELTER,
	PROPOGATE,
	HEAVY_SLEEPER,
	GET_ANGRY,
	GENERATOR,
	DUAL_WIELD,
	SHADOWY_FIEND,
	METAL_MUNCHER,
	VOLCANIC_MASS,
	EYE_OF_THE_STORM,
	TEARS_AND_JEERS,
	CENTRIPETAL_FORCE,
	PERENNIAL_GROWTH,
	PURE_MALICE,
	GUARDIAN_ANGEL,
	DARK_RITUAL,
	RING_LEADER,
	TIME_POLICE,
	SPACE_CADET,
	BAD_OMEN,
	ALL_KNOWING,
	BEND_PHYSICS,
	COMPRESS_TIME,
	END_OF_DAYS,
	HEIGHT
}

// enum containing ability params
enum ABILITY_PARAMS {
	ID,
	NAME,
	DESCRIPTION,
	TYPE,
	EFFECT_FUNCTION,
	HEIGHT	
}

// enum that contains all types of ability checks. This mostly exists
// so that abilities have a way of indicating when they should be activated
enum ABILITY_TYPES {
	TURN_BEGIN,				// CHECK PLACED
	RANGE_CHECK,		// CHECK PLACED
	PROCESS_BEGIN,			// CHECK PLACED
	PRIORITY_CHECK,			// CHECK PLACED
	SWAP_ATTEMPT,			// CHECK PLACED
	SWAP_SUCCESS,			// CHECK PLACED
	SPRITE_RESTING,			// CHECK PLACED 
	ACTION_BEGIN,			// CHECK PLACED
	DAMAGE_CALC,			// CHECK PLACED
	ACTION_SUCCESS,			// CHECK PLACED
	TURN_END,				// CHECK PLACED
	APPLY_MIASMA,			// CHECK PLACED
	MP_DEPLETED,			// CHECK PLACED
	HP_DEPLETED,			// CHECK PLACED
	MP_RESTORED,			// CHECK PLACED
	HP_RESTORED,			// CHECK PLACED
	HEIGHT					
}

#region CREATE ALL ABILITY EFFECT FUNCTIONS

///@desc ABILITY FUNCTION -- HACHA CHACHA:
/// TYPE: BASIC ATTACK SUCCESS
/// If this sprite is hit with a BASIC ATTACK, the opposing sprite
/// takes a flat amount of SELF DAMAGE.
function hot_to_the_touch(_inst) {
	// store args in locals
	var inst = _inst;
	
	// initialize selfDamage amount
	var selfDamageVal = 125;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if the given sprite is the current targetSprite
			if (inst == sparActionProcessor.targetSprite) {
				// check that this is a basic attack or physical spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {
					// push spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
						// push spar effect alert for apply self damage
					spar_effect_push_alert(SPAR_EFFECTS.APPLY_SELF_DAMAGE, sparActionProcessor.activeSprite.team, selfDamageVal);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- DIIPSY:
/// TYPE: ACTION ATTEMPT:
/// If ARENA is OCEAN and this sprite is targeted by a dodgeable
/// SPELL or BASIC ATTACK, it will automatically DODGE
function wavy_dance(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if the arena is OCEAN
				if (spar.currentArena == ARENAS.OCEAN) {
					// check if the spell is dodgeable
					if (sparActionProcessor.spellDodgeable) 
					|| (sparActionProcessor.currentSpell < 0) {
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// if so, set dodgeSuccess to true
						sparActionProcessor.dodgeSuccess = true;
					}
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- GLIDRAKE:
/// TYPE: SPELL SUCCESS
/// If this sprite is targeted by a STORM spell, the spell fails and they and receive
/// the BLESSING OF THE IMP.
function storm_surfer(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a storm spell
				if (sparActionProcessor.spellType == SPELL_TYPES.STORM) {
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// negate the damage
					sparActionProcessor.damage = 0;
					
					// push a spar effect alert for negate damage
					spar_effect_push_alert(SPAR_EFFECTS.NEGATE_DAMAGE, inst);
					
					// push a spar effect alert for granting the blessing of the imp
					spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, inst, MINDSETS.IMP_BLESS);
				}
			}
		}
	}
}
///@desc ABILITY FUNCTION -- PODRIC:
/// TYPE: DAMAGE CALC
/// This sprite's BASIC ATTACKS deal 2 damage against non-NATURAL
/// sprites.
function natures_reclamation(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if this sprite is the attacker
		if (inst == sparActionProcessor.activeSprite) {
			// check if it is a basic attack
			if (sparActionProcessor.currentSpell < 0) {
				// check if the target has a non-natural alignment
				if (sparActionProcessor.targetSprite.currentAlign != ALIGNMENTS.NATURAL) {
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
					
					// multiply damage by 2
					sparActionProcessor.damage = sparActionProcessor.damage * 2;
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- SPARMATE:
/// TYPE: BASIC ATTACK ATTEMPT:
/// If this sprite is targeted by a BASIC ATTACK or PHYSICAL SPELL,
/// it performs a DODGE check. If the sprite is set to dodge, it 
/// performs an additional check.
function battle_instinct(_inst) {
	// get args from locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a basic attack or a physical spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {
					// perform a dodge check
					with (sparActionProcessor) {
						dodgeSuccess = get_dodge_success();	
					}
					
					// check if dodge is successful
					if (sparActionProcessor.dodgeSuccess) {
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					}
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- CRUSTULAR:
/// TYPE: ACTION SUCCESS
/// If this sprite is targeted by a basic attack or physical spell, they
/// will receive half damage.
function unbreakable_shell(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a basic attack or a physical spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {	
					// divide damage in half
					sparActionProcessor.damage = round(sparActionProcessor.damage / 2);
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for damage decrease
					spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- FISTICOGS:
/// TYPE: SPELL SUCCESS
/// If this sprite is hit by a STORM SPELL, their MINDSET changes to the
/// BLESSING OF THE WARRIOR and their team heals back the damage, twofold
function supercharged(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {	
				// check if it is a storm spell
				if (sparActionProcessor.spellType == SPELL_TYPES.STORM) {
					// push a spar effect alert for ability activation
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for bestow mindset
					spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, inst, MINDSETS.WARRIOR_BLESS);
					
					// push a spar effect alert for restore hp
					spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, inst.team, sparActionProcessor.damage * 2);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- BOOKISH:
/// TYPE: TURN BEGIN
/// This sprite adds a ninth SPELL to their team's spellbook, it changes
/// randomly each turn (always one of the player's known spells)
function well_read(_inst) {
	// store args in locals
	var inst = _inst;
	
	// get this sprite's team
	var t = inst.team;
	
	// check if this is an online player,
	if (t == onlineEnemy) {
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push aspar effect alert for bonus spell
		spar_effect_push_alert(SPAR_EFFECTS.BONUS_SPELL, t);
		
		// return -1
		return -1;
	}
	
	// decode that player's knownSpells list
	var knownList = ds_list_create();
	decode_list(t.knownSpellString, knownList);
	
	var bookList = ds_list_create();
	decode_list(t.spellBookString, bookList);
	
	// get the number of spells known by their respective player
	var knownSpellsCount = ds_list_size(knownList);
	
	// check if that number is greater than 8
	if (knownSpellsCount > 8) {
		var spellSet = false;
		
		// use a while loop to randomly select a spell that isn't in the spellbook
		while !(spellSet) {
			// get a random number within the size of the knownSpells list
			var r = irandom_range(0, knownSpellsCount);
			
			// get the spell stored at that number
			var sid = knownList[| r];
			
			// check that that spell is not already in the spellbook
			if (ds_list_find_index(bookList, sid) == -1) {
				// add that spell to the spell book
				bookList[| 8] = sid;
				
				// encode bookList as player's new spellBookString
				t.spellBookString = encode_list(bookList);
				
				// rebuild the player's spellbook grid
				with (t) {
					player_build_spellBookGrid();
				}
				
				// set spellSet to true
				spellSet = true;
			}
		}
		
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for bonus spell
		spar_effect_push_alert(SPAR_EFFECTS.BONUS_SPELL, t);
	}
}

///@desc ABILITY FUNCTION -- PLEEP:
/// TYPE: ACTION SUCCESS
/// If one of this sprite's nearby allies are targeted for an attack, damage 
/// is cut in half.
function power_of_friendship(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if one of this sprite's nearby allies is being attacked
			if (ds_list_find_index(inst.nearbyAllies, sparActionProcessor.targetSprite) != -1) {
				// divide damage in half
				with (sparActionProcessor) {
					damage = damage / 2;	
				}
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect alert for decrease damage
				spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE, sparActionProcessor.targetSprite);
			}
		}
	}
}

///@desc ABILITY FUNCTION -- FISHMONGER:
/// TYPE: ACTION BEGIN
/// If the ARENA is OCEAN, this sprite's attacks are boosted and undodgeable
function undersea_predator(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if ocean is active
	if (spar.currentArena == ARENAS.OCEAN) {
		if (instance_exists(sparActionProcessor)) {
			// ensure that this is not an out of range attack
			if !(sparActionProcessor.outOfRange) {
				// check if this sprite is the attacker
				if (inst == sparActionProcessor.activeSprite) {
					// check if this is a damaging spell or basic attack
					if (sparActionProcessor.currentSpell < 0) 
					|| (sparActionProcessor.spellPower > 0) {
						// increase the DMI by 2
						global.damageMultiplierIndex += 2;
					
						// set dodgeable to false
						sparActionProcessor.spellDodgeable = false;
						
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for increase damage
						spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
					}
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- GEMBO:
/// TYPE: TURN BEGIN
/// Every fifth turn, this sprite creates an ENERGY BLAST against
/// both players.
function unstable_power(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this turn is a multiple of 5
	if (spar.turnCounter mod 5 == 0) {	
		// if so, push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for energy blast global
		spar_effect_push_alert(SPAR_EFFECTS.ENERGY_BLAST_GLOBAL, 200);
	}
}

///@desc ABILITY FUNCTION -- JOE:
/// TYPE: TURN END
/// This sprite RESTORES 30 MP at the end of each turn.
function free_refills(_inst) {
	// store args in locals
	var inst = _inst;
	
	// get the sprite's team
	var t = inst.team;
	
	// check if they already have max MP
	if (t.currentMP == MAX_MP)	return -1;
	
	// push a spar effect alert for activate ability
	spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
	
	// push a spar effect alert for restore mp
	spar_effect_push_alert(SPAR_EFFECTS.RESTORE_MP, t, 20);
}

///@desc ABILITY FUNCTION -- MIRREFRACT:
/// TYPE: TURN BEGIN
/// If this sprite is targeted by a SPELL, it switches itself with the caster
/// and makes them become the target.
function reflective_surface(_inst) {
	// store args in locals
	var inst = _inst;
	
	// push a spar effect alert for activate ability
	spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
	
	// push a spar effect alert for set deflective
	spar_effect_push_alert(SPAR_EFFECTS.SET_DEFLECTIVE, inst);
}

///@desc ABILITY FUNCTION -- FLOOPWALKER:
/// TYPE: ACTION BEGIN
/// If this sprite uses a SPELL, the ARENA becomes FOREST and the DMI is increased
/// by 2.
function flowery_spirit(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if this sprite is attacking
		if (inst == sparActionProcessor.activeSprite) {
			// check if it is a damaging elemental spell
			if (sparActionProcessor.spellType < SPELL_TYPES.PHYSICAL)
			&& (sparActionProcessor.spellType > 0) 
			&& (sparActionProcessor.spellPower > 0) {
				// increase the DMI by 2
				global.damageMultiplierIndex += 2;
				
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// ensure that this is not an out of range attack
				if !(sparActionProcessor.outOfRange) {
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
				
				// push a spar effect alert for arena change forest
				spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_FOREST);
			}
		}
	}
}

///@desc ABILITY FUNCTION -- SONGBIRD:
/// TYPE: TURN BEGIN
/// This sprite receives a random BLESSING at the beginning of each turn.
function gift_of_song(_inst) {
	// store args in locals
	var inst = _inst;
	
	// get this sprite's current mindset
	var m = inst.mindset;
	
	// create a boolean variable to turn off a while loop
	var looping = true;
	
	// use a while loop to randomly select a different blessing
	while (looping) {	
		var r = irandom_range(0, MINDSETS.TREE_CURSE - 1);
		
		if (r != m) {
			m = r;
			looping = false;
		}
	}
	
	// push a spar effect alert for activate ability
	spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
	
	// push a spar effect alert for bestow mindset
	spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, inst, m);
}

///@desc ABILITY FUNCTION -- SHREDATOR:
/// TYPE: ACTION SUCCESS
/// If the ARENA is OCEAN, and this sprite attempts a BASIC ATTACK, the DMI is
/// increased by 2.
function hang_ten(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if ocean is active
	if (spar.currentArena == ARENAS.OCEAN) {
		if (instance_exists(sparActionProcessor)) {
			// ensure that this is not an out of range attack
			if !(sparActionProcessor.outOfRange) {
				// check if this sprite is attacking
				if (inst == sparActionProcessor.activeSprite) {
					// check if it is a basic attack
					if (sparActionProcessor.currentSpell < 0) {
						// multiply damage by 2
						with (sparActionProcessor) {
							damage = damage * 2;	
						}
						
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for increase damage
						spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);	
					}
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- FURVOR:
/// TYPE: ACTION BEGIN
/// Gets an attack boost for all nearby natural sprites
function territorial_hunter(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {
				// initialize a counter
				var count = 0;
				
				// use a repeat loop to count all natural sprites near this one
				var i = 0;	repeat (ds_list_size(inst.nearbySprites)) {
					// get sprite
					var s = inst.nearbySprites[| i];
					
					// check if it's alignment is natural
					if (s.currentAlign == ALIGNMENTS.NATURAL) {
						// if so, increment count
						count++;
					}
					
					// increment i
					i++;
				}
				
				// if count is above 0
				if (count > 0) {
					// increase the dmi by that amount
					global.damageMultiplierIndex += count;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- GASTRONIMO:
/// TYPE: SPELL SUCCESS
/// If this sprite is hit by an EARTH SPELL, their team instead RESTORES
/// the amount of HEALTH that would have been lost.
function natural_ingredients(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {	
				// check if it is an earth spell
				if (sparActionProcessor.spellType == SPELL_TYPES.EARTH) {
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for force spell failure
					spar_effect_push_alert(SPAR_EFFECTS.FORCE_SPELL_FAILURE, sparActionProcessor.activeSprite);
					
					// push a spar effect alert for restore HP
					spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, inst.team, sparActionProcessor.damage);
					
					// force the spell to fail
					sparActionProcessor.spellFailed = true;
					
					// send the action processor straight to the apply damage phase 
					// (this is to skip the announcment that the spell failed since there
					// will be a notification along with the force spell failure effect alert
					sparActionProcessor.state = ACTION_PROCESSOR_STATES.APPLY_DAMAGE;
				}
			}	
		}
	}
}

///@desc ABILITY FUNCTION -- DURENDOUX:
/// TYPE: ACTION SUCCESS
/// If this sprite is hit with a basic attack or physical spell, the attacker
/// becomes BOUND.
function absorptive_body(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check that it is a basic attack or physical spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for set bound
					spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND, sparActionProcessor.activeSprite);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- STAGEFRITE:
/// TYPE: REST SUCCESS
/// All of this sprite's nearby sprites become HEXED at the beginning of each turn.
function creep_out(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if sprite is resting
	if (inst.resting) {
		// get nearby sprites list
		var l = inst.nearbySprites;
	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
	
		// push a spar effect alert for set hexed nearby sprites
		spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES, inst);
	}
}

///@desc ABILITY FUNCTION -- FLAMILIAR:
/// TYPE: SPELL COST CHECK
/// This sprite's FIRE spells don't cost any magic points
function endless_wick(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the sparActionProcessor exists
	if (instance_exists(sparActionProcessor)) {
		// check if this sprite is attacking
		if (inst == sparActionProcessor.activeSprite) {
			// check if it is a fire spell
			if (sparActionProcessor.spellType == SPELL_TYPES.FIRE) {
				// set the cost of the spell to 0
				sparActionProcessor.spellCost = 0;
				
				// push a spar effect alert for active ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect alert for negate spell cost
				spar_effect_push_alert(SPAR_EFFECTS.NEGATE_SPELL_COST, inst);
			}
		}
	}
}

///@desc ABILITY FUNCTION -- SCROOTINEYES:
/// TYPE: TARGET SELECTION
/// This sprite has increased RANGE for all ELEMENTAL and TRICK SPELLS.
function all_seeing_eyes(_inst) {
	// store args in locals
	var inst = _inst;
	
	// build spell grid
	var sg = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	decode_grid(global.allSpells, sg);
	
	// check if the sparActionProcessor exists
	if (instance_exists(sparActionProcessor)) {
		// check if this sprite is the attacker
		if (inst == sparActionProcessor.activeSprite) {
			// get spell type
			var st = real(sg[# SPELL_PARAMS.TYPE, sparActionProcessor.currentSpell]);
			
			// check if spell is elemental or trick spell
			if (st != SPELL_TYPES.PHYSICAL) {
				// improve range
				improve_range();
				
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect alert for improve range
				spar_effect_push_alert(SPAR_EFFECTS.IMPROVE_RANGE, inst);
			}
		}
	}
	else {
		// check if this sprite is the selectedAlly
		if (inst == player.selectedAlly) {
			// check if it is using a trick or elemental spell
			if (global.action >= sparActions.height) {
				// get spell type
				var st = real(sg[# SPELL_PARAMS.TYPE, global.action - sparActions.height]);		
				
				// check if spell is elemental or trick spell
				if (st != SPELL_TYPES.PHYSICAL) {
					// improve range
					improve_range();
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for improve range
					spar_effect_push_alert(SPAR_EFFECTS.IMPROVE_RANGE, inst);
				}
			}
		}
	}
}
///@desc ABILITY FUNCTION -- ARRAYNGE:
/// TYPE: ACTION SUCCESS
/// If this sprite is hit with a basic attack or physical spell, the attacker
/// is forced to swap with a random ally.
function sort_away(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a basic attack or physical spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {	
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for force swap
					spar_effect_push_alert(SPAR_EFFECTS.FORCE_SWAP, sparActionProcessor.activeSprite);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- TICKDOFF:
/// TYPE: TURN END
/// This sprite becomes BERSERK at the end of every fifth turn.
function short_fuse(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this turn is a multiple of 5
	if (spar.turnCounter mod 5 == 0) {	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for set berserk
		spar_effect_push_alert(SPAR_EFFECTS.SET_BERSERK, inst);
	}
}

///@desc ABILITY FUNCTION -- FORTUGA:
/// TYPE: ACTION ATTEMPT
/// If one of this sprite's nearby allies is targeted by a PHYSICAL SPELL or
/// BASIC ATTACK, they will take the target's place.
function offer_refuge(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if the target is one of this sprite's nearbyAllies
		if (ds_list_find_index(inst.nearbyAllies, sparActionProcessor.targetSprite) != -1) {
			// check if it is a basic attack or physical spell
			if (sparActionProcessor.currentSpell < 0) 
			|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// set the targetSprite to inst
				sparActionProcessor.targetSprite = inst;
			}
		}
	}
}

///@desc ABILITY FUNCTION -- SPYOTIS:
/// TYPE: TURN BEGIN
/// This sprite sets HUM on both sides of the field at the beginning of each
/// turn.
function signal_jammer(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check that HUM is inactive on at least one side of the field
	if !(spar.playerOne.hum) 
	|| !(spar.playerTwo.hum) {
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for set hum global
		spar_effect_push_alert(SPAR_EFFECTS.SET_HUM_GLOBAL);
	}
}

///@desc ABILITY FUNCTION -- DRUMLINE:
/// TYPE: TURN BEGIN
/// This sprite's allies attack in order of the teamList.
function synchronized_soldiers(_inst) {
	// store args in locals
	var inst = _inst;
	
	// push a spar effect alert for activate ability
	spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
	
	// push a spar effect alert for synchronize sprites
	spar_effect_push_alert(SPAR_EFFECTS.SYNCHRONIZE_SPRITES, inst.team);
}

///@desc ABILITY FUNCTION -- REVOLTURE:
/// TYPE: APPLY MIASMA
/// This sprite's team RESTORES HEALTH from MIASMA instead of taking damage
function herbal_concoction(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite's team is the miasmaTeam
	if (inst.team == global.miasmaTeam) {
		// check if global.miasmaDamge is greater than 0
		if (global.miasmaDamage > 0) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// multiply global.miasmaDamage by -1
			global.miasmaDamage = global.miasmaDamage * -1;
		}
	}
}

///@desc ABILITY FUNCTION -- CLEANSAGE:
/// TYPE: REST SUCCESS
/// When this sprite RESTS, it removes all HINDRANCES for their team
/// and RESTORES 250 HP.
function healing_haze(_inst) {
	// store args in locals
	var inst = _inst;
	
	var activated = false;
	
	// check if this sprite is resting
	if (inst.resting) {
		// check if any hindrances are active for this sprite's team
		if (inst.team.miasma) 
		|| (inst.team.rust)
		|| (inst.team.hum) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// push a spar effect alert for clear hindrances
			spar_effect_push_alert(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES, inst.team);
		
			// set activated to true
			activated = true;
		}
		
		// check if this sprite's team has less than max hp
		if (inst.team.currentHP < MAX_HP) {
			// if ability wasn't already activated
			if !(activated) {
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			}
			
			// push a spar effect alert for restore hp
			spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, inst.team, 250);
		}
	}
}

///@desc ABILITY FUNCTION -- FLOTSO:
/// TYPE: REST SUCCESS
/// If this sprite RESTS, the ARENA becomes OCEAN.
function aquatic_essence(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite is resting
	if (inst.resting) {
		// check that the arena is not already ocean
		if (spar.currentArena != ARENAS.OCEAN) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// push a spar effect alert for arena change ocean
			spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_OCEAN);
		}
	}
}

///@desc ABILITY FUNCTION -- HEATSUNE:
/// TYPE: SPELL ATTEMPT
/// If this sprite casts a FIRE SPELL, the DMI is first increased by 2.
function fiery_aura(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {
				// check if it is a fire spell
				if (sparActionProcessor.spellType == SPELL_TYPES.FIRE) {
					// increase the DMI by 2
					global.damageMultiplierIndex += 2;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- BLITZKRANE:
/// TYPE: ACTION SUCCESS
/// If this sprite is hit with a damaging SPELL or BASIC ATTACK,
/// the ARENA changes to SKY.
function thundrous_cry(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a damaging spell or basic attack
				if (sparActionProcessor.spellPower > 0) 
				|| (sparActionProcessor.currentSpell < 0) {	
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for arena change clouds
					spar_effect_push_alert(SPAR_EFFECTS.ARENA_CHANGE_CLOUDS);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- EXONOLITH:
/// TYPE: ACTION SUCCESS
/// If this sprite uses a BASIC ATTACK, their RESISTANCE is used for
/// damage calc instead of POWER.
function massive_body(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the attacker
			if (inst == sparActionProcessor.activeSprite) {
				// check if this is a basic attack
				if (sparActionProcessor.currentSpell < 0) {
					// reset damage using arbitrate_physical_damage
					sparActionProcessor.damage = arbitrate_physical_damage(inst, sparActionProcessor.targetSprite, SPRITE_PARAMS.RESISTANCE, BASIC_ATTACK_POWER);
				
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
					// push a spar effect alert for basic attack fire
					spar_effect_push_alert(SPAR_EFFECTS.BASIC_ATTACK_RESISTANCE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- PUGILOON:
/// TYPE: ACTION SUCCESS
/// If this sprite's team has less than half of their max HP, their 
/// BASIC ATTACKS and PHYSICAL SPELLS deal 2* damage.
function underdog(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {
				// check if this sprite's team has 500 hp or less
				if (inst.team.currentHP <= MAX_HP / 2) {
					// boost damage by 2	
					sparActionProcessor.damage = sparActionProcessor.damage * 2;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- MR SUDSY
/// TYPE: TURN END
/// This sprite clears all HINDRANCES and shifts all CURSES for their team at the
/// end of each turn.
function keeping_tidy(_inst) {
	// store args in locals
	var inst = _inst;
	
	// initialize activated boolean
	var activated = false;
	
	// check if there are any hindrances on this sprite's side of the field
	if (inst.team.miasma)
	|| (inst.team.hum) 
	|| (inst.team.rust) {	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for clear hindrances
		spar_effect_push_alert(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES, inst.team);
		
		// set activated to true
		activated = true;
	}
	
	// initialize curseCount
	var curseCount = 0;
	
	// get necessary sprite ID list
	var l = -1;
	if (inst.team == player) {
		l = spar.allyList;	
	}
	else {
		l = spar.enemyList;
	}
	
	// use a repeat loop to check if there are any curses on this sprite's side of the field
	var i = 0;	repeat (ds_list_size(l)) {
		var sid = l[| i];
		
		if (sid.mindset < 0) {
			curseCount++;	
		}
		
		i++;
	}
	
	// check if there were curses present
	if (curseCount > 0) {
		// check if ability has already been activated
		if !(activated) {	
			// push a spar effect alert for ability activated
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		}
		// push a spar effect alert for shift curses team
		spar_effect_push_alert(SPAR_EFFECTS.SHIFT_CURSE_TEAM, inst.team);
	}
}

///@desc ABILITY FUNCTION -- DEMOLITOPS:
/// TYPE: ACTION SUCCESS
/// This sprite's BASIC ATTACKS deal 2* damage against MECHANICAL sprites.
function wrecking_ball(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {	
				// check if it is a basic attack
				if (sparActionProcessor.currentSpell < 0) {	
					// check if the target is a MECHANICAL sprite
					if (sparActionProcessor.targetSprite.currentAlign == ALIGNMENTS.MECHANICAL) {	
						// increase the damage by 2
						sparActionProcessor.damage = sparActionProcessor.damage * 2;
						
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for increase damage
						spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
					}
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- DOORMAUS:
/// TYPE: REST SUCCESS
/// If this sprite rests, they will automatically SWAP with another sprite at
/// no cost.
function drift_away(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite is resting
	if (inst.resting) {	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for force swap
		spar_effect_push_alert(SPAR_EFFECTS.FORCE_SWAP, inst);
	}
}

///@desc ABILITY FUNCTION -- ZEPHIRA
/// TYPE: SPELL SUCCESS
/// If this sprite successfully casts a TRICK SPELL, their target's team
/// takes 200 HP.
function trickster_faerie(_inst) {
	// store args in locals
	var inst = _inst;
	
	if  (instance_exists(sparActionProcessor)) {
		// check if this sprite is attacking
		if (inst == sparActionProcessor.activeSprite) {	
			// check if it is a trick spell that isn't self targeting
			if (sparActionProcessor.spellType == SPELL_TYPES.TRICK) {
				// check that this isn't a psychic spell
				if (sparActionProcessor.currentSpell != SPELLS.PSYCHIC_IMPACT)
				&& (sparActionProcessor.currentSpell != SPELLS.PSYCHIC_FISSURE) {
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
					// push a spar effect alert for deplete hp	
					spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP, inst.enemy, 200);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- CANUKI
/// TYPE: MP SPENDING
/// Whenever a nearby sprite spends MP, half of the MP used to cast is
/// absorbed by this sprite.
function dumpster_diver(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the depletion player is one of this sprite's nearby sprites
	if (ds_list_find_index(inst.nearbySprites, global.mpSpendingSprite) != -1) {
		// check if this sprite's team has less than MAX MP
		if (inst.team.currentMP < MAX_MP) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// push a spar effect alert for restore mp
			spar_effect_push_alert(SPAR_EFFECTS.RESTORE_MP, inst.team, 10);
		}
	}
}

///@desc ABILITY FUNCTION -- JACKHAMMER
/// TYPE: TARGET SELECTION
/// This sprite can target any other sprite with a BASIC ATTACK
/// or PHYSICAL SPELL
function spring_loaded(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite is the selectedAlly
	if (inst == player.selectedAlly) {
		// check if it is a basic attack
		if (global.action == sparActions.attack) {
			improve_range();
			
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// push a spar effect alert for improve range
			spar_effect_push_alert(SPAR_EFFECTS.IMPROVE_RANGE, inst);
		}
		
		// check if it is a spell
		if (global.action >= sparActions.height) {
			// build spell grid
			var g = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
			decode_grid(global.allSpells, g);
			
			// check if it is a physical spell
			if (g[# SPELL_PARAMS.TYPE, global.action - sparActions.height] == SPELL_TYPES.PHYSICAL) {
				improve_range();
				
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect alert for improve range
				spar_effect_push_alert(SPAR_EFFECTS.IMPROVE_RANGE, inst);
			}
		}
	}
}

///@desc ABILITY FUNCTION -- SPLASHGUARD
/// TYPE: SPELL ATTEMPT
/// If any of this sprite's allies are targeted with a WATER SPELL, this
/// sprite will take their place as the target.
function flood_shelter(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if the targetSprite is on this sprite's team
		if (sparActionProcessor.targetSprite.team == inst.team) 
		&& (sparActionProcessor.targetSprite != inst) {	
			// check if it is a water spell
			if (sparActionProcessor.spellType == SPELL_TYPES.WATER) {	
				// push a spar effect for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect for replace target
				spar_effect_push_alert(SPAR_EFFECTS.REPLACE_TARGET, inst, sparActionProcessor.targetSprite);
			}
		}
	}
}

///@desc ABILITY FUNCTION -- UPROOTER
/// TYPE: TURN BEGIN
/// This sprite cannot be bound
function propogate(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite is bound
	if (inst.bound) {
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for remove bound
		spar_effect_push_alert(SPAR_EFFECTS.REMOVE_BOUND, inst);
	}	
}

///@desc ABILITY FUNCTION -- SNUGBUG
/// TYPE: REST SUCCESS
/// When this sprite rests, it becomes INVULNERABLE until the end of the turn
function heavy_sleeper(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite is resting
	if (inst.resting) {
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect for set invulnerable
		spar_effect_push_alert(SPAR_EFFECTS.SET_INVULNERABLE, inst);
	}
}

///@desc ABILITY FUNCTION -- PUNKLOPS
/// TYPE: TURN END
/// If this sprite's team has less than half HP, it goes berserk
function get_angry(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this sprite's team has half HP or less
	if (inst.team.currentHP <= MAX_HP / 2) 
	&& !(inst.berserk) {	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for set berserk
		spar_effect_push_alert(SPAR_EFFECTS.SET_BERSERK, inst);
	}
}

///@desc ABILITY FUNCTION -- PLASMASS
/// TYPE: SPELL ATTEMPT
/// When this sprite casts a FIRE or STORM spell, the DMI is increased
/// by 1.
function generator(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {
				// check if it is a fire or storm spell
				if (sparActionProcessor.spellType == SPELL_TYPES.FIRE) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.STORM) {	
					// increase the dmi by 1
					global.damageMultiplierIndex++;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- OBSIDUAL:
/// TYPE: ACTION SUCCESS
/// This sprite's BASIC ATTACKS deal 2* damage.
function dual_wield(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {	
				// check if it is a basic attack
				if (sparActionProcessor.currentSpell < 0) {	
					// multiply damage output by 2
					sparActionProcessor.damage = sparActionProcessor.damage * 2;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- NINTOX:
/// TYPE: ACTION ATTEMPT
/// If MIASMA is present on this sprite's side of the field, they perform a
/// DODGE check whenever targeted by a damaging spell or basic attack.
function shadowy_fiend(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is being attacked
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a basic attack or damaging spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellPower > 0) {
					// check if miasma is present on this sprite's side of the field
					if (inst.team.miasma) {
						// check if the spell is dodgeable
						if (sparActionProcessor.spellDodgeable) {
							// push a spar effect alert for activate ability
							spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
							
							// if so, set dodgeSuccess to true
							sparActionProcessor.dodgeSuccess = true;
						}
					}
				}
			}
		}
	}	
}

///@desc ABILITY FUNCTION -- CHROMALIODON
/// TYPE: ACTION ATTEMPT
/// If a MECHANICAL sprite targets this sprite with a BASIC ATTACK OR
/// PHYSICAL SPELL, this sprite RESTORES HP equal to the damage it would
/// have taken and causes the SPELL to fail.
function metal_muncher(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is the target
			if (inst == sparActionProcessor.targetSprite) {
				// check if it is a basic attack or physical spell
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) {	
					// check if the attacker is a mechanical sprite
					if (sparActionProcessor.activeSprite.currentAlign == ALIGNMENTS.MECHANICAL) {
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for force spell failure
						spar_effect_push_alert(SPAR_EFFECTS.FORCE_SPELL_FAILURE, sparActionProcessor.activeSprite);
						
						// push a spar effect alert for restore HP
						spar_effect_push_alert(SPAR_EFFECTS.RESTORE_HP, inst.team, sparActionProcessor.damage);
						
						// force the spell to fail
						sparActionProcessor.spellFailed = true;
						
						// send the action processor straight to the apply damage phase 
						// (this is to skip the announcment that the spell failed since there
						// will be a notification along with the force spell failure effect alert
						sparActionProcessor.state = ACTION_PROCESSOR_STATES.APPLY_DAMAGE;
					}
				}
			}	
		}
	}
}

///@desc ABILITY FUNCTION -- CRAGMA
/// TYPE: ACTION SUCCESS
/// This sprite's basic attacks use the FIRE stat for damage calc instead of
/// the POWER stat.
function volcanic_mass(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {	
				// check if it is a basic attack
				if (sparActionProcessor.currentSpell < 0) {
					// reset damage using arbitrate_physical_damage
					sparActionProcessor.damage = arbitrate_physical_damage(inst, sparActionProcessor.targetSprite, SPRITE_PARAMS.FIRE, BASIC_ATTACK_POWER);
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for basic attack fire
					spar_effect_push_alert(SPAR_EFFECTS.BASIC_ATTACK_FIRE, inst);
				}
			}	
		}
	}
}

///@desc ABILITY FUNCTION -- CORVOLT
/// TYPE: TURN START
/// If the ARENA is CLOUDS, all of this sprite's nearby allies will become
/// INVULNERABLE at the beginning of each turn.
function eye_of_the_storm(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the arena is clouds
	if (spar.currentArena == ARENAS.CLOUDS) {	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for set invulnerable nearby allies
		spar_effect_push_alert(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES, inst);
	}
}

//@desc ABILITY FUNCTION -- VEWRR
/// TYPE: ACTION ATTEMPT
/// This sprite takes increased damage for each curse on the field and deals
/// extra damage for all the blessings on the field
function tears_and_jeers(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the sparActionProcessor exists
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this is a damaging spell or a basic attack
			if (sparActionProcessor.spellPower > 0) 
			|| (sparActionProcessor.spellType < 0) {
				// check if this sprite is the target
				if (inst == sparActionProcessor.targetSprite) {
					// initialize the curseCount
					var curseCount = 0;
					
					// use a repeat loop to count the number of curses on the field
					var i = 0;	repeat (8) {
						// get the sprite instance
						var s = spar.spriteList[| i];
						
						// check if this sprite is cursed
						if (s.mindset >= MINDSETS.TREE_CURSE) {
							// increment curseCount
							curseCount++;
						}
						
						// increment i
						i++;
					}
					
					// check if curseCount is above 0
					if (curseCount > 0) {
						// increase the DMI by curseCount
						global.damageMultiplierIndex += curseCount;
						
						// push a spar effect alert for active ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for increased damage
						spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, sparActionProcessor.activeSprite);
					}
				}
				
				// check if this sprite is the attacker
				if (inst == sparActionProcessor.activeSprite) {
					// initialize the blessCount
					var blessCount = 0;
					
					// use a repeat loop to count the number of blessings on the field
					var i = 0;	repeat (8) {
						// get the sprite instance
						var s = spar.spriteList[| i];
					
						// check if this sprite is blessed
						if (s.mindset > 0)
						&& (s.mindset < MINDSETS.TREE_CURSE) {
							// increment blessCount
							blessCount++;
						}
					
						// increment i
						i++;
					}
						
					// check if blessCount is above 0
					if (blessCount > 0) {
						// increase the DMI by blessCount
						global.damageMultiplierIndex += blessCount;
						
						// push a spar effect alert for activate ability					
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for increased damage
						spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
					}
				}
			}
		}	
	}
}

///@desc ABILITY FUNCTION -- WYRMPOOL
/// TYPE: TURN END
/// If the ARENA is OCEAN, all of this sprite's nearby sprites will become
/// BOUND at the beginning of each turn.
function centripetal_force(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the arena is ocean
	if (spar.currentArena == ARENAS.OCEAN) {	
		// push a spar effect alert for activate ability
		spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
		// push a spar effect alert for set bound nearby sprites
		spar_effect_push_alert(SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES, inst);
	}
}

///@desc ABILITY FUNCTION -- DECIDRUID
/// TYPE: TURN START
/// This sprite automatically rests except on every 5th and 6th turn
function perennial_growth(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if this is either the fifth or sixth turn
	if (spar.turnCounter mod 5 <= 1) {
		// check if the sprite is immobilized
		if (inst.immobilized) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// push a spar effect alert for remove immobilized
			spar_effect_push_alert(SPAR_EFFECTS.REMOVE_IMMOBILIZED, inst);
		}
	}
	// if this is NOT the fifth or sixth turn
	else {
		// check if the sprite is not immobilized
		if !(inst.immobilized) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
			
			// push a spar effect alert for set immobilized
			spar_effect_push_alert(SPAR_EFFECTS.SET_IMMOBILIZED, inst);
		}
	}
}

///@desc ABILITY FUNCTION -- CENOTOMB
/// TYPE: ACTION SUCCESS
/// This sprite's attacks deal 1.5* damage while HEXED
function pure_malice(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {
				// check if it is a damaging spell or basic attack
				if (sparActionProcessor.currentSpell < 0) 
				|| (sparActionProcessor.spellPower > 0) {	
					// check if it is HEXED
						if (inst.hexed) {
						// multiply damage by 1.5
						sparActionProcessor.damage = round(sparActionProcessor.damage * 1.5);
						
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
						// push a spar effect alert for increase damage
						spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
					}
				}
			}
		}
	}	
}

///@desc ABILITY FUNCTION -- STEWARDRAKE
/// TYPE: ACTION SUCCESS
/// This sprite's teammates always take 0.85* damage
function guardian_angel(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if the target is on this sprite's team
			if (sparActionProcessor.targetSprite.team == inst.team) {
				// check if damage is greater than 0
				if  (sparActionProcessor.damage > 0) {
					// multiply damage by 0.75
					sparActionProcessor.damage = round(sparActionProcessor.damage * 0.85);
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for decrease damage
					spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE, sparActionProcessor.targetSprite);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- HECKID
/// TYPE: BASIC ATTACK SUCCESS
/// When this sprite attacks a teammate, the whole enemy team gets hexed
function dark_ritual(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the sparActionProcessor exists
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {
				// check if this is a basic attack
				if (sparActionProcessor.currentSpell < 0) {
					// check if the target is a teammate
					if (sparActionProcessor.targetSprite.team == inst.team) {
						// push a spar effect alert for activate ability
						spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
						
						// push a spar effect alert for set hexed global
						spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED_TEAM, inst.enemy);
					}
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- DOMINO
/// TYPE: ACTION SUCCESS
/// When this sprite hits another with a basic attack, that sprite
/// will take their place as target for the rest of the turn.
function ring_leader(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if this sprite is attacking
			if (inst == sparActionProcessor.activeSprite) {	
				// check if it is a basic attack
				if (sparActionProcessor.currentSpell < 0) {	
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
					// push a spar effect alert for replace target
					spar_effect_push_alert(SPAR_EFFECTS.REPLACE_TARGET, sparActionProcessor.targetSprite, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- ANACHRONAUT
/// TYPE: ACTION ATTEMPT
/// All ancient and time based spells will automatically fail when this
/// sprite is present
function time_police(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if it is a spell	
		if (sparActionProcessor.currentSpell >= 0) {
			// build ancientSpells list
			var l = ds_list_create();
			decode_list(global.ancientSpellList, l);
			
			// check if this spell is on the above list
			if (ds_list_find_index(l, sparActionProcessor.currentSpell) != -1) {				
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect alert for force spell failure
				spar_effect_push_alert(SPAR_EFFECTS.FORCE_SPELL_FAILURE, sparActionProcessor.activeSprite);
				
				// force spell to fail
				sparActionProcessor.spellFailed = true;
				
				// send the action processor straight to the apply damage phase 
				// (this is to skip the announcment that the spell failed since there
				// will be a notification along with the force spell failure effect alert
				sparActionProcessor.state = ACTION_PROCESSOR_STATES.APPLY_DAMAGE;
			}
			
			// destroy temp list
			ds_list_destroy(l);
		}
	}
}

///@desc ABILITY FUNCTION -- SHPUPO
/// TYPE: SPELL SUCCESS
/// This sprite ignores the secondary effect of all damaging SPELLS
function space_cadet(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if this sprite is the target
		if (inst == sparActionProcessor.targetSprite) {
			// check if it is a damaging spell
			if (sparActionProcessor.spellPower > 0) {
				// check if spellEffect is set
				if (sparActionProcessor.spellEffect > 0) {
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// set the spellEffect to -1
					sparActionProcessor.spellEffect = -1;
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- NEEDLEPAW
/// TYPE: ACTION ATTEMPT
/// This sprite forces all enemy sprites to have their LUCK locked at the
/// lowest possible value
function bad_omen(_inst) {
	// store args in locals
	var inst = _inst;
	
	// get the team opposing inst
	var t = -1;
	if (inst.team == player) {
		t = spar.playerTwo;	
	}	else {
		t = spar.playerOne;	
	}
	
	// push a spar effect for activate ability
	spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
	
	// push a spar effect alert for force worst luck team	
	spar_effect_push_alert(SPAR_EFFECTS.FORCE_WORST_LUCK_TEAM, t);
}

///@desc ABILITY FUNCTION -- OMNOST
/// TYPE: SPELL ATTEMPT
/// When this sprite casts ELEMENTAL SPELLS, the DMI is increased by 1. When
/// this sprite is targeted by ELEMENTAL SPELLS, the DMI is decreased by 1.
function all_knowing(_inst) {
	// store args in locals
	var inst = _inst;

	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if it is an elemental spell
			if (sparActionProcessor.spellType < SPELL_TYPES.PHYSICAL)
			&& (sparActionProcessor.spellType > 0) {
				// check if this sprite is attacking
				if (inst == sparActionProcessor.activeSprite) {
					// increase the DMI by 1
					global.damageMultiplierIndex++;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage	
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
				
				// check if this sprite is the target
				if (inst == sparActionProcessor.targetSprite) {
					// decrease the DMI by 1
					global.damageMultiplierIndex--;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for decrease damage
					spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- PRISMATTER
/// TYPE: ACTION ATTEMPT
/// When this sprite casts PHYSICAL SPELLS or uses BASIC ATTACKS, the DMI is 
/// increased by 1. When this sprite is targeted by PHYSICAL SPELLS or BASIC
/// ATTACKS, the DMI is decreased by 1.
function bend_physics(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if the sparActionProcessor exists
	if (instance_exists(sparActionProcessor)) {
		// ensure that this is not an out of range attack
		if !(sparActionProcessor.outOfRange) {
			// check if it is a physical spell or basic attack
			if (sparActionProcessor.spellType == SPELL_TYPES.PHYSICAL) 
			|| (sparActionProcessor.currentSpell < 0) {
				// check if this sprite is attacking
				if (inst == sparActionProcessor.activeSprite) {
					// increase the DMI by 1
					global.damageMultiplierIndex++;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for increase damage	
					spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE, inst);
				}
				
				// check if this sprite is the target
				if (inst == sparActionProcessor.targetSprite) {
					// decrease the DMI by 1
					global.damageMultiplierIndex--;
					
					// push a spar effect alert for activate ability
					spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
					
					// push a spar effect alert for decrease damage
					spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE, inst);
				}
			}
		}
	}
}

///@desc ABILITY FUNCTION -- KRONARC
/// TYPE: TURN PROCESS
/// This sprite always moves absolute first (before all priority spells)
function compress_time(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check that this sprite's team doesn't have synchronizedSoldiersActive
	if !(inst.team.synchronizedSoldiersActive) {
		// check if sprite has already taken it's turn
		if (spar.turnGrid[# SELECTION_PHASES.ACTION, inst.spotNum] != -1) {
			// push a spar effect alert for activate ability
			spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
		
			// push a spar effect alert for arbitrate turn
			spar_effect_push_alert(SPAR_EFFECTS.ARBITRATE_TURN, inst);
		}
	}
}

///@desc ABILITY FUNCTION -- COSMALCOS
/// TYPE: SPELL ATTEMPT
/// All SPELLS that target this sprite will automatically fail.
function end_of_days(_inst) {
	// store args in locals
	var inst = _inst;
	
	if (instance_exists(sparActionProcessor)) {
		// check if this sprite is the target
		if (inst == sparActionProcessor.targetSprite) 
		&& (inst != sparActionProcessor.activeSprite) {
			// check if it is a spell
			if (sparActionProcessor.currentSpell >= 0) {	
				// push a spar effect alert for activate ability
				spar_effect_push_alert(SPAR_EFFECTS.ACTIVATE_ABILITY, inst);
				
				// push a spar effect alert for force spell failure
				spar_effect_push_alert(SPAR_EFFECTS.FORCE_SPELL_FAILURE, sparActionProcessor.activeSprite);
				
				// force the spell to fail
				sparActionProcessor.spellFailed = true;
				
				// send the action processor straight to the apply damage phase 
				// (this is to skip the announcment that the spell failed since there
				// will be a notification along with the force spell failure effect alert
				sparActionProcessor.state = ACTION_PROCESSOR_STATES.APPLY_DAMAGE;
			}
		}
	}
}

#endregion

// get all text params from csv file
var textGrid = load_csv("ABILITIES_ENGLISH.csv");

// create abilityGrid
global.abilityGrid = ds_grid_create(ABILITY_PARAMS.HEIGHT, ABILITIES.HEIGHT);

// create master grid add function
function master_grid_add_ability(_ID) {
	// store args in locals
	var ID = _ID;
	
	// use a repeat loop to post all params to the grid
	var i = 0;	repeat (ABILITY_PARAMS.HEIGHT) {
		ds_grid_add(global.abilityGrid, i, ID, argument[i]);
		
		// increment
		i++;
	}
}
	
// add all abilities	ID									NAME												DESCRIPTION										TYPE									EFFECT FUNCTION					
master_grid_add_ability(ABILITIES.HOT_TO_THE_TOUCH,			textGrid[# 1, ABILITIES.HOT_TO_THE_TOUCH],			textGrid[# 2, ABILITIES.HOT_TO_THE_TOUCH],		ABILITY_TYPES.ACTION_SUCCESS,			hot_to_the_touch);
master_grid_add_ability(ABILITIES.WAVY_DANCE,				textGrid[# 1, ABILITIES.WAVY_DANCE],				textGrid[# 2, ABILITIES.WAVY_DANCE],			ABILITY_TYPES.ACTION_BEGIN,				wavy_dance);
master_grid_add_ability(ABILITIES.STORM_SURFER,				textGrid[# 1, ABILITIES.STORM_SURFER],				textGrid[# 2, ABILITIES.STORM_SURFER],			ABILITY_TYPES.ACTION_SUCCESS,			storm_surfer);
master_grid_add_ability(ABILITIES.NATURES_RECLAMATION,		textGrid[# 1, ABILITIES.NATURES_RECLAMATION],		textGrid[# 2, ABILITIES.NATURES_RECLAMATION],	ABILITY_TYPES.ACTION_SUCCESS,			natures_reclamation);
master_grid_add_ability(ABILITIES.BATTLE_INSTINCT,			textGrid[# 1, ABILITIES.BATTLE_INSTINCT],			textGrid[# 2, ABILITIES.BATTLE_INSTINCT],		ABILITY_TYPES.ACTION_BEGIN,				battle_instinct);
master_grid_add_ability(ABILITIES.UNBREAKABLE_SHELL,		textGrid[# 1, ABILITIES.UNBREAKABLE_SHELL],			textGrid[# 2, ABILITIES.UNBREAKABLE_SHELL],		ABILITY_TYPES.ACTION_SUCCESS,			unbreakable_shell);
master_grid_add_ability(ABILITIES.SUPERCHARGED,				textGrid[# 1, ABILITIES.SUPERCHARGED],				textGrid[# 2, ABILITIES.SUPERCHARGED],			ABILITY_TYPES.ACTION_SUCCESS,			supercharged);
master_grid_add_ability(ABILITIES.WELL_READ,				textGrid[# 1, ABILITIES.WELL_READ],					textGrid[# 2, ABILITIES.WELL_READ],				ABILITY_TYPES.TURN_BEGIN,				well_read);
master_grid_add_ability(ABILITIES.POWER_OF_FRIENDSHIP,		textGrid[# 1, ABILITIES.POWER_OF_FRIENDSHIP],		textGrid[# 2, ABILITIES.POWER_OF_FRIENDSHIP],	ABILITY_TYPES.ACTION_SUCCESS,			power_of_friendship);
master_grid_add_ability(ABILITIES.UNDERSEA_PREDATOR,		textGrid[# 1, ABILITIES.UNDERSEA_PREDATOR],			textGrid[# 2, ABILITIES.UNDERSEA_PREDATOR],		ABILITY_TYPES.ACTION_BEGIN,				undersea_predator);
master_grid_add_ability(ABILITIES.UNSTABLE_POWER,			textGrid[# 1, ABILITIES.UNSTABLE_POWER],			textGrid[# 2, ABILITIES.UNSTABLE_POWER],		ABILITY_TYPES.TURN_BEGIN,				unstable_power);
master_grid_add_ability(ABILITIES.FREE_REFILLS,				textGrid[# 1, ABILITIES.FREE_REFILLS],				textGrid[# 2, ABILITIES.FREE_REFILLS],			ABILITY_TYPES.TURN_END,					free_refills);
master_grid_add_ability(ABILITIES.REFLECTIVE_SURFACE,		textGrid[# 1, ABILITIES.REFLECTIVE_SURFACE],		textGrid[# 2, ABILITIES.REFLECTIVE_SURFACE],	ABILITY_TYPES.TURN_BEGIN,				reflective_surface);
master_grid_add_ability(ABILITIES.FLOWERY_SPIRIT,			textGrid[# 1, ABILITIES.FLOWERY_SPIRIT],			textGrid[# 2, ABILITIES.FLOWERY_SPIRIT],		ABILITY_TYPES.ACTION_BEGIN,				flowery_spirit);
master_grid_add_ability(ABILITIES.GIFT_OF_SONG,				textGrid[# 1, ABILITIES.GIFT_OF_SONG],				textGrid[# 2, ABILITIES.GIFT_OF_SONG],			ABILITY_TYPES.TURN_BEGIN,				gift_of_song);
master_grid_add_ability(ABILITIES.HANG_TEN,					textGrid[# 1, ABILITIES.HANG_TEN],					textGrid[# 2, ABILITIES.HANG_TEN],				ABILITY_TYPES.ACTION_SUCCESS,			hang_ten);
master_grid_add_ability(ABILITIES.TERRITORIAL_HUNTER,		textGrid[# 1, ABILITIES.TERRITORIAL_HUNTER],		textGrid[# 2, ABILITIES.TERRITORIAL_HUNTER],	ABILITY_TYPES.ACTION_BEGIN,				territorial_hunter);
master_grid_add_ability(ABILITIES.NATURAL_INGREDIENTS,		textGrid[# 1, ABILITIES.NATURAL_INGREDIENTS],		textGrid[# 2, ABILITIES.NATURAL_INGREDIENTS],	ABILITY_TYPES.ACTION_SUCCESS,			natural_ingredients);
master_grid_add_ability(ABILITIES.ABSORPTIVE_BODY,			textGrid[# 1, ABILITIES.ABSORPTIVE_BODY],			textGrid[# 2, ABILITIES.ABSORPTIVE_BODY],		ABILITY_TYPES.ACTION_SUCCESS,			absorptive_body);
master_grid_add_ability(ABILITIES.CREEP_OUT,				textGrid[# 1, ABILITIES.CREEP_OUT],					textGrid[# 2, ABILITIES.CREEP_OUT],				ABILITY_TYPES.SPRITE_RESTING,			creep_out);
master_grid_add_ability(ABILITIES.ENDLESS_WICK,				textGrid[# 1, ABILITIES.ENDLESS_WICK],				textGrid[# 2, ABILITIES.ENDLESS_WICK],			ABILITY_TYPES.ACTION_BEGIN,				endless_wick);
master_grid_add_ability(ABILITIES.ALL_SEEING_EYES,			textGrid[# 1, ABILITIES.ALL_SEEING_EYES],			textGrid[# 2, ABILITIES.ALL_SEEING_EYES],		ABILITY_TYPES.RANGE_CHECK,				all_seeing_eyes);	
master_grid_add_ability(ABILITIES.SORT_AWAY,				textGrid[# 1, ABILITIES.SORT_AWAY],					textGrid[# 2, ABILITIES.SORT_AWAY],				ABILITY_TYPES.ACTION_SUCCESS,			sort_away);
master_grid_add_ability(ABILITIES.SHORT_FUSE,				textGrid[# 1, ABILITIES.SHORT_FUSE],				textGrid[# 2, ABILITIES.SHORT_FUSE],			ABILITY_TYPES.TURN_END,					short_fuse);
master_grid_add_ability(ABILITIES.OFFER_REFUGE,				textGrid[# 1, ABILITIES.OFFER_REFUGE],				textGrid[# 2, ABILITIES.OFFER_REFUGE],			ABILITY_TYPES.ACTION_BEGIN,				offer_refuge);
master_grid_add_ability(ABILITIES.SIGNAL_JAMMER,			textGrid[# 1, ABILITIES.SIGNAL_JAMMER],				textGrid[# 2, ABILITIES.SIGNAL_JAMMER],			ABILITY_TYPES.TURN_BEGIN,				signal_jammer);
master_grid_add_ability(ABILITIES.SYNCHRONIZED_SOLDIERS,	textGrid[# 1, ABILITIES.SYNCHRONIZED_SOLDIERS],		textGrid[# 2, ABILITIES.SYNCHRONIZED_SOLDIERS],	ABILITY_TYPES.TURN_BEGIN,				synchronized_soldiers);
master_grid_add_ability(ABILITIES.HERBAL_CONCOCTION,		textGrid[# 1, ABILITIES.HERBAL_CONCOCTION],			textGrid[# 2, ABILITIES.HERBAL_CONCOCTION],		ABILITY_TYPES.APPLY_MIASMA,				herbal_concoction);
master_grid_add_ability(ABILITIES.HEALING_HAZE,				textGrid[# 1, ABILITIES.HEALING_HAZE],				textGrid[# 2, ABILITIES.HEALING_HAZE],			ABILITY_TYPES.SPRITE_RESTING,			healing_haze);
master_grid_add_ability(ABILITIES.AQUATIC_ESSENCE,			textGrid[# 1, ABILITIES.AQUATIC_ESSENCE],			textGrid[# 2, ABILITIES.AQUATIC_ESSENCE],		ABILITY_TYPES.SPRITE_RESTING,			aquatic_essence);
master_grid_add_ability(ABILITIES.FIERY_AURA,				textGrid[# 1, ABILITIES.FIERY_AURA],				textGrid[# 2, ABILITIES.FIERY_AURA],			ABILITY_TYPES.ACTION_BEGIN,				fiery_aura);
master_grid_add_ability(ABILITIES.THUNDROUS_CRY,			textGrid[# 1, ABILITIES.THUNDROUS_CRY],				textGrid[# 2, ABILITIES.THUNDROUS_CRY],			ABILITY_TYPES.ACTION_SUCCESS,			thundrous_cry);
master_grid_add_ability(ABILITIES.MASSIVE_BODY,				textGrid[# 1, ABILITIES.MASSIVE_BODY],				textGrid[# 2, ABILITIES.MASSIVE_BODY],			ABILITY_TYPES.ACTION_SUCCESS,			massive_body);
master_grid_add_ability(ABILITIES.UNDERDOG,					textGrid[# 1, ABILITIES.UNDERDOG],					textGrid[# 2, ABILITIES.UNDERDOG],				ABILITY_TYPES.ACTION_SUCCESS,			underdog);
master_grid_add_ability(ABILITIES.KEEPING_TIDY,				textGrid[# 1, ABILITIES.KEEPING_TIDY],				textGrid[# 2, ABILITIES.KEEPING_TIDY],			ABILITY_TYPES.TURN_END,					keeping_tidy);
master_grid_add_ability(ABILITIES.WRECKING_BALL,			textGrid[# 1, ABILITIES.WRECKING_BALL],				textGrid[# 2, ABILITIES.WRECKING_BALL],			ABILITY_TYPES.ACTION_SUCCESS,			wrecking_ball);
master_grid_add_ability(ABILITIES.DRIFT_AWAY,				textGrid[# 1, ABILITIES.DRIFT_AWAY],				textGrid[# 2, ABILITIES.DRIFT_AWAY],			ABILITY_TYPES.SPRITE_RESTING,			drift_away);
master_grid_add_ability(ABILITIES.TRICKSTER_FAERIE,			textGrid[# 1, ABILITIES.TRICKSTER_FAERIE],			textGrid[# 2, ABILITIES.TRICKSTER_FAERIE],		ABILITY_TYPES.ACTION_SUCCESS,			trickster_faerie);
master_grid_add_ability(ABILITIES.DUMPSTER_DIVER,			textGrid[# 1, ABILITIES.DUMPSTER_DIVER],			textGrid[# 2, ABILITIES.DUMPSTER_DIVER],		ABILITY_TYPES.MP_DEPLETED,				dumpster_diver);
master_grid_add_ability(ABILITIES.SPRING_LOADED,			textGrid[# 1, ABILITIES.SPRING_LOADED],				textGrid[# 2, ABILITIES.SPRING_LOADED],			ABILITY_TYPES.RANGE_CHECK,				spring_loaded);
master_grid_add_ability(ABILITIES.FLOOD_SHELTER,			textGrid[# 1, ABILITIES.FLOOD_SHELTER],				textGrid[# 2, ABILITIES.FLOOD_SHELTER],			ABILITY_TYPES.ACTION_BEGIN,				flood_shelter);
master_grid_add_ability(ABILITIES.PROPOGATE,				textGrid[# 1, ABILITIES.PROPOGATE],					textGrid[# 2, ABILITIES.PROPOGATE],				ABILITY_TYPES.TURN_BEGIN,				propogate);
master_grid_add_ability(ABILITIES.HEAVY_SLEEPER,			textGrid[# 1, ABILITIES.HEAVY_SLEEPER],				textGrid[# 2, ABILITIES.HEAVY_SLEEPER],			ABILITY_TYPES.SPRITE_RESTING,			heavy_sleeper);
master_grid_add_ability(ABILITIES.GET_ANGRY,				textGrid[# 1, ABILITIES.GET_ANGRY],					textGrid[# 2, ABILITIES.GET_ANGRY],				ABILITY_TYPES.TURN_END,					get_angry);
master_grid_add_ability(ABILITIES.GENERATOR,				textGrid[# 1, ABILITIES.GENERATOR],					textGrid[# 2, ABILITIES.GENERATOR],				ABILITY_TYPES.ACTION_BEGIN,				generator);
master_grid_add_ability(ABILITIES.DUAL_WIELD,				textGrid[# 1, ABILITIES.DUAL_WIELD],				textGrid[# 2, ABILITIES.DUAL_WIELD],			ABILITY_TYPES.ACTION_SUCCESS,			dual_wield);
master_grid_add_ability(ABILITIES.SHADOWY_FIEND,			textGrid[# 1, ABILITIES.SHADOWY_FIEND],				textGrid[# 2, ABILITIES.SHADOWY_FIEND],			ABILITY_TYPES.ACTION_BEGIN,				shadowy_fiend);
master_grid_add_ability(ABILITIES.METAL_MUNCHER,			textGrid[# 1, ABILITIES.METAL_MUNCHER],				textGrid[# 2, ABILITIES.METAL_MUNCHER],			ABILITY_TYPES.ACTION_SUCCESS,			metal_muncher);
master_grid_add_ability(ABILITIES.VOLCANIC_MASS,			textGrid[# 1, ABILITIES.VOLCANIC_MASS],				textGrid[# 2, ABILITIES.VOLCANIC_MASS],			ABILITY_TYPES.ACTION_SUCCESS,			volcanic_mass);
master_grid_add_ability(ABILITIES.EYE_OF_THE_STORM,			textGrid[# 1, ABILITIES.EYE_OF_THE_STORM],			textGrid[# 2, ABILITIES.EYE_OF_THE_STORM],		ABILITY_TYPES.TURN_BEGIN,				eye_of_the_storm);
master_grid_add_ability(ABILITIES.TEARS_AND_JEERS,			textGrid[# 1, ABILITIES.TEARS_AND_JEERS],			textGrid[# 2, ABILITIES.TEARS_AND_JEERS],		ABILITY_TYPES.ACTION_BEGIN,				tears_and_jeers);
master_grid_add_ability(ABILITIES.CENTRIPETAL_FORCE,		textGrid[# 1, ABILITIES.CENTRIPETAL_FORCE],			textGrid[# 2, ABILITIES.CENTRIPETAL_FORCE],		ABILITY_TYPES.TURN_END,					centripetal_force);
master_grid_add_ability(ABILITIES.PERENNIAL_GROWTH,			textGrid[# 1, ABILITIES.PERENNIAL_GROWTH],			textGrid[# 2, ABILITIES.PERENNIAL_GROWTH],		ABILITY_TYPES.TURN_BEGIN,				perennial_growth);
master_grid_add_ability(ABILITIES.PURE_MALICE,				textGrid[# 1, ABILITIES.PURE_MALICE],				textGrid[# 2, ABILITIES.PURE_MALICE],			ABILITY_TYPES.ACTION_SUCCESS,			pure_malice);
master_grid_add_ability(ABILITIES.GUARDIAN_ANGEL,			textGrid[# 1, ABILITIES.GUARDIAN_ANGEL],			textGrid[# 2, ABILITIES.GUARDIAN_ANGEL],		ABILITY_TYPES.ACTION_SUCCESS,			guardian_angel);
master_grid_add_ability(ABILITIES.DARK_RITUAL,				textGrid[# 1, ABILITIES.DARK_RITUAL],				textGrid[# 2, ABILITIES.DARK_RITUAL],			ABILITY_TYPES.ACTION_SUCCESS,			dark_ritual);
master_grid_add_ability(ABILITIES.RING_LEADER,				textGrid[# 1, ABILITIES.RING_LEADER],				textGrid[# 2, ABILITIES.RING_LEADER],			ABILITY_TYPES.ACTION_SUCCESS,			ring_leader);
master_grid_add_ability(ABILITIES.TIME_POLICE,				textGrid[# 1, ABILITIES.TIME_POLICE],				textGrid[# 2, ABILITIES.TIME_POLICE],			ABILITY_TYPES.ACTION_BEGIN,				time_police);
master_grid_add_ability(ABILITIES.SPACE_CADET,				textGrid[# 1, ABILITIES.SPACE_CADET],				textGrid[# 2, ABILITIES.SPACE_CADET],			ABILITY_TYPES.ACTION_SUCCESS,			space_cadet);
master_grid_add_ability(ABILITIES.BAD_OMEN,					textGrid[# 1, ABILITIES.BAD_OMEN],					textGrid[# 2, ABILITIES.BAD_OMEN],				ABILITY_TYPES.PROCESS_BEGIN,			bad_omen);
master_grid_add_ability(ABILITIES.ALL_KNOWING,				textGrid[# 1, ABILITIES.ALL_KNOWING],				textGrid[# 2, ABILITIES.ALL_KNOWING],			ABILITY_TYPES.ACTION_BEGIN,				all_knowing);
master_grid_add_ability(ABILITIES.BEND_PHYSICS,				textGrid[# 1, ABILITIES.BEND_PHYSICS],				textGrid[# 2, ABILITIES.BEND_PHYSICS],			ABILITY_TYPES.ACTION_BEGIN,				bend_physics);
master_grid_add_ability(ABILITIES.COMPRESS_TIME,			textGrid[# 1, ABILITIES.COMPRESS_TIME],				textGrid[# 2, ABILITIES.COMPRESS_TIME],			ABILITY_TYPES.PRIORITY_CHECK,			compress_time);
master_grid_add_ability(ABILITIES.END_OF_DAYS,				textGrid[# 1, ABILITIES.END_OF_DAYS],				textGrid[# 2, ABILITIES.END_OF_DAYS],			ABILITY_TYPES.ACTION_BEGIN,				end_of_days);

// encode the ability grid
global.allAbilities = encode_grid(abilityGrid);

// destroy the ability grid and textGrid
ds_grid_destroy(global.abilityGrid);
ds_grid_destroy(textGrid);