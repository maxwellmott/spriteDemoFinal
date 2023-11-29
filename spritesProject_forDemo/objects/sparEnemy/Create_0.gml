/// @description Insert description here
// You can write your code in this editor

// set allyNum
allyNum = instance_count - 1;

// set spotNum (increase by 3 to account for the +4 for enemy nums
// and the -1 due to 0 index)
spotNum = instance_count + 3;

// set spriteID
spriteID = global.opponent.team[|allyNum];

// add self to battle sprite lists
ds_list_add(spar.enemyList, id);
ds_list_add(spar.spriteList, id);

// set x and y
x = guiWidth - ((64 * allyNum) + 32);
y = 48;

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