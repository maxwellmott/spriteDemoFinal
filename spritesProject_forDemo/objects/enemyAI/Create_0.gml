/// @desc

// initialize ID
ID = global.opponent

// initialize name
name = "";

// initialize currentTeam
talismans = "";

// initialize compendium
compendium = ds_list_create();

// initialize currentSpellBook
currentSpellBook = "";

// initialize compendium string
compendium = "";

// initialize spellString
spellString = "";

// initialize spellBook
spellBookList = ds_list_create();

// initialize team
teamList = ds_list_create();

// initialize roster
roster = ds_list_create();

// initialize HP and MP
maxHP = 1000;
maxMP = 100;

currentHP = maxHP;
currentMP = maxMP;

// initialize selectionLogic

// load parameters
enemyAI_get_params();

// select team
enemyAI_set_team();

// select spells
//enemyAI_set_spellbook();

// initialize hindrances
miasma	= false;
hum		= false;
rust	= false;

// initialize hindrance indicator positions
miasmaX	= guiWidth - 40;
humX	= guiWidth - 24;
rustX	= guiWidth - 8;

miasmaY	= 8;
humY	= 8;
rustY	= 8;

// initialize spellBookGrid
spellBookGrid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLMAX);

// initialize enemy
enemy = noone;

// set spellBookGrid
player_build_spellBookGrid();

ready = false;

hailSphera = false;

// boolean representing whether this player has a sprite with synchronized soldiers on their team
synchronizedSoldiersActive = false;

// initialize the list of potential player spells
potentialPlayerSpells = ds_list_create();

// initialize the list of seen spells
seenSpells = ds_list_create();

// initialize the list of spellValues. This will be reset each turn. The first half of the list
// will contain all of the npc's current spells's values, the second half of the list will contain all of the
// potentialPlayerSpells's values. "Values" refers to the amount of help that the given spell would provide under
// the current circumstances.
spellValues = ds_list_create();

