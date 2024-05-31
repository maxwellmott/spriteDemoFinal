/// @description Insert description here
// You can write your code in this editor

// initialize alpha
alpha = 1.0;

// set allyNum
allyNum = instance_number(object_index) - 1;

// set spotNum (increase by 4 since this is the enemy)
spotNum = allyNum + 4;

// set spriteID
spriteID = spar.playerTwo.teamList[| allyNum];

// add self to battle sprite lists
spar.enemyList[| allyNum]	= id;
spar.spriteList[| spotNum]	= id;

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

// initialize bound, hexed, berserk, and invulnerable
bound = false;
hexed = false;
berserk = false;
invulnerable = false;

// initialize bound, hexed, berserk, and invulnerable counters
boundCounter = 0;
hexedCounter = 0;
berserkCounter = 0;
invulnerableCounter = 0;

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

hexedY		= 88;
mindsetY	= 88;
boundY		= 88;

// intitialize turnReady
turnReady = false;

// initialize readyDisplay
readyDisplay = "";

// initialize readyDisplayBuilt
readyDisplayBuilt = false;

// initialize team
team = spar.playerTwo;

// initialize enemy
enemy = player;

// initialize nearby lists
nearbyAllies	= ds_list_create();
nearbyEnemies	= ds_list_create();
nearbySprites	= ds_list_create();

blackHoleActive = false;
blackHoleCount = 0;

ballLightningActive = false;
ballLightningCount = 0;

newSpriteID = -1;

swapping	= false;
resting		= false;
dodging		= false;

luckRoll = 0;

currentPose = SPRITE_POSES.IDLE;

flying			= false;
invulnerable	= false;
deflective		= false;
sneaking		= false;

backUpAction1	= -1;
backUpAction2	= -1;

backUpTarget1	= -1;
backUpTarget2	= -1;

dividing = false;
multiplying = false;
coefficient = -1;