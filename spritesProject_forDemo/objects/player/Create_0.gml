/// @desc

// inherit human create event
event_inherited();

// create tilemap variables
tm_ground		= -1;
tm_water		= -1;
tm_upstairs		= -1;
tm_collidables	= -1;

// initialize time for new game
seconds = 0;
minutes = 58;
hours	= 23;
day		= 14;
weekday	= weekdays.famelsun;
season	= seasons.daysOfBones;
year	= 512;

// initialize currentDoor
currentDoor = noone;

// initialize currentLiterature
currentLiterature = noone;

// initialize name
name = "Max";

// initialize x and y
x = 0;
y = 0;

// initialize facing
facing = -1;

// initialize location
location = locations.miriabramExt;

// initialize appearance
appearance = string(colors.skintone2) + "," + string(outfits.overalls) + "," + string(colors.indigo) + "," + string(hairstyles.shortStraight) + "," + string(colors.chartreuse) + "," + string(hats.cowboy) + "," + string(colors.noir) + "," + string(footwear.sandals) + "," + string(colors.cyan) + ",-1,-1,";

// initialize teamString
team = "";

// initialize spriteString
talismans = "";

// initialize wardrobeString
wardrobe = "";

// initialize spellString
spells = "";

// initialize contactString
contacts = "";

// initialize various battle ranking scores
roninScore			= 0;
roninMatchCount		= 0;
onlineRating		= 0;
onlineMatchCount	= 0;

// initialize HP and MP
maxHP = 1000;
maxMP = 1000;

currentHP = maxHP;
currentMP = maxMP;

// initialize enemy
enemy = noone;

// initialize hmove and vmove
hmove		= 0;
vmove		= 0;

swimming			= false;

pointerX			= noone;
pointerY			= noone;

frame = 0;

unlockedDoors = "";
moving = false;

sprite = -1;
frameCount = -1;

minFrame = -1;
maxFrame = -1;

appearanceLoaded = false;

state = humanStates.standard;

sundown = false;
darkAlpha = 0.0;