/// @desc

#region		INITIALIZE ALL PRIMARY PARAMETERS SET BY THE PLAYER
	// initialize name
	name = "";
	
	// initialize appearance
	appearance = "0,0,0,0,0,0,0,0,0,-1,-1,";
	
	// initialize currentTeam
	currentTeam = string(SPRITES.PODRIC) + "," + string(SPRITES.DIIPSY) + "," + string(SPRITES.GLIDRAKE) + "," + string(SPRITES.HACHACHACHA) + ",";
	
	// initialize currentSpellBook
	currentSpellBook = string(SPELLS.FIREBALL) + "," + string(SPELLS.SHOCK) + "," + string(SPELLS.DECAY) + "," + string(SPELLS.HOLY_WATER) + "," + string(SPELLS.EXPEL_FORCE) + "," + string(SPELLS.HEALING_LIGHT) + "," + string(SPELLS.EMPATHIZE) + ",";
	
	// set title
	title = SPAR_TITLES.MONK;
	
	// initialize x and y
	x = 0;
	y = 0;
	
	// initialize draw x and draw y (this correction is 
	// due to the fact that the players appearance elements
	// are drawn starting from the top left and not the middle
	// center. This is simply adding half the width and height 
	// to the draw position to correct for this.
	drawX = x - 12;
	drawY = y - 21;
	
	// initialize all appearance parameters
	skintone		= 0;
	outfit			= 0;
	outfitColor		= 0;
	hairstyle		= 0;
	hairColor		= 0;
	hat				= 0;
	hatColor		= 0;
	shoes			= 0;
	shoeColor		= 0;
	accessory		= -1;
	accessoryColor	= -1;

#endregion 

// inherit human create event
event_inherited();

// initialize time for new game
seconds = 0;
minutes = 40;
hours	= 23;
day		= 14;
weekday	= weekdays.hyggsun;
season	= seasons.daysOfBones;
year	= 512;

#region		INITIALIZE ALL UNLOCKABLES LISTS
	// initialize all appearance param lists (hairstyles are 
	// gotten by the haircut menu depending on the player's
	// quest completion.
	unlockedOutfits			= "";
	unlockedHats			= "";
	unlockedShoes			= "";
	unlockedAccessories		= "";

	// initialize unlocked clothing dyes (hairColors are 
	// gotten by the haircut menu depending on the player's
	// quest completion.
	unlockedDyes			= "";
	
	// initialize all previously unlocked doors
	unlockedDoors = "";

	// initialize all unlocked talismans
	talismans = "";
	
	// initialize knownSpells
	knownSpells = ds_list_create();

	// initialize unlockedTitles
	unlockedTitles = ds_list_create();
	
	// set all titles to -1
	var i = 0;	repeat (SPAR_TITLES.HEIGHT) {
		unlockedTitles[|i] = -1;
	
		i++;	
	}
	
	// initialize unlockedContacts
	unlockedContacts = "";

#endregion

#region		INITIALIZE ALL VARIABLES USED FOR OVERWORLD NAVIGATION
	// initialize currentDoor
	currentDoor = noone;

	// initialize currentLiterature
	currentLiterature = noone;

	// initialize facing
	facing = directions.south;

	// initialize location
	location = -1;
	
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
	
	// create player response map
	responseMap = ds_map_create();
	decode_map(global.playerResponses, responseMap);
#endregion

#region		INITIALIZE ALL VARIABLES USED FOR SPARRING
	// initialize HP and MP
	maxHP = MAX_HP;
	maxMP = MAX_MP;
	
	// initialize currentHP and currentMP
	currentHP = maxHP;
	currentMP = maxMP;
	
	// initialize ready (this is used to indicate that the player is ready to submit their turn in a spar)
	ready = false;
	
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
	
#endregion

// initialize various battle ranking scores
roninScore			= 150;
roninMatchCount		= 0;
roninWinCount		= 0;
roninLoseCount		= 0;

onlineRating		= 150;
onlineMatchCount	= 0;
onlineWinCount		= 0;
onlineLoseCount		= 0;

// initialize all lists to track sprite and spell usage
roninSpellUseCounts		= "";
onlineSpellUseCounts	= "";

roninSpriteUseCounts	= "";
onlineSpriteUseCounts	= "";

roninSpriteWinCounts	= "";
onlineSpriteWinCounts	= "";