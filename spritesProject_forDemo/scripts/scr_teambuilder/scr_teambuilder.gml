enum BUILDER_SCORES {
	GOOD,
	OKAY,
	BAD,
	HEIGHT	
}

function teambuilder_stat_coverage_calculate_score() {
	var totalPower			= 0;
	var totalResistance		= 0;
	var totalFire			= 0;
	var totalWater			= 0;
	var totalStorm			= 0;
	var totalEarth			= 0;

	var i = 0;	repeat (ds_list_size(teamList)) {
		var sid = teamList[| i];
		
		var p = real(spriteGrid[# SPRITE_PARAMS.POWER,		sid]);
		var r = real(spriteGrid[# SPRITE_PARAMS.RESISTANCE,	sid]);
		var f = real(spriteGrid[# SPRITE_PARAMS.FIRE,		sid]);
		var w = real(spriteGrid[# SPRITE_PARAMS.WATER,		sid]);
		var s = real(spriteGrid[# SPRITE_PARAMS.STORM,		sid]);
		var e = real(spriteGrid[# SPRITE_PARAMS.EARTH,		sid]);
		
		totalPower		+= p;
		totalResistance += r;
		totalFire		+= f;
		totalWater		+= w;
		totalStorm		+= s;
		totalEarth		+= e;
		
		i++;
	}
	
	var avgPower		= totalPower / 4;
	var avgResistance	= totalResistance / 4;
	var avgFire			= totalFire / 4;
	var avgWater		= totalWater / 4;
	var avgStorm		= totalStorm / 4;
	var avgEarth		= totalEarth / 4;
	
	var points = 0;
	var possiblePoints = 18;
	
	if (avgPower		>= 80)		points += 2;
	if (avgResistance	>= 80)		points += 2;
	if (avgFire			>= 80)		points += 2;
	if (avgWater		>= 80)		points += 2;
	if (avgStorm		>= 80)		points += 2;
	if (avgEarth		>= 80)		points += 2;
	
	if (avgPower		>= 120)		points += 1;
	if (avgResistance	>= 120)		points += 1;
	if (avgFire			>= 120)		points += 1;
	if (avgWater		>= 120)		points += 1;
	if (avgStorm		>= 120)		points += 1;
	if (avgEarth		>= 120)		points += 1;	
	
	var finalScore = points / possiblePoints;
	
	statCoverageScore = BUILDER_SCORES.GOOD;
	if (finalScore < 0.6)	statCoverageScore = BUILDER_SCORES.OKAY;
	if (finalScore < 0.4)	statCoverageScore = BUILDER_SCORES.BAD;
}

function teambuilder_spellbook_usage_calculate_score() {
	var sb = ds_list_create();
	
	decode_list(player.spellBookString, sb);
	
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	
	var points = 0;
	var possiblePoints = 0;
	
	// for each sprite
	var i = 0;	repeat (ds_list_size(teamList)) {
		var usbl = ds_list_create();
		decode_list(spriteGrid[# SPRITE_PARAMS.SPELL_LIST, teamList[| i]], usbl);
		
		// for each spell in spellbook
		var j = 0;	repeat (ds_list_size(sb)) {
			var spl = real(sb[| j]);
			
			if (ds_list_find_index(usbl, spl) != -1) {
				points++;	
			}
			
			possiblePoints++;
			
			j++;
		}
		
		
		i++;
	}
	
	var finalScore = points / possiblePoints;
	
	spellUsageScore = BUILDER_SCORES.GOOD;
	if (finalScore < 0.75)	spellUsageScore = BUILDER_SCORES.OKAY;
	if (finalScore < 0.4)	spellUsageScore = BUILDER_SCORES.BAD;
	
	ds_grid_destroy(grid);
	ds_list_destroy(sb);
	ds_list_destroy(usbl);
}