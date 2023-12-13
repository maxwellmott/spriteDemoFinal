/// @description Insert description here
// You can write your code in this editor

sprite = spr_spellBook;

frame		= 0;
frameMax	= 5;

spriteWidth		= sprite_get_width(sprite);
spriteHeight	= sprite_get_height(sprite);

x = 0 - (spriteWidth / 2);
y = (guiHeight / 2) - 8;

index = 0;

currentSpell = player.spellBook[| index];

//spellbook_load_params();

pageFlip = false;

flipRight	= false;
flipLeft	= false;

targetX = spriteWidth / 2;

nextPhase = -1;

flipFrame	= 0;
flipMax		= 1;

modVar = 6;

drawFlip = false;