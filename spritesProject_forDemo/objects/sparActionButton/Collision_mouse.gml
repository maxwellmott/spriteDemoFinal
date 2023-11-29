/// @description Insert description here
// You can write your code in this editor

// set selectedButton and index to match the button being hovered over
sparActionMenu.selectedButton = id;
sparActionMenu.index = action;

// if the mouse is clicked, set the action
if (global.click) {
	spar_set_action();
}