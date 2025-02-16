
// initialize player display position
playerDisplayX		= -1;
playerDisplayY		= -1;

// initialize all appearance param IDs
outfitID			= -1;
hatID				= -1;
shoes				= -1;
accessory			= -1;

// initialize playerFacing
playerFacing = directions.south;

// initialize all color IDs
outfitColorID		= -1;
hatColorID			= -1;
shoesColorID		= -1;
accessoryColorID	= -1;

// initialize all name lists
outfitNameList		= ds_list_create();
hatNameList			= ds_list_create();
shoesNameList		= ds_list_create();
accessoryNameList	= ds_list_create();

// initialize mirror shine position
mirrorShineX = -1;
mirrorShineY = -1;

// initialize dyes list
usableDyes = ds_list_create();

// initialize index
index = 0;

// create character creator phases enum
enum CHARACTER_CREATOR_PHASES {
	SKINTONE_SELECTION,
	OUTFIT_SELECTION,
	OUTFIT_COLOR_SELECTION,
	HAIRSTYLE_SELECTION,
	HAIR_COLOR_SELECTION,
	CONFIRM_SELECTION,	
	HEIGHT
}

// initialize phase
phase = CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION;

// initialize lists containing bbox dimensions for all selection elements
skintoneLefts		= ds_list_create();
skintoneRights		= ds_list_create();
skintoneTops		= ds_list_create();
skintoneBottoms		= ds_list_create();

outfitArrowLefts	= ds_list_create();
outfitArrowRights	= ds_list_create();
outfitArrowTops		= ds_list_create();
outfitArrowBottoms	= ds_list_create();

outfitColorLefts	= ds_list_create();
outfitColorRights	= ds_list_create();
outfitColorTops		= ds_list_create();
outfitColorBottoms	= ds_list_create();

hairArrowLefts		= ds_list_create();
hairArrowRights		= ds_list_create();
hairArrowTops		= ds_list_create();
hairArrowBottoms	= ds_list_create();

hairColorLefts		= ds_list_create();
hairColorRights		= ds_list_create();
hairColorTops		= ds_list_create();
hairColorBottoms	= ds_list_create();

// populate all bbox dimension lists

// indicate that it is time for the transition manager to fade back out
global.roomBuilt = true;