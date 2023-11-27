/// @description Insert description here
// You can write your code in this editor

// set allyNum
allyNum = instance_count;

// set spotNum
spotNum = instance_count;

// set spriteID
spriteID = player.team[|allyNum];

// add self to battle sprite lists

// set x and y
x = (64 * allyNum) - 32;
y = guiHeight - 48;

// initialize name
name = "";

// initialize sprite
sprite = -1;

// initialize usable SPELLS
usable_spells = ds_list_create();

// initialize ability
ability = noone;

// initialize alignment
alignment = -1;

// initialize size
size = -1;

// initialize stats
attack	= -1;
resist	= -1;
agility = -1;
luck	= -1;
fire	= -1;
water	= -1;
storm	= -1;
earth	= -1;

// load sprite parameters
sprite_load_parameters();

// initialize mindset
mindset = -1;

// initialize bound and hexed
bound = false;
hexed = false;

// set sprite_index as sprite
sprite_index = sprite;

// initialize selectedTarget and selectedAction
selectedTarget = -1;
selectedAction = -1;