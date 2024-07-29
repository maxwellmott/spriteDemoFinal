/// @description Insert description here
// You can write your code in this editor

global.mpCostDiff = 0;

// check if selected sprite has already selected a spell this turn
if (player.selectedAlly.selectedAction >= sparActions.height) {
	global.mpCostDiff = spell_get_cost(player.selectedAlly.selectedAction - sparActions.height);
}

if (player.selectedAlly.selectedAction == sparActions.swap) {
	global.mpCostDiff = swap_get_cost(player.selectedAlly, spar.allyList[| player.selectedAlly.selectedTarget]);	
}

sprite = spr_spellBook;
infoDisplaySprite = spr_sparSpellInfoDisplay;

usable_spells = player.selectedAlly.usable_spells;

frame		= 0;
frameMax	= 5;

spriteWidth		= sprite_get_width(sprite);
spriteHeight	= sprite_get_height(sprite);

descWidth = 240;

x = 0 - (spriteWidth / 2);
y = (guiHeight / 2) - 8;

index = 0;

currentSpell = player.spellBook[| index];

name			=	"";
description		=	"";
spellType		=	-1;
spellRange		=	-1;
spellPower		=	0;
spellCost		=	0;

enoughMP = false;

spellbook_load_spell_params();

pageFlip = false;

flipRight	= false;
flipLeft	= false;

targetX = spriteWidth / 2;

nextPhase = -1;

flipFrame	= 0;
flipMax		= 1;

modVar = 6;

drawFlip = false;

// spar spell info display params

// initialize info display x and y 
var idsw = sprite_get_width(infoDisplaySprite);

infoDisplayX = (idsw / 2) + spriteWidth + 4;
infoDisplayY = (guiHeight / 2);

// initialize info display alpha
infoDisplayAlpha = 0.0;

// initialize draw positions for spell params 
rangeDrawX = infoDisplayX - (idsw / 2) + 31;
rangeDrawY = infoDisplayY - 14;

powerDrawX = rangeDrawX + 41;
powerDrawY = rangeDrawY + 2;

costDrawX = powerDrawX + 39;
costDrawY = powerDrawY;

typeDrawX = costDrawX + 40;
typeDrawY = rangeDrawY;

descDrawX = infoDisplayX - 86;
descDrawY = infoDisplayY - 7;