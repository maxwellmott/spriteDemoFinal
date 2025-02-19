/// @description Insert description here
// You can write your code in this editor

sprite = spr_spellBook;
infoDisplaySprite = spr_sparSpellInfoDisplay;

usableSpells = player.selectedAlly.usableSpells;

frame		= 0;
frameMax	= 5;

spriteWidth		= sprite_get_width(sprite);
spriteHeight	= sprite_get_height(sprite);

descWidth = 240;

x = 0 - (spriteWidth / 2);
y = (guiHeight / 2) - 8;

index = 0;

currentSpell = player.spellBookList[| index];

name			=	"";
description		=	"";
spellType		=	-1;
spellRange		=	-1;
spellPower		=	0;
spellCost		=	0;

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

spellBookHeight = ds_list_size(player.spellBookList);

// spar spell info display params

// initialize info display x and y 
var idsw = sprite_get_width(infoDisplaySprite);

infoBannerWidth = idsw - 4;

infoDisplayX = (idsw / 2) + spriteWidth + 4;
infoDisplayY = (guiHeight / 2);

// initialize info display alpha
infoDisplayAlpha = 0.0;

// initialize draw positions for spell params
rangeDrawX = infoDisplayX - (idsw / 2) + 31;
rangeDrawY = infoDisplayY - 14;

powerDrawX = rangeDrawX + 41;
powerDrawY = rangeDrawY - 2;

costDrawX = powerDrawX + 39;
costDrawY = powerDrawY;

typeDrawX = costDrawX + 40;
typeDrawY = rangeDrawY;

descDrawX = infoDisplayX - 86;
descDrawY = infoDisplayY - 16;