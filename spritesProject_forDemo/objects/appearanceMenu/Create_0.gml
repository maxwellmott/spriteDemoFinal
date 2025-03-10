
// set x and y as center (this is for the confirm window)
x = guiWidth / 2;
y = (guiHeight / 2) - 22;

// initialize player display position
playerDisplayX		= 188;
playerDisplayY		= 165;

// initialize playerFacing
playerFacing = directions.south;

// initialize all color IDs
outfitColorID		= -1;
hatColorID			= -1;
shoesColorID		= -1;

// initialize all name lists
eyewearNameList		= ds_list_create();
outfitNameList		= ds_list_create();
hatNameList			= ds_list_create();
shoesNameList		= ds_list_create();
accessoryNameList	= ds_list_create();

// decode all name lists
decode_list(global.allOutfitNames,		outfitNameList);
decode_list(global.allHatNames,			hatNameList);
decode_list(global.allFootwearNames,	shoesNameList);
decode_list(global.allAccessoryNames,	accessoryNameList);

// decode player wardrobe list
wardrobeList = ds_list_create();
decode_list(player.wardrobe, wardrobeList);

// initialize mirror shine position
mirrorShineX = -1;
mirrorShineY = -1;

// rebuild the color list
colorList = ds_list_create();

// decode color list
decode_list(global.allColors, colorList);

// initialize usableOutfits list
usableOutfits = ds_list_create();

// initialize usableHats list
usableHats = ds_list_create();

// initialize usableFootwear list
usableFootwear = ds_list_create();

// initialize usableEyewear list
usableEyewear = ds_list_create();

// initialize usableAccessories list
usableAccessories = ds_list_create();

// initialize usableFootwear list
usableFootwear = ds_list_create();

// initialize usable dyes list
usableDyes = ds_list_create();

// decode outfits string from player's wardrobe to usableOutfits
decode_list(wardrobeList[| APPEARANCE_PARAMS.outfit],	usableOutfits);

// decode hats string from player's wardrobe to usableHats
decode_list(wardrobeList[| APPEARANCE_PARAMS.hat],		usableHats);

// decode shoes string from player's wardrobe to usableFootwear
decode_list(wardrobeList[| APPEARANCE_PARAMS.shoes],		usableFootwear);

// decode eyewear string from player's wardrobe to usableEyewear
decode_list(wardrobeList[| APPEARANCE_PARAMS.eyewear],	usableEyewear);

// decode accessories string from player's wardrobe to usableAccessories
decode_list(wardrobeList[| APPEARANCE_PARAMS.accessory],	usableAccessories);

// decode usableDyes from player's usableDyes
decode_list(player.palette, usableDyes);

// create character creator phases enum
enum APPEARANCE_EDITOR_PHASES {
	OUTFIT_SELECTION,
	OUTFIT_COLOR_SELECTION,
	HAT_SELECTION,
	HAT_COLOR_SELECTION,
	SHOE_SELECTION,
	SHOE_COLOR_SELECTION,
	EYEWEAR_SELECTION,
	ACCESSORY_SELECTION,
	CONFIRM_WINDOW_ENTER,
	CONFIRM_SELECTION,
	CONFIRM_WINDOW_EXIT,
	HEIGHT
}

// initialize phase
phase = APPEARANCE_EDITOR_PHASES.OUTFIT_SELECTION;

// initialize lists containing bbox dimensions for all selection elements						
dyeLefts				= ds_list_create();
dyeRights				= ds_list_create();

outfitColorTops			= ds_list_create();
outfitColorBottoms		= ds_list_create();

hatColorTops			= ds_list_create();
hatColorBottoms			= ds_list_create();

shoeColorTops			= ds_list_create();
shoeColorBottoms		= ds_list_create();

// set leftArrowLeft and leftArrowRight
leftArrowLeft			= 4;
leftArrowRight			= 14;

// set rightArrowLeft and rightArrowRight
rightArrowLeft			= 136;
rightArrowRight			= 146;

// set outfitArrowTop and outfitArrowBottom
outfitArrowTop			= 32;
outfitArrowBottom		= 42;

// set hatArrowTop and hatArrowBottom
hatArrowTop				= 72;
hatArrowBottom			= 82;

// set shoeArrowTop and shoeArrowBottom
shoeArrowTop			= 112;
shoeArrowBottom			= 122;

// set eyewearArrowTop and eyewearArrowBottom
eyewearArrowTop			= 152;
eyewearArrowBottom		= 162;

// set accessoryArrowTop and accessoryArrowBottom
accessoryArrowTop		= 192;
accessoryArrowBottom	= 202;

// set nameChangeButton dimensions
nameChangeButtonLeft	= 174;
nameChangeButtonRight	= 132;
nameChangeButtonTop		= 224;
nameChangeButtonBottom	= 152;

// set dyesPerRow
var dyesPerRow = 10;

// use a repeat loop to set all dye dimensions (for all elements--outfit color, hat color, shoe color)
var i = 0;	repeat (ds_list_size(usableDyes)) {
	// get the row and columns using i
	var rowNum			= i div dyesPerRow;
	var colNum			= i mod dyesPerRow;
	
	// set the left and right of the given dye (they are vertically aligned
	// are therefore shared between all elements)
	var left			= 174 + (colNum * 8);
	var right			= 180 + (colNum * 8);
	
	// set the top and bottom for the outfitColor of this number
	var outfitTop		= 24 + (rowNum * 8);
	var outfitBottom	= 30 + (colNum * 8);
	
	// set the top and bottom for the hatColor of this number
	var hatTop			= outfitTop + 40;
	var hatBottom		= outfitBottom + 40;
	
	// set the top and bottom for the shoeColor of this number
	var shoeTop			= hatTop + 40;
	var shoeBottom		= hatBottom + 40;
	
	// add all dimensions to all lists
	ds_list_add(dyeLefts,			left);
	ds_list_add(dyeRights,			right);
	
	ds_list_add(outfitColorTops,	outfitTop);
	ds_list_add(outfitColorBottoms,	outfitBottom);
	
	ds_list_add(hatColorTops,		hatTop);
	ds_list_add(hatColorBottoms,	hatBottom);
	
	ds_list_add(shoeColorTops,		shoeTop);
	ds_list_add(shoeColorBottoms,	shoeBottom);
	
	// increment i
	i++;
}

// initialize appearance list
appearance = player.appearance;

// initialize all appearance elements using player's currently set choices
skintone		=	player.skintone;
eyewear			=	player.eyewear;
outfit			= 	player.outfit;		
outfitColor		= 	player.outfitColor;	
hairstyle		= 	player.hairstyle;	
hairColor		= 	player.hairColor;	
hat				= 	player.hat;			
hatColor		=	player.hatColor;	
shoes			= 	player.shoes;		
shoeColor		= 	player.shoeColor;	
accessory		= 	player.accessory;	

// initialize currentOutfitArrow variable
currentOutfitArrow = -1;

// initialize currentHatArrow variable
currentHatArrow = -1;

// initialize currentShoeArrow variable
currentShoeArrow = -1;

// initialize currentEyewearArrow variable
currentEyewearArrow = -1;

// initialize currentAccessoryArrow variable
currentAccessoryArrow = -1;

// initialize outfitClickFrame
outfitClickFrame = 0;

// initialize hatClickFrame
hatClickFrame = 0;

// initialize shoeClickFrame
shoeClickFrame = 0;

// initialize eyewearClickFrame
eyewearClickFrame = 0;

// initialize accessoryClickFrame
accessoryClickFrame = 0;

// get outfitNameY
outfitNameY = 37;

// get hatNameY
hatNameY = 77;

// get shoeNameY
shoeNameY = 117;

// get eyewearNameY
eyewearNameY = 157;

// get accessoryNameY
accessoryNameY = 197;

// get nameDrawX 
nameDrawX = 73;

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