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
						var bestTarget = -1;
						var highestScore = 0;
						
						// determine the highestScore
						if (physScore > highestScore)	highestScore = physScore;	bestSpell = bestPhysSpell;	bestTarget = bestPhysTarg;
						if (fireScore > highestScore)	highestScore = fireScore;	bestSpell = bestFireSpell;	bestTarget = bestFireTarg;
						if (earthScore > highestScore)	highestScore = earthScore;	bestSpell = bestEarthSpell;	bestTarget = bestEarthTarg;
						
						// find the index of the spell on the spellBookGrid
						var ind = ds_grid_value_y(spellBookGrid, 0, 0, 0, ds_grid_height(spellBookGrid), bestSpell);
						
						// check if the cost of the spell is greater than the current mp of the team
						if (spellBookGrid[# SPELL_PARAMS.COST, ind] > currentMP) {
							// check if the cost of the spell is more than 1 rest's worth of MP away
							if (abs(currentMP - spellBookGrid[# SPELL_PARAMS.COST, ind]) > REST_BASE_MP_REGEN) {
								// get the best spell within the current MP
								var mpSpell = enemy_ai_get_strongest_spell_within_mp(inst);
								var mpSpellDamage = global.bestDamage;
								var mpSpellTarget = global.bestTargetID;
								
								// get the best target for a basic attack
								var bestBasicAttackTarget = enemy_ai_get_best_basic_attack_target(inst);
								var bestBasicAttackDamage = global.bestDamage;
								
								// check if mpSpellDamage is above 0
								if (mpSpellDamage > 0) {
									// get the score of the mpSpell
									var mpSpellScore = mpSpellDamage / bestBasicAttackDamage;
									
									// check if the mpSpellScore warrants using this spell
									if (mpSpellScore >= 1.2) {
										inst.selectedAction = mpSpell;
										inst.selectedTarget = mpSpellTarget;
									}
									// if the mpSpellScore does NOT warrant using this spell
									else {
										inst.selectedAction = sparActions.attack;
										inst.selectedTarget = bestBasicAttackTarget;
									}
								}
							}
							// if the cost of the spell is not more than 1 rest's worth of MP away
							else {
								// get the sprite who is the least endangered
								var safest = enemy_ai_get_least_endangered_sprite(osl);
								
								// check that the safest sprite is NOT swapping
								if (safest.selectedAction != sparActions.swap) {
									safest.selectedAction = sparActions.rest;
									safest.selectedTarget = -1;
									
									// set this sprite to cast the best spell
									inst.selectedAction = bestSpell + sparActions.height;
									inst.selectedTarget = bestTarget;
								}
								else {
									// get the best spell within the current MP
									var	mpSpell = enemy_ai_get_strongest_spell_within_mp(inst);
									var mpSpellDamage = global.bestDamage;
									var mpSpellTarget = global.bestTargetID;
									
									// get the best target for a basic attack
									var bestBasicAttackTarget = enemy_ai_get_best_basic_attack_target(inst);
									var bestBasicAttackDamage = global.bestDamage;
									
									if (mpSpellDamage > 0) {
										var mpSpellScore = mpSpellDamage / bestBasicAttackDamage;
										
										if (mpSpellScore >= 1.2) {
											inst.selectedAction = mpSpell;
											inst.selectedTarget = mpSpellTarget;
										}
										else {
											inst.selectedAction = sparActions.attack;
											inst.selectedTarget = bestBasicAttackTarget;
										}
									}
								}
							}
						}	
						else {
							// set this sprite to use bestSpell
							inst.selectedAction = bestSpell + sparActions.height;
							inst.selectedTarget = bestTarget;
						}
					}
					// if this sprite IS in danger
					else {
						// get the best swap for this sprite
						var bestSwapper = enemy_ai_get_best_swap_partner(inst);
						
						// check to make sure this sprite is not already swapping
						if (bestSwapper.selectedAction != sparActions.swap) {
							// set this sprite to swap
							inst.selectedAction = sparActions.swap;
							inst.selectedTarget = bestSwapper.spotNum;
							
							// set the swap partner to swap
							bestSwapper.selectedAction = sparActions.swap;
							bestSwapper.selectedTarget = inst.spotNum;
						}
						// if this sprite is already swapping
						else {
							// find this sprite's current swap partner
							
							// get the swap partner's danger level
							
							// get this sprite's danger level
							
							// if this sprite is in more danger than the other
								// set the other sprite to rest this turn
								
								// set this sprite to swap with bestSwapper
								
								// set bestSwapper to swap with this sprite
							// if this sprite is in LESS danger than the other
								// get the best basic attack
								
								// check if the best basic attack would deal substantial damage
									// set this sprite to use the best basic attack
									
								// if this basic attack would NOT deal substantial damage
									// set this sprite to rest this turn
								
						}
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