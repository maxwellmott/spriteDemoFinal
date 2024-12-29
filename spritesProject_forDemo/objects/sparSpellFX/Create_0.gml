/// @description Insert description here
// You can write your code in this editor

// check if spell failed
if !(instance_exists(sparActionProcessor)) 
|| (sparActionProcessor.spellFailed) {
	instance_destroy(id);	
}

drawX = -1;
drawY = -1;

// get target
target = sparActionProcessor.targetSprite;

// get spellID
spellID = sparActionProcessor.currentSpell;

#region BASIC ATTACK
if (spellID < 0) {	
	// set spellFX function
	spellFX = -1;
	
	// set spellAnimation
	spellAnimation = spr_spellFX_basicAttack;
	
	// get frameCount
	frameCount = sprite_get_number(spellAnimation) - 1;
	
	// set animation built-ins for spar object
	spar.sprite_index = spellAnimation;
	spar.image_speed = 1;
	spar.image_index = 0;
	
	// set the positioning for the animation
	drawX = target.x;
	drawY = target.y;
}
#endregion 

#region SPELLS
if (spellID >= 0) {
// decode spellFX list
var list = ds_list_create();
decode_list(global.allSpellFX, list);

// get spellFX function
spellFX = list[| spellID];

// destroy temp list
ds_list_destroy(list);

// decode spell animation list
var list = ds_list_create();
decode_list(global.allSpellAnimations, list);

// get the animation sprite
spellAnimation = real(string_digits(list[| spellID]));

// destroy temp list
ds_list_destroy(list);

// set animation built-ins for spar object
spar.sprite_index = spellAnimation;
spar.image_speed = 1;
spar.image_index = 0;

// check the size of the animation to determine it's positioning
if (sprite_get_width(spellAnimation) == 64)	{
	drawX = target.x;		drawY = target.y;	
}

if (sprite_get_width(spellAnimation) == 256) {
	drawX = guiWidth / 2;	drawY = guiHeight / 2;	
}
}
#endregion