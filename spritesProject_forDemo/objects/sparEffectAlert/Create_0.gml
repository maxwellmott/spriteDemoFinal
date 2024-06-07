/// @description Insert description here
// You can write your code in this editor

subject = "";
object = "";

effectedPlayer = -1;

effectedSprites = ds_list_create();

alertString = spar.effectAlertList[| 0];

alertParams = ds_list_create();

decode_list(alertString, alertParams);

effectID = alertParams[| 0];

effect_alert_get_args();

var effectGrid = ds_grid_create(SPAR_EFFECT_PARAMS.HEIGHT, SPAR_EFFECTS.HEIGHT);

decode_grid(global.allSparEffects, effectGrid);

effectFunction	= effectGrid[# SPAR_EFFECT_PARAMS.EFFECT_FUNCTION,	effectID];
alertText		= effectGrid[# SPAR_EFFECT_PARAMS.ALERT_TEXT,		effectID];
animation		= effectGrid[# SPAR_EFFECT_PARAMS.ANIMATION,		effectID];

if (ds_list_size(alertParams) == 5) {
	execute_arguments(effectFunction, global.argumentList[| 0], global.argumentList[| 1],
					global.argumentList[| 2], global.argumentList[| 3]);
}

if (ds_list_size(alertParams) == 4) {
	execute_arguments(effectFunction, global.argumentList[| 0], global.argumentList[| 1],
					global.argumentList[| 2]);
}

if (ds_list_size(alertParams) == 3) {
	execute_arguments(effectFunction, global.argumentList[| 0],
					global.argumentList[| 1]);
}

if (ds_list_size(alertParams) == 2) {
	execute_arguments(effectFunction, global.argumentList[| 0]);
}	

if (ds_list_size(alertParams) == 1) {
	execute(effectFunction);	
}

spar.turnMsg = alertText;