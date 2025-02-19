// save all current selections to the player object
character_creator_save_appearance();

// save and encode all "usable" lists for player
player.usableOutfits		= encode_list(usableOutfits);
player.usableDyes			= encode_list(usableDyes);
player.usableHairstyles		= encode_list(usableHairstyles);
player.usableHairColors		= encode_list(usableHairColors);

// destroy all ds lists
ds_list_destroy(outfitNameList);
ds_list_destroy(hairstyleNameList);

ds_list_destroy(usableOutfits );
ds_list_destroy(usableDyes);
ds_list_destroy(skintones );
ds_list_destroy(usableHairstyles);
ds_list_destroy(usableHairColors);

ds_list_destroy(skintoneLefts);
ds_list_destroy(skintoneRights);
ds_list_destroy(skintoneTops);
ds_list_destroy(skintoneBottoms);
ds_list_destroy(outfitArrowLefts);
ds_list_destroy(outfitArrowRights);
ds_list_destroy(outfitArrowTops);
ds_list_destroy(outfitArrowBottoms);
ds_list_destroy(outfitColorLefts);
ds_list_destroy(outfitColorRights);
ds_list_destroy(outfitColorTops);
ds_list_destroy(outfitColorBottoms);
ds_list_destroy(hairArrowLefts);
ds_list_destroy(hairArrowRights);
ds_list_destroy(hairArrowTops);
ds_list_destroy(hairArrowBottoms);
ds_list_destroy(hairColorLefts);
ds_list_destroy(hairColorRights);
ds_list_destroy(hairColorTops);
ds_list_destroy(hairColorBottoms);

ds_list_destroy(appearance);

player.appearanceLoaded = false;