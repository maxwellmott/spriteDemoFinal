/// @description Insert description here
// You can write your code in this editor

// handle right key input
if (global.menu_right) {
	index++;
	
	if (index >= sparActions.height) index = 0;
	
	selectedButton = actionButtons[| index];
}

// handle left key input
if (global.menu_left) {
	index--;
	
	if (index < 0) index = sparActions.height - 1;
	
	selectedButton = actionButtons[| index];
}

// handle backspace input
if (global.back) {
	spar.potentialCost = 0;
	player.selectedAlly = -1;
	spar.selectionPhase = SELECTION_PHASES.ALLY;
	instance_destroy(self);
}