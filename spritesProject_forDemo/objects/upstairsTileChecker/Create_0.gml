/// @desc SET SPRITE_INDEX

// this is a fast way of getting all of the external locations
if (overworld.outdoorLocation)	sprite_index = collidablesFramesExt;
if !(overworld.outdoorLocation)	sprite_index = collidablesFramesInt;