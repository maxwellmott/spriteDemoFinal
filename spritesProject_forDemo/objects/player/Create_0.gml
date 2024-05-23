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
location = -1;

// initialize appearance
//				skintone							outfit								outfitColor						hairstyle									hairColor							hat							hatColor					shoes								shoeColor				accessory
appearance =	string(colors.skintone2) + "," +	string(outfits.overalls) + "," +	string(colors.indigo) + "," +	string(hairstyles.shortStraight) + "," +	string(colors.chartreuse) + "," +	string(hats.cowboy) + "," + string(colors.noir) + "," + string(footwear.sandals) + "," +	string(colors.cyan) + ",-1,-1,";

// load player appearance
player_load_appearance();

// initialize teamString
teamString = "";

// initialize teamList
teamList = ds_list_create();

// ONLY FOR TESTING
teamList[| 0] = SPRITES.PONDILE;
teamList[| 1] = SPRITES.HACHACHACHA;
teamList[| 2] = SPRITES.PODRIC;
teamList[| 3] = SPRITES.GLIDRAKE;

// for testing purposes only
teamString = encode_list(teamList);

// for testing purposes only
var dl = ds_list_create();

ds_list_add(dl,		SPRITES.PONDILE,
					SPRITES.HACHACHACHA,
					SPRITES.SPARMATE,
					SPRITES.FISTICOGS,
					SPRITES.GEMBO,
					SPRITES.CLEANSAGE,
					SPRITES.ARRAYNGE,
					SPRITES.PLEEP,
					SPRITES.GLIDRAKE,
					SPRITES.EXONOLITH,
					SPRITES.NEEDLEPAW,
					SPRITES.CHROMOSILOS,
					SPRITES.DOMINO
);

// initialize talismanString
talismanString = encode_list(dl);

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

spellBookString = encode_list(spellBook);

knownSpellString = encode_list(spellBook);

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