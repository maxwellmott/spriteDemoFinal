/// @description Insert description here
// You can write your code in this editor

// get action ID
action = instance_number(object_index) - 1;

// get selectedally
sprite = player.selectedAlly;

// initialize name
name = "";

// get name and x position using action ID
switch (action) {
	case SPAR_ACTIONS.ATTACK:	
		name = "ATTACK";
		x = 32;
	break;
	
	case SPAR_ACTIONS.SPELL:		
		name = "SPELL";	
		x = 80;
	break;
	
	case SPAR_ACTIONS.DODGE:	
		name = "DODGE";
		x = 128;
	break;
	
	case SPAR_ACTIONS.SWAP:
		name = "SWAP";
		x = 176;
	break;
	
	case SPAR_ACTIONS.REST:
		name = "REST";
		x = 224;
	break;
}

// set y
y = 118;

// add id to list of action buttons
sparActionMenu.actionButtons[| action] = id;

// initialize frame
frame = 0;

// initialize bbox dimensions
var spriteHeight	= sprite_get_height(spr_sparActionButton);
var spriteWidth		= sprite_get_height(spr_sparActionButton);

bboxBottom	= y + (spriteHeight / 2);
bboxTop		= y - (spriteHeight / 2);
bboxLeft	= x - (spriteHeight / 2);
bboxRight	= x + (spriteHeight / 2);

textColor = COL_BLACK;