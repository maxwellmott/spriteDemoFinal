/// @description Insert description here
// You can write your code in this editor

name = "";
clientID = -1;
onlineRating = -1;
roomID = -1;
teamString = "";
teamList = ds_list_create();

maxHP = MAX_HP;
maxMP = MAX_MP;

currentHP = maxHP;
currentMP = maxMP;

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

// initialize enemy
enemy = noone;

ready = false;




