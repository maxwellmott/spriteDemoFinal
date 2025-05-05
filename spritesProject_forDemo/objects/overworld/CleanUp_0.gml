///@desc

instance_destroy(scenery);
instance_destroy(literature);
instance_destroy(overworldDraw);
instance_destroy(tileChecker_debug);
instance_destroy(collidableTileChecker);
instance_destroy(waterTileChecker);
instance_destroy(groundTileChecker);
instance_destroy(sendport);
instance_destroy(door);
instance_destroy(npc);

layer_tilemap_destroy(tilemapList[| tilemaps.ground]);
layer_tilemap_destroy(tilemapList[| tilemaps.water]);
layer_tilemap_destroy(tilemapList[| tilemaps.collidables]);
if (tilemapList[| tilemaps.upperStory] >= 0)	layer_tilemap_destroy(tilemapList[| tilemaps.upperStory]);

ds_list_destroy(tilemapList);
instance_destroy(sceneryCollidable);