/// @description Insert description here
// You can write your code in this editor

frame = 0;

spriteHeight	= sprite_get_height(spr_sparReadyButton);
spriteWidth		= sprite_get_width(spr_sparReadyButton);

bboxLeft	= 0;
bboxTop		= (guiHeight / 2) - (spriteHeight / 2);
bboxRight	= guiWidth;
bboxBottom	= (guiHeight / 2) + (spriteHeight / 2);

x1 = 0;
x2 = x1 + spriteWidth;
x3 = x2 + spriteWidth;
x4 = x3 + spriteWidth;
x5 = x4 + spriteWidth;
x6 = x5 + spriteWidth;
x7 = x6 + spriteWidth;
x8 = x7 + spriteWidth;

y = guiHeight / 2;