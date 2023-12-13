/// @description Insert description here
// You can write your code in this editor

sprite = spr_spellBook;

spriteWidth		= sprite_get_width(sprite);
spriteHeight	= sprite_get_height(sprite);

x = 0 - (spriteWidth / 2);
y = (guiHeight / 2) - 8;

index = 0;

currentSpell = player.spellBook[| index];

pageFlip = false;

name			= player.spellBookGrid[# SPELL_PARAMS.NAME,			currentSpell];
description		= player.spellBookGrid[# SPELL_PARAMS.DESCRIPTION,	currentSpell];
spellPower		= player.spellBookGrid[# SPELL_PARAMS.POWER,		currentSpell];
spellType		= player.spellBookGrid[# SPELL_PARAMS.TYPE,			currentSpell];
spellRange		= player.spellBookGrid[# SPELL_PARAMS.RANGE,		currentSpell];

targetX = spriteWidth / 2;