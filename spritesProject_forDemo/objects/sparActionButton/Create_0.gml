/// @description Insert description here
// You can write your code in this editor

// get action ID
action = instance_count - 1;

// get selectedally
sprite = player.selectedAlly;

// initialize name
name = "";

// get name and x position using action ID
switch (action) {
	case sparActions.attack:	
		name = "ATTACK";
		x = 32;
	break;
	
	case sparActions.spell:		
		name = "SPELL";	
		x = 80;
	break;
	
	case sparActions.dodge:	
		name = "DODGE";
		x = 128;
	break;
	
	case sparActions.swap:
		name = "SWAP";
		x = 176;
	break;
	
	case sparActions.meditate:
		name = "MEDITATE";
		x = 224;
	break;
}

// set y
y = 118;

// add id to list of action buttons
sparActionMenu.actionButtons[| action] = id;