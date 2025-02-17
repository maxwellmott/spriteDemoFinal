/// @desc

drawX = x - 12;
drawY = y - 21;

skintone		= -1;
outfit			= -1;
outfitColor		= -1;
hairstyle		= -1;
hairColor		= -1;
hat				= -1;
hatColor		= -1;
shoes			= -1;
shoeColor		= -1;
accessory		= -1;
accessoryColor	= -1;

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
minutes = 40;
hours	= 23;
day		= 14;
weekday	= weekdays.hyggsun;
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
location = -1;

// initialize appearance
//				skintone							outfit								outfitColor								hairstyle									hairColor								hat							hatColor								shoes								shoeColor							accessory
appearance =	string(COLORS.SKINTONE_2) + "," +	string(outfits.overalls) + "," +	string(COLORS.FARSEED_WHITE) + "," +	string(hairstyles.shortStraight) + "," +	string(COLORS.SPRINGSAP_GOLD) + "," +	string(hats.cowboy) + "," + string(COLORS.OBSIDIAN_BLACK) + "," +	string(footwear.sandals) + "," +	string(COLORS.COMMON_GEM_BLUE) +	",-1,-1,";

// load player appearance
player_load_appearance();

// for testing purposes only
talismanList = ds_list_create();

var i = 0;	repeat (SPRITES.HEIGHT)	{
	talismanList[| i] = i;

	i++;	
}

var teamSet = false;


// initialize teamString
teamString = "";

// initialize teamList
teamList = ds_list_create();

// ONLY FOR TESTING
teamList[| 0] = SPRITES.SCROOTINEYES;
teamList[| 1] = SPRITES.GASTRONIMO;
teamList[| 2] = SPRITES.ANACHRONAUT;
teamList[| 3] = SPRITES.ARRAYNGE;

// for testing purposes only
teamString = encode_list(teamList);

// destroy teamList
ds_list_destroy(teamList);

// initialize talismanString
talismanString = "";

talismanString = encode_list(talismanList);

ds_list_destroy(talismanString);

// initialize wardrobeString
wardrobeString = "";

// initialize wardrobeList
wardrobeList = ds_list_create();

// initialize knownSpells
knownSpells = ds_list_create();

// initialize unlockedTitles
sparTitles = ds_list_create();

// set all titles to -1
var i = 0;	repeat (SPAR_TITLES.HEIGHT) {
	sparTitles[|i] = -1;

	i++;	
}

// FOR TESTING PURPOSES ONLY
// add all titles tot unlockedTitles
var i = 0;	repeat (SPAR_TITLES.HEIGHT) {
	sparTitles[|i] = i;

	i++;
}

// for testing purposes only
var i = 0;	repeat (SPELLS.HEIGHT)	{
	knownSpells[| i] = i;
	
	i++;
}

// set selectedTitle
selectedTitle = SPAR_TITLES.DEV;

// initialize spellBookString
spellBookString = "";

// initialize spellBook
spellBook = ds_list_create();

// ONLY FOR TESTING
spellBook[| 7] = SPELLS.DECAY;
spellBook[| 6] = SPELLS.TREMOR;
spellBook[| 5] = SPELLS.CRECIAS_CRYSTAL_SPIKES;
spellBook[| 4] = SPELLS.LUSIAS_HARVEST_SPELL;
spellBook[| 3] = SPELLS.CRECIAS_CRYSTAL_WIND;
spellBook[| 2] = SPELLS.LANDSLIDE;
spellBook[| 1] = SPELLS.SUPERBLOOM;
spellBook[| 0] = SPELLS.TECTONIC_SHIFT;

spellBookString = encode_list(spellBook);

ds_list_destroy(spellBook);

// initialize knownSpellString
knownSpellString = "";

knownSpellString = encode_list(knownSpells);

ds_list_destroy(knownSpells);

// initialize contactString
contactString = "";

// initialize contactList
contactList = ds_list_create();

// initialize various battle ranking scores
roninScore			= 150;
roninMatchCount		= 0;
onlineRating		= 150;
onlineMatchCount	= 0;

// initialize HP and MP
maxHP = MAX_HP;
maxMP = MAX_MP;

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

// initialize min and max frame
minFrame = 0;
maxFrame = 0;

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

clientID	= -1;
clientType	= -1;
clientScope	= -1;
roomID		= -1;

hailSphera = false;

// boolean representing whether this player has a sprite with synchronized soldiers on their team
synchronizedSoldiersActive = false;

// create player response map
responseMap = ds_map_create();
decode_map(global.playerResponses, responseMap);

// initialize spellUseCounts list
spellUseCounts = ds_list_create();

// initialize spriteUseCounts list
spriteUseCounts = ds_list_create();

// initialize player favorite spells lists
favoriteSpells = ds_list_create();

// initialize player favorite sprites lists
favoriteSprites = ds_list_create();

// create unlocked dyes list
unlockedDyes = ds_list_create();