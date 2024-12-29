/// @description Insert description here
// You can write your code in this editor

if (instance_exists(sparActionProcessor))
&& !(sparActionProcessor.spellFailed) {
	sparActionProcessor.state = ACTION_PROCESSOR_STATES.DISPLAY_MSG;		
}

global.spellTargetTeam = -4;