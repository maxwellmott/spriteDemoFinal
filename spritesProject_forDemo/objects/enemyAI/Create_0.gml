/// @desc

// initialize ID
ID = global.opponent

// initialize name
name = "";

// initialize teamString
talismanString = "";

// initialize spellString
spellString = "";

// initialize spellBook
spellBook = ds_list_create();

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
human_build_spellBookGrid();

ready = false;