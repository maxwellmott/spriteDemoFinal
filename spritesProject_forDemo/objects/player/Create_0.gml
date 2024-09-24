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

// for testing purposes only
talismanList = ds_list_create();

var i = 0;	repeat (SPRITES.HEIGHT)	{
	talismanList[| i] = i;

	i++;	
}

var teamSet = false;

while !(teamSet) {
	// randomize talismanList
	randomize_list(talismanList);

	// initialize teamString
	teamString = "";

	// initialize teamList
	teamList = ds_list_create();

	// ONLY FOR TESTING
	teamList[| 0] = talismanList[| 0];
	teamList[| 1] = talismanList[| 1];
	teamList[| 2] = talismanList[| 2];
	teamList[| 3] = talismanList[| 3];

	var newSpriteCount = 0;
	
	var i = 0;	repeat (4) {
		var sid = teamList[| i];
		
		if (sid == SPRITES.NEW_SPRITE1)		newSpriteCount++;
		if (sid == SPRITES.NEW_SPRITE2)		newSpriteCount++;
		if (sid == SPRITES.NEW_SPRITE3)		newSpriteCount++;
		if (sid == SPRITES.NEW_SPRITE4)		newSpriteCount++;
		if (sid == SPRITES.NEW_SPRITE5)		newSpriteCount++;
	
		i++;
	}
	
	if (newSpriteCount == 0) {
		teamSet = true;	
	}
}

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

// for testing purposes only
var i = 0;	repeat (SPELLS.HEIGHT)	{
	knownSpells[| i] = i;
	
	i++;
}

//randomize knownSpells
randomize_list(knownSpells);

// initialize spellBookString
spellBookString = "";

// initialize spellBook
spellBook = ds_list_create();

// ONLY FOR TESTING
spellBook[| 7] = knownSpells[| 7];
spellBook[| 6] = knownSpells[| 6];
spellBook[| 5] = knownSpells[| 5];
spellBook[| 4] = knownSpells[| 4];
spellBook[| 3] = knownSpells[| 3];
spellBook[| 2] = knownSpells[| 2];
spellBook[| 1] = knownSpells[| 1];
spellBook[| 0] = knownSpells[| 0];

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