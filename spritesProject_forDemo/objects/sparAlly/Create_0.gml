/// @description Insert description here
// You can write your code in this editor

// initialize alpha
alpha = 1.0;

// set allyNum
allyNum = instance_number(object_index) - 1;

// set spotNum
spotNum = allyNum;

// set spriteID
spriteID = player.teamList[| allyNum];

// add self to battle sprite lists
spar.allyList[| allyNum]	= id;
spar.spriteList[| spotNum]	= id;

// set x and y
x = (64 * allyNum) + 32;
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

// initialize mindset (set to 0 since negative IDs= curses)
mindset = 0;

// initialize bound and hexed
bound = false;
hexed = false;

// set sprite_index as sprite
sprite_index = sprite;

// initialize selectedTarget and selectedAction
selectedTarget = -1;
selectedAction = -1;

// set bbox dimensions
bbBottom	= y + 32;
bbTop		= y - 32;
bbLeft		= x - 32;
bbRight		= x + 32;

// initialize draw positions for indicators
hexedY		= x - 16;
mindsetY	= x;
boundX		= x + 16;

boundY		= guiHeight - 88;
hexedY		= guiHeight - 88;
mindsetY	= guiHeight - 88;