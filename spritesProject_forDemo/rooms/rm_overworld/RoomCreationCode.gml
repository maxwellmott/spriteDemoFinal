// for now this will work. Once more art is finished, and you have
// a better idea of which locations will need which sprites, add a 
// state machine here to prefetch the correct sprites.

draw_texture_flush();
texture_prefetch("OverworldHumans");
texture_prefetch("OverworldScenery");
texture_prefetch("SoulStone");
texture_prefetch("OverworldTilemaps");
texture_prefetch("OverworldTileSprites");
texture_prefetch("OverworldTileFrames");
texture_prefetch("HumanAppearanceSheets");