enum APPEARANCE_PARAMS {
	skintone,
	outfit,
	outfitColor,
	hairstyle,
	hairColor,
	hat,
	hatColor,
	shoes,
	shoeColor,
	accessory,
	accessoryColor,
	height
}

enum outfits {
	overalls,
	plainGown,
	tradLounge,
	tradFancy,
	newAgeFancy,
	tradGi,
	smartFancyDress,
	tradFancyGown,
	modestGown,
	height
}

enum hairstyles {
	bald,
	shortStraight,
	longStraight,
	puffyOldMan,
	shortMessy,
	height	
}

enum hats {
	nothing,
	cowboy,
	beret,
	fancyWideBrim,
	height	
}

enum footwear {
	sandals,
	trainers,
	height	
}

enum accessories {
	height
}

// load outfitTextGrid from csv file
var outfitTextGrid		= load_csv("OUTFIT_NAMES.csv");

// load hatTextGrid from csv file
var hatTextGrid			= load_csv("HAT_NAMES.csv");

// load accessoryTextGrid from csv file
var accessoryTextGrid	= load_csv("ACCESSORY_NAMES.csv");

// load hairstyleTextGrid from csv file
var hairstyleTextGrid	= load_csv("HAIRSTYLE_NAMES.csv");

// load footwearTextGrid from csv file
var footwearTextGrid	= load_csv("FOOTWEAR_NAMES.csv");

// create outfit name list
global.outfitNameList		= ds_list_create();

// create hat name list
global.hatNameList			= ds_list_create();

// create accessory name list
global.accessoryNameList	=  ds_list_create();

// create hairstyle name list
global.hairstyleNameList	= ds_list_create();

// create footwear name list
global.footwearNameList		= ds_list_create();

// populate outfitNameList
var i = 0;	repeat (outfits.height) {
	// add the proper text to the list
	global.outfitNameList[| i] = outfitTextGrid[# 1, i];
	
	// increment i
	i++;
}

// populate hatNameList
var i = 0;	repeat (hats.height) {
	// add the proper text to the list
	global.hatNameList[| i] = hatTextGrid[# 1, i];
	
	// increment i
	i++;
}

// populate accessoryNameList
var i = 0;	repeat (accessories.height) {
	// add the proper text to the list
	global.accessoryNameList[| i] = accessoryTextGrid[# 1, i];
	
	// increment i
	i++;
}

// populate hairstyleNameList
var i = 0;	repeat (hairstyles.height) {
	// add the proper text to the list
	global.hairstyleNameList[| i] = hairstyleTextGrid[# 1, i];
	
	// increment i
	i++;
}

// populate footwearNameList
var i = 0;	repeat (footwear.height) {
	// add the proper text to the list
	global.footwearNameList[| i] = footwearTextGrid[# 1, i];
	
	// increment i
	i++;
}

// encode and delete the outfitNameList
global.allOutfitNames		= encode_list(global.outfitNameList);
ds_list_destroy(global.outfitNameList);

// encode and delete the hatNameList
global.allHatNames			= encode_list(global.hatNameList);
ds_list_destroy(global.hatNameList);

// encode and delete the accessoryNameList
global.allAccessoryNames	= encode_list(global.accessoryNameList);
ds_list_destroy(global.accessoryNameList);

// encode and delete the hairstyleNameList
global.allHairstyleNames	= encode_list(global.hairstyleNameList);
ds_list_destroy(global.hairstyleNameList);

// encode and delete the footwearNameList
global.allFootwearNames		= encode_list(global.footwearNameList);
ds_list_destroy(global.footwearNameList);

// destroy all text grids
ds_grid_destroy(outfitTextGrid);
ds_grid_destroy(hatTextGrid);
ds_grid_destroy(accessoryTextGrid);
ds_grid_destroy(hairstyleTextGrid);
ds_grid_destroy(footwearTextGrid);