// set x and y as center (this is for the confirm window)
x = guiWidth / 2;
y = (guiHeight / 2) - 22;

// initialize player display position
playerDisplayX		= 115;
playerDisplayY		= 160;

// initialize playerFacing
playerFacing = directions.south;

// initialize all color IDs
outfitColorID		= -1;
hatColorID			= -1;
shoesColorID		= -1;
accessoryColorID	= -1;

// initialize all name lists
outfitNameList		= ds_list_create();
hairstyleNameList	= ds_list_create();

// decode all name lists
decode_list(global.allOutfitNames,		outfitNameList);
decode_list(global.allHairstyleNames,	hairstyleNameList);

// initialize mirror shine position
mirrorShineX = -1;
mirrorShineY = -1;

// rebuild the color list
colorList = ds_list_create();

// decode color list
decode_list(global.allColors, colorList);

// initialize usableOutfits list
usableOutfits = ds_list_create();

// initialize usable dyes list
usableDyes = ds_list_create();

// initialize skintonesList
skintones = ds_list_create();

// initialize hairstyles list
usableHairstyles = ds_list_create();

// initialize usable hairColors list
usableHairColors = ds_list_create();

// populate outfit list
ds_list_add(usableOutfits,		
	outfits.plainGown,	
	outfits.tradGi,	
	outfits.tradLounge
);

// populate dye list
ds_list_add(usableDyes,		
	COLORS.DRYBRUSH_GREEN,
	COLORS.FIRMROOT_BROWN,
	COLORS.WILD_YAM_PURPLE
);	

// populate skintones list
ds_list_add(skintones,
	COLORS.SKINTONE_1,
	COLORS.SKINTONE_2,
	COLORS.SKINTONE_3,
	COLORS.SKINTONE_4,
	COLORS.SKINTONE_5,
	COLORS.SKINTONE_6
);

// populate hairstyles list
ds_list_add(usableHairstyles,
	hairstyles.longStraight,
	hairstyles.shortStraight,
	hairstyles.shortMessy
);

// populate hairColors list
ds_list_add(usableHairColors,
	COLORS.HAIR_BLACK,
	COLORS.HAIR_BLONDE,
	COLORS.HAIR_DIRTY_BLONDE,
	COLORS.HAIR_BROWN,
	COLORS.HAIR_DARK_BROWN,
	COLORS.HAIR_RED,
	COLORS.HAIR_ORANGE
);	

// create character creator phases enum
enum CHARACTER_CREATOR_PHASES {
	SKINTONE_SELECTION,
	OUTFIT_SELECTION,
	OUTFIT_COLOR_SELECTION,
	HAIRSTYLE_SELECTION,
	HAIR_COLOR_SELECTION,
	CONFIRM_WINDOW_ENTER,
	CONFIRM_SELECTION,
	CONFIRM_WINDOW_EXIT,
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

// use a repeat loop to poulate skintone bbox dimensions
var i = 0;	repeat (ds_list_size(skintones)) {
	// get all dimensions
	var left	= 38 + (i * 32);
	var right	= 58 + (i * 32);
	var top		= 42;
	var bottom	= 58;
	
	// set all dimensions on the proper list
	skintoneLefts[| i]		= left;
	skintoneRights[| i]		= right;
	skintoneTops[| i]		= top;
	skintoneBottoms[| i]	= bottom;
	
	// increment i
	i++;
}

// use a repeat loop to populate outfit arrow bbox dimensions
var i = 0;	repeat (2) {
	// get all dimensions
	var left	= 36 + (i * 173); 
	var right	= 46 + (i * 173);
	var top		= 75;
	var bottom	= 90;
	
	// set all dimensions on the proper list
	outfitArrowLefts[| i]		= left;
	outfitArrowRights[| i]		= right;
	outfitArrowTops[| i]		= top;
	outfitArrowBottoms[| i]		= bottom;
	
	// increment i
	i++;
}

// use a repeat loop to populate outfit color bbox dimensions
var i = 0;	repeat (ds_list_size(usableDyes)) {
	// get all dimensions
	var left	= 35 + (i * 8);
	var right	= 41 + (i * 8);
	var top		= 95;
	var bottom	= 101;
	
	// set all dimensions on the proper list
	outfitColorLefts[| i]		= left;
	outfitColorRights[| i]		= right;
	outfitColorTops[| i]		= top;
	outfitColorBottoms[| i]		= bottom;
	
	
	// increment i
	i++;
}

// use a repeat loop to populate hair arrow bbox dimensions
var i = 0;	repeat (2) {
	// get all dimensions
	var left	= 36 + (i * 173);
	var right	= 46 + (i * 173);
	var top		= 121;
	var bottom	= 136;
	
	// set all dimensions on the proper list
	hairArrowLefts[| i]		= left;
	hairArrowRights[| i]	= right;
	hairArrowTops[| i]		= top;
	hairArrowBottoms[| i]	= bottom;
	
	
	// increment i
	i++;
}

// use a repeat loop to populate hair color bbox dimensions
var i = 0;	repeat (ds_list_size(usableHairColors)) {
	// get all dimensions
	var left	= 35 + (i * 8);
	var right	= 41 + (i * 8);
	var top		= 141;
	var bottom	= 147;
	
	// set all dimensions on the proper list
	hairColorLefts[| i]		= left;
	hairColorRights[| i]	= right;
	hairColorTops[| i]		= top;
	hairColorBottoms[| i]	= bottom;
	
	
	// increment i
	i++;
}

// set random seed
randomize();

// initialize appearance list
appearance = ds_list_create();

// initialize all appearance elements
skintone		=	colorList[|skintones[|			irandom_range(0, ds_list_size(skintones) - 1)]];
outfit			= 	usableOutfits[|					irandom_range(0, ds_list_size(usableOutfits) - 1)];
outfitColor		= 	colorList[| usableDyes[|		irandom_range(0, ds_list_size(usableDyes) - 1)]];
hairstyle		= 	usableHairstyles[|				irandom_range(0, ds_list_size(usableHairstyles) - 1)];
hairColor		= 	colorList[| usableHairColors[|	irandom_range(0, ds_list_size(usableHairColors) - 1)]];
hat				= 	hats.nothing;
hatColor		=	COLORS.DYNSVEIL_BROWN;
shoes			= 	footwear.sandals;
shoeColor		= 	COLORS.FIRMROOT_BROWN;
accessory		= 	-1;
accessoryColor	= 	-1;

// initialize currentOutfitArrow variable
currentOutfitArrow = -1;

// initialize currentHairstyleArrow variable
currentHairstyleArrow = -1;

// initialize arrowClickFrame
outfitClickFrame = 0;

// initialize hairstyleClickFrame
hairstyleClickFrame = 0;

// get outfitNameY
outfitNameY = outfitArrowBottoms[| 0] - (outfitArrowBottoms[| 0] - outfitArrowTops[| 0]) + 11;

// get hairstyleNameY
hairstyleNameY = hairArrowBottoms[| 0] - (hairArrowBottoms[| 0] - hairArrowTops[| 0]) + 11;

// get nameDrawX 
nameDrawX = guiWidth / 2;

// set all bbox dimensions for yes button
yesButtonLeft	= 80;
yesButtonRight	= 104;
yesButtonTop	= 128;
yesButtonBottom = 140;

noButtonLeft	= 152;
noButtonRight	= 176;
noButtonTop		= 128;
noButtonBottom	= 140;

// initialize ynSelection to no (no = 0, yes = 1)
ynSelection = 0;

// initialize confirmWindowMaxFrame
confirmWindowMaxFrame = 4;

// indicate that it is time for the transition manager to fade back out
global.roomBuilt = true;