/// @description Insert description here
// You can write your code in this editor

destroy_if_possible(camera);
starCount = irandom_range(9, 12);

// SET LOCALS
backdropSprite	= spr_dayChangeBackdrop;
backdropX		= 0;
backdropY		= 0;

moonSprite		= spr_dayChangeMoon;
moonX			= 0;
moonY			= 0;

starSprite		= spr_dayChangeStar;

currentDay		= player.day;
currentSeason	= player.season;

starsPlaced = 0;

// GET MOON PHASE
enum moonPhases {
	newMoon,
	waxingCrescent,
	waxingGibbous,
	fullMoon,
	waningGibbous,
	waningCrescent,
}

if !(currentDay mod 1)	moonPhase = moonPhases.newMoon;
if !(currentDay mod 2)	moonPhase = moonPhases.waxingCrescent;
if !(currentDay mod 3)	moonPhase = moonPhases.waxingCrescent;
if !(currentDay mod 4)	moonPhase = moonPhases.waxingGibbous;
if !(currentDay mod 5)	moonPhase = moonPhases.waxingGibbous;
if !(currentDay mod 6)	moonPhase = moonPhases.fullMoon;
if !(currentDay mod 7)	moonPhase = moonPhases.fullMoon;
if !(currentDay mod 8)	moonPhase = moonPhases.waningGibbous;
if !(currentDay mod 9)	moonPhase = moonPhases.waningGibbous;
if !(currentDay mod 10)	moonPhase = moonPhases.waningCrescent;
if !(currentDay mod 11)	moonPhase = moonPhases.waningCrescent;
if !(currentDay mod 12)	moonPhase = moonPhases.newMoon;

// SET ALARMS
alarm[0] = 60;
alarm[1] = -1;

// SET INITIAL PHASE
enum dcDisplay {
	day,
	sprites,
	SPELLS,
	conversations,
	spars,
	height
}

displaying = dcDisplay.day;

npcLocationList	= ds_list_create();

day_change_build_location_list(npcLocationList);

day_change_edit_npc_lists(npcLocationList);

global.roomBuilt = true;