/// @description Insert description here
// You can write your code in this editor

action = instance_count - 1;

sprite = player.selectedAlly;

selected = false;

name = "";

switch (action) {
	case sparActions.attack:	name = "ATTACK";	break;
	
	case sparActions.spell:		name = "SPELL";		break;
	
	case sparActions.dodge:		name = "DODGE";		break;
	
	case sparActions.swap:		name = "SWAP";		break;
	
	case sparActions.meditate:	name = "MEDITATE";	break;
}

