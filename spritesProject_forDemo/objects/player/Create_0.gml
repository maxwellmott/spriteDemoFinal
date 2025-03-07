/// @desc

// initialize time for new game
seconds = 0;
minutes = 40;
hours	= 23;
day		= 14;
weekday	= weekdays.hyggsun;
season	= seasons.daysOfBones;
year	= 512;

// inherit human create event
event_inherited();

#region		INITIALIZE ALL PRIMARY PARAMETERS SET BY THE PLAYER
	// initialize name
	name = "";
	
	// initialize pronouns
	pronouns = -1;
	
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
	eyewear			= 0;
	outfit			= 0;
	outfitColor		= 0;
	hairstyle		= 0;
	hairColor		= 0;
	hat				= 0;
	hatColor		= 0;
	shoes			= 0;
	shoeColor		= 0;
	accessory		= 0;

#endregion 

#region		INITIALIZE ALL UNLOCKABLES LISTS
	// initialize wardrobe grid (this will be a list of lists, each list token 
	// is a sublist of unlocked items. the list is ordered according to the appearance
	// params enum)
	wardrobe = "";

	// initialize unlocked clothing dyes (hairColors are 
	// gotten by the haircut menu depending on the player's
	// quest completion.
	palette			= "";
	
	// initialize all previously unlocked doors
	unlockedDoors = "";

	// initialize all unlocked talismans
	talismans = currentTeam;
	
	/*
	// FOR TESTING PURPOSES ONLY!!!!!!!
	var l = ds_list_create(); var i = 0;	repeat (SPRITES.HEIGHT) {
		l[| i] = i;
		
		// increment i
		i++;
	}	talismans = encode_list(l);		ds_list_destroy(l);
	*/
	
	// initialize compendium
	compendium = currentSpellBook;
	
	/*
	// FOR TESTING PURPOSES ONLY!!!!!!!
	var l = ds_list_create(); var i = 0;	repeat (SPELLS.HEIGHT) {
		l[| i] = i;
		
		// increment i
		i++;
	}	compendium = encode_list(l);		ds_list_destroy(l);
	*/

	// initialize titles
	titles = ds_list_create();
	
	// set all titles to -1 (this is not just for testing--this is so that
	// all titles are still instantiated with a spot on the list, they are
	// simply initialized as LOCKED
	var i = 0;	repeat (SPAR_TITLES.HEIGHT) {
		titles[|i] = -1;
	
		i++;	
	}
	
	// initialize contacts
	contacts = "";
	
	// initialize all unlocked books list
	library = "";
	
	// initialize list of quest completion lists
	todoList = "";

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
	
	// intialize appearance loaded as false
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

#region		INITIALIZE ALL VARIABLES USED TO TRACK ELO AND FAVORITES
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
#endregion

// --------------------------FOR TESTING PURPOSES ONLY----------------------------
// -------------------POPULATE WARDROBE LIST WITH ALL OPTIONS---------------------

// initialize a dummy wardrobe list
var wl = ds_list_create();

var i = 0;	repeat (APPEARANCE_PARAMS.height) {
	// initialize n
	var n = -1;
	
	// create a dummy item list
	var il = ds_list_create();
	
	// get the number of items for the current appearance parameter
	switch (i) {
		case APPEARANCE_PARAMS.outfit:
			n = outfits.height;
		break;
	
		case APPEARANCE_PARAMS.eyewear:
			n = spectacles.height;
		break;
		
		case APPEARANCE_PARAMS.hat:
			n = hats.height;
		break;
		
		case APPEARANCE_PARAMS.shoes:
			n = footwear.height;
		break;
		
		case APPEARANCE_PARAMS.accessory:
			n = accessories.height;
		break;
	}
	
	// use a repeat loop to build each list
	var j = 0;	repeat (n) {
		// add the next item to the item list
		ds_list_add(il, j);
		
		// increment j
		j++;
	}
	
	// add the encoded item list to the wardrobe list
	ds_list_add(wl, encode_list(il));
	
	// destroy the dummy item list
	ds_list_destroy(il);
	
	// increment i
	i++;
}

// set wardrobe to equal the encoded wardrobe list
wardrobe = encode_list(wl);

// destroy the dummy wardrobe list
ds_list_destroy(wl);

// create a dummy palette list
var pl = ds_list_create();

// use a repeat loop to add all of the colors to player's palette
i = 0;	repeat (COLORS.SKINTONE_1) {
	ds_list_add(pl, i);

	// increment i	
	i++;
}

// set the player's palette to equal the encoded dummy list
palette = encode_list(pl);

// destroy the dummy palette list
ds_list_destroy(pl);