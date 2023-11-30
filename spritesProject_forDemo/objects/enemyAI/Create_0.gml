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
team = ds_list_create();

// initialize roster
roster = ds_list_create();

// initialize HP and MP
maxHP = 1000;
maxMP = 100;

currentHP = maxHP;
currentMP = maxMP;

// initialize selectionLogic

// load parameters
aiOpponent_get_params();

// select team
aiOpponent_set_team();