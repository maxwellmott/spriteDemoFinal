/// @desc

ready = false;

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
teamString = "";

// initialize teamList
teamList = ds_list_create();

// ONLY FOR TESTING
teamList[| 0] = SPRITES.PONDILE;
teamList[| 1] = SPRITES.HACHACHACHA;
teamList[| 2] = SPRITES.PODRIC;
teamList[| 3] = SPRITES.GLIDRAKE;

// initialize spriteString
talismanString = "";

// initialize talismanList
talismanList = ds_list_create();

// initialize wardrobeString
wardrobeString = "";

// initialize wardrobeList
wardrobeList = ds_list_create();

// initialize knownSpellString
knownSpellString = "";

// initialize knownSpells
knownSpells = ds_list_create();

// initialize spellBookString
spellBookString = "";

// initialize spellBook
spellBook = ds_list_create();

// ONLY FOR TESTING
spellBook[| 7] = SPELLS.RUBURS_GRAPPLE;
spellBook[| 6] = SPELLS.LADY_SOLANUS_GRACE;
spellBook[| 5] = SPELLS.EXPEL_FORCE;
spellBook[| 4] = SPELLS.HEALING_LIGHT;
spellBook[| 3] = SPELLS.DECAY;
spellBook[| 2] = SPELLS.SHOCK;
spellBook[| 1] = SPELLS.HOLY_WATER;
spellBook[| 0] = SPELLS.FIREBALL;

// initialize contactString
contactString = "";

// initialize contactList
contactList = ds_list_create();

// initialize various battle ranking scores
roninScore			= 0;
roninMatchCount		= 0;
onlineRating		= 0;
onlineMatchCount	= 0;

// initialize HP and MP
maxHP = 1000;
maxMP = 100;

currentHP = maxHP;
currentMP = maxMP;

// initialize hmove and vmove
hmove		= 0;
vmove		= 0;

// initialize swimming
swimming			= false;

// initialize pointer coordinates
pointerX			= noone;
pointerY			= noone;

// initialize frame
frame = 0;

// initialize unlockedDoors list
unlockedDoors = "";

// initialize moving
moving = false;

// intitialize sprite
sprite = -1;

// initialize frameCount
frameCount = -1;

// initialize min and max frame
minFrame = -1;
maxFrame = -1;

// set appearance loaded to false
appearanceLoaded = false;

// initialize state
state = humanStates.standard;

// initialize sundown
sundown = false;

// initialize darkAlpha
darkAlpha = 0.0;

// initialize selected ally
selectedAlly = noone;

// initialize hindrances
miasma	= false;
hum		= false;
rust	= false;

// initialize hindrance indicator positions
miasmaX = 8;
humX	= 24;
rustX	= 40;

miasmaY = guiHeight - 8;
humY	= guiHeight - 8;
rustY	= guiHeight - 8;

// initialize spellBookGrid
spellBookGrid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLMAX);

// initialize enemy
enemy = noone;