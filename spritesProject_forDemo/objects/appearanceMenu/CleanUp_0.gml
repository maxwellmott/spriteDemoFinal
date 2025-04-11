// save all current selections to the player object
character_creator_save_appearance();

// destroy all ds lists
ds_list_destroy(outfitNameList);
ds_list_destroy(hatNameList);
ds_list_destroy(shoesNameList);
ds_list_destroy(eyewearNameList);
ds_list_destroy(accessoryNameList);

ds_list_destroy(dyeLefts);
ds_list_destroy(dyeRights);

ds_list_destroy(outfitColorTops);
ds_list_destroy(outfitColorBottoms);

ds_list_destroy(hatColorTops);
ds_list_destroy(hatColorBottoms);

ds_list_destroy(shoeColorTops);
ds_list_destroy(shoeColorBottoms);

ds_list_destroy(usableDyes);

ds_list_destroy(colorList);

ds_list_destroy(usableOutfits);
ds_list_destroy(usableHats);
ds_list_destroy(usableFootwear);
ds_list_destroy(usableEyewear);
ds_list_destroy(usableAccessories);

ds_list_destroy(appearance);

player.appearanceLoaded = false;

build_save_file();