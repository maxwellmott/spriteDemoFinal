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

// initialize base stats
basePower	= -1;
baseResist	= -1;
baseAgility = -1;
baseLuck	= -1;
baseFire	= -1;
baseWater	= -1;
baseStorm	= -1;
baseEarth	= -1;
baseSize	= -1;
baseAlign	= -1;

// load sprite parameters
sprite_load_parameters();

// initialize current stats
currentPower	= basePower;
currentResist	= baseResist;
currentAgility	= baseAgility;
currentLuck		= baseLuck;
currentFire		= baseFire;
currentWater	= baseWater;
currentStorm	= baseStorm;
currentEarth	= baseEarth;
currentSize		= baseSize;
currentAlign	= baseAlign;

// initialize mindset (set to 0 since negative IDs= curses)
mindset = 0;

// initialize bound and hexed
bound = false;
hexed = false;

// initialize selectedTarget and selectedAction
selectedTarget = -4;
selectedAction = -4;

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

// intitialize turnReady
turnReady = false;

// initialize readyDisplay
readyDisplay = "";

// initialize readyDisplayBuilt
readyDisplayBuilt = false;

// initialize enemy
enemy = player.enemy;