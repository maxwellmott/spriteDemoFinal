/// @description Insert description here
// You can write your code in this editor

// check if either player has lost
if (spar_check_complete()) {
	create_once(0, 0, LAYER.meta, winLoseDisplay);	
}

drawReady = false;

subject = "";
object = "";

effectedPlayer = -1;

effectedSprites = ds_list_create();

alertString = spar.effectAlertList[| 0];

alertParams = ds_list_create();

decode_list(alertString, alertParams);

effectID = real(alertParams[| 0]);

effect_alert_get_args();

var effectGrid = ds_grid_create(SPAR_EFFECT_PARAMS.HEIGHT, SPAR_EFFECTS.HEIGHT);

decode_grid(global.allSparEffects, effectGrid);

effectFunction	= real(string_digits(effectGrid[# SPAR_EFFECT_PARAMS.EFFECT_FUNCTION,				effectID]));
alertText		= effectGrid[# SPAR_EFFECT_PARAMS.ALERT_TEXT,										effectID];
animation		= real(string_digits(effectGrid[# SPAR_EFFECT_PARAMS.ANIMATION,						effectID]));

if (ds_list_size(alertParams) == 5) {
	effectFunction(global.argumentList[| 0], global.argumentList[| 1], global.argumentList[| 2], global.argumentList[| 3]);
}

if (ds_list_size(alertParams) == 4) {
	effectFunction(global.argumentList[| 0], global.argumentList[| 1], global.argumentList[| 2]);
}

if (ds_list_size(alertParams) == 3) {
	effectFunction(global.argumentList[| 0], global.argumentList[| 1]);
}

if (ds_list_size(alertParams) == 2) {
	effectFunction(global.argumentList[| 0]);
}	

if (ds_list_size(alertParams) == 1) {
	effectFunction();
}

effect_alert_build_text();

spar.turnMsg = alertText;

entireField = false;
drawingMultiple = false;

if (effectedPlayer >= 0) {
	entireField = true;
}
else {
	if (ds_list_size(effectedSprites) > 1)	drawingMultiple = true;
}

drawX = -1;
drawY = -1;

if !(drawingMultiple) {
	if (ds_list_size(effectedSprites) == 1) {
		drawX = effectedSprites[| 0].x;
		drawY = effectedSprites[| 0].y;
	}
	
	if (effectedPlayer != -1) {
		if (effectedPlayer == spar.playerOne) {
			drawX = 0;
			drawY = guiHeight - 128;
		}
		
		if (effectedPlayer == spar.playerTwo) {
			drawX = 0;
			drawY = 64;
		}
		
		if (effectedPlayer == BOTH_PLAYERS_EFFECTED) {
			drawX = 0;
			drawY = 0;
		}
	}
}

// set the alarm that will start the animation if there is one or 
// destroy the alert if there isn't one
alarm[0] = 60;