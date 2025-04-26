/// @description Insert description here
// You can write your code in this editor

xList = ds_list_create();
yList = ds_list_create();

effectedSprites = ds_list_create();

// check if either player has lost
if (spar_check_complete()) {
	create_once(0, 0, LAYER.meta, winLoseDisplay);	
}

drawReady = false;

subject = "";
object = "";

effectedPlayer = -1;

alertString = spar.effectAlertList[| 0];

alertParams = ds_list_create();

decode_list(alertString, alertParams);

effectID = real(alertParams[| 0]);

effect_alert_get_args();

var effectGrid = ds_grid_create(SPAR_EFFECT_PARAMS.HEIGHT, SPAR_EFFECTS.HEIGHT);

decode_grid(global.allSparEffects, effectGrid);

effectFunction	= correct_string_after_decode(effectGrid[# SPAR_EFFECT_PARAMS.EFFECT_FUNCTION,				effectID]);
alertText		= effectGrid[# SPAR_EFFECT_PARAMS.ALERT_TEXT,										effectID];
animation		= correct_string_after_decode(effectGrid[# SPAR_EFFECT_PARAMS.ANIMATION,						effectID]);

if (ds_list_size(alertParams) == 5) {
	script_execute(effectFunction, global.argumentList[| 0], global.argumentList[| 1], global.argumentList[| 2], global.argumentList[| 3]);
}

if (ds_list_size(alertParams) == 4) {
	script_execute(effectFunction, global.argumentList[| 0], global.argumentList[| 1], global.argumentList[| 2]);
}

if (ds_list_size(alertParams) == 3) {
	script_execute(effectFunction, global.argumentList[| 0], global.argumentList[| 1]);
}

if (ds_list_size(alertParams) == 2) {
	script_execute(effectFunction, global.argumentList[| 0]);
}	

if (ds_list_size(alertParams) == 1) {
	effectFunction();
}

effect_alert_build_text();

spar.turnMsg = alertText;

if (ds_exists(effectedSprites, ds_type_list)) {
	if (ds_list_size(effectedSprites) > 0) {
		var i = 0;	repeat (ds_list_size(effectedSprites)) {
			xList[| i] = effectedSprites[| i].x;
			yList[| i] = effectedSprites[| i].y;
		
			i++;
		}
	}
}

if (effectID != SPAR_EFFECTS.ARENA_CHANGE_VOLCANO)
&& (effectID != SPAR_EFFECTS.ARENA_CHANGE_OCEAN)
&& (effectID != SPAR_EFFECTS.ARENA_CHANGE_CLOUDS)
&& (effectID != SPAR_EFFECTS.ARENA_CHANGE_FOREST)
&& (effectID != SPAR_EFFECTS.DESTROY_ARENA) {	
	if (effectedPlayer == BOTH_PLAYERS_EFFECTED) {
		if (ds_exists(xList, ds_type_list)) {
			xList[| 0] = spar.playerOne.x;
			xList[| 1] = spar.playerTwo.x;
	
			yList[| 0] = spar.playerOne.y;
			yList[| 1] = spar.playerTwo.y;
		}
	}
	else if (effectedPlayer == spar.playerOne) {
		if (ds_exists(xList, ds_type_list)) {
			xList[| 0] = spar.playerOne.x;
			yList[| 0] = spar.playerOne.y;
		}
	}
	else if (effectedPlayer == spar.playerTwo) {
		if (ds_exists(xList, ds_type_list)) {
			xList[| 0] = spar.playerTwo.x;
			yList[| 1] = spar.playerTwo.y;
		}
	}
}
else {
	if (ds_exists(xList, ds_type_list)) {
		xList[| 0] = 0;
		xList[| 1] = guiWidth / 4;	
		xList[| 2] = guiWidth / 2;	
		xList[| 3] = guiWidth * 0.75;
		
		yList[| 0] = guiHeight / 2;
		yList[| 1] = guiHeight / 2;
		yList[| 2] = guiHeight / 2;
		yList[| 3] = guiHeight / 2;
	}
}

// set the alarm that will start the animation if there is one or 
// destroy the alert if there isn't one
alarm[0] = 90;