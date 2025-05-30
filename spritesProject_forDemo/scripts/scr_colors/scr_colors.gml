// these two macros are used to get the "black" and "white" for the UI
#macro COL_WHITE	$a9dbd2
#macro COL_BLACK	$0f0f0d
#macro COL_GREEN	$803300
#macro COL_RED		$090085

// this is an enumerator of IDs used to map color values
enum COLORS {
	DYNOCTA_PINK,
	POND_LILY_PINK,
	WINTERBERRY_RED,
	TARTBERRY_RED,
	FARSEED_WHITE,
	GOLDSHROOM_BROWN,
	FIRMROOT_BROWN,
	DYNSVEIL_BROWN,
	PONDMOLD_ORANGE,
	LOGROT_ORANGE,
	PONDGRASS_YELLOW,
	SPRINGSAP_GOLD,
	GRAYSEED_YELLOW,
	MEADOWPUFF_YELLOW,
	MEADOWBRUSH_GREEN,
	GRAYBARK_GREEN,
	STUMPMOSS_GREEN,
	DRYBRUSH_GREEN,
	TIDEMOLD_BLUE,
	LADYLUCK_BLUE,
	BEACHSTONE_BLUE,
	COMMON_GEM_BLUE,
	CRYSTAL_FLOWER_BLUE,
	LOVERS_GHOST_SILVER,
	BRAMBLEBERRY_BLUE,
	SUMMERSTORM_PURPLE,
	OBSIDIAN_BLACK,
	WILD_YAM_PURPLE,
	PIXIE_FLOWER_PURPLE,
	SKINTONE_1,
	SKINTONE_2,
	SKINTONE_3,
	SKINTONE_4,
	SKINTONE_5,
	SKINTONE_6,
	HAIR_WHITE,
	HAIR_BLACK,
	HAIR_LIGHT_BROWN,
	HAIR_DARK_BROWN,
	HAIR_BROWN,
	HAIR_SILVER,
	HAIR_RED,
	HAIR_ORANGE,
	HAIR_BLONDE,
	HAIR_DIRTY_BLONDE,
	HAIR_BLEACH_BLONDE,
	HAIR_LIGHT_GREEN,
	HAIR_DARK_GREEN,
	HAIR_LIGHT_BLUE,
	HAIR_DARK_BLUE,
	HAIR_PINK,
	HAIR_PURPLE,
	HAIR_NOIR,
	HEIGHT
}

// load textGrid from csv file
var textGrid = load_csv("COLORS_ENGLISH.csv");

// create color list
var masterList = ds_list_create();

// create all colors									$BBGGRR
ds_list_insert(masterList,	COLORS.DYNOCTA_PINK,		$ff00ff);
ds_list_insert(masterList,	COLORS.POND_LILY_PINK,		$ffa0c8);
ds_list_insert(masterList,	COLORS.WINTERBERRY_RED,		$000080);
ds_list_insert(masterList,	COLORS.TARTBERRY_RED,		$0024ff);
ds_list_insert(masterList,	COLORS.FARSEED_WHITE,		$d0fdff);
ds_list_insert(masterList,	COLORS.GOLDSHROOM_BROWN,	$1d65b5);
ds_list_insert(masterList,	COLORS.FIRMROOT_BROWN,		$004696);
ds_list_insert(masterList,	COLORS.DYNSVEIL_BROWN,		$354595);
ds_list_insert(masterList,	COLORS.PONDMOLD_ORANGE,		$0e41b7);
ds_list_insert(masterList,	COLORS.LOGROT_ORANGE,		$00a5ff);
ds_list_insert(masterList,	COLORS.PONDGRASS_YELLOW,	$30c4f4);	
ds_list_insert(masterList,	COLORS.SPRINGSAP_GOLD,		$00c8ff);
ds_list_insert(masterList,	COLORS.GRAYSEED_YELLOW,		$00ffff);	
ds_list_insert(masterList,	COLORS.MEADOWPUFF_YELLOW,	$00ffdf);	
ds_list_insert(masterList,	COLORS.MEADOWBRUSH_GREEN,	$2fffad);	
ds_list_insert(masterList,	COLORS.GRAYBARK_GREEN,		$90ee90);
ds_list_insert(masterList,	COLORS.STUMPMOSS_GREEN,		$006400);
ds_list_insert(masterList,	COLORS.DRYBRUSH_GREEN,		$89ab9a);
ds_list_insert(masterList,	COLORS.TIDEMOLD_BLUE,		$578b2e);
ds_list_insert(masterList,	COLORS.LADYLUCK_BLUE,		$808000);
ds_list_insert(masterList,	COLORS.BEACHSTONE_BLUE,		$ffff00);
ds_list_insert(masterList,	COLORS.COMMON_GEM_BLUE,		$c8d530);
ds_list_insert(masterList,	COLORS.CRYSTAL_FLOWER_BLUE,	$e6d8ad);
ds_list_insert(masterList,	COLORS.LOVERS_GHOST_SILVER,	$d4b8b8);
ds_list_insert(masterList,	COLORS.BRAMBLEBERRY_BLUE,	$800000);
ds_list_insert(masterList,	COLORS.SUMMERSTORM_PURPLE,	$82004b);
ds_list_insert(masterList,	COLORS.OBSIDIAN_BLACK,		$29001e);
ds_list_insert(masterList,	COLORS.WILD_YAM_PURPLE,		$ff0080);
ds_list_insert(masterList,	COLORS.PIXIE_FLOWER_PURPLE,	$ff20b8);
ds_list_insert(masterList,	COLORS.SKINTONE_1,			$80b3ff);
ds_list_insert(masterList,	COLORS.SKINTONE_2,			$6c9ade);
ds_list_insert(masterList,	COLORS.SKINTONE_3,			$5981be);
ds_list_insert(masterList,	COLORS.SKINTONE_4,			$45699e);
ds_list_insert(masterList,	COLORS.SKINTONE_5,			$32507e);
ds_list_insert(masterList,	COLORS.SKINTONE_6,			$1f385e);
ds_list_insert(masterList,	COLORS.HAIR_WHITE,			$fffded);
ds_list_insert(masterList,	COLORS.HAIR_BLACK,			$020321);
ds_list_insert(masterList,	COLORS.HAIR_LIGHT_BROWN,	$2e3859);
ds_list_insert(masterList,	COLORS.HAIR_DARK_BROWN,		$0a0d2b);
ds_list_insert(masterList,	COLORS.HAIR_BROWN,			$17223d);
ds_list_insert(masterList,	COLORS.HAIR_SILVER,			$8c7b50);
ds_list_insert(masterList,	COLORS.HAIR_RED,			$0d3fa3);
ds_list_insert(masterList,	COLORS.HAIR_ORANGE,			$0d8bd4);
ds_list_insert(masterList,	COLORS.HAIR_BLONDE,			$4bc3db);
ds_list_insert(masterList,	COLORS.HAIR_DIRTY_BLONDE,	$23a7c2);
ds_list_insert(masterList,	COLORS.HAIR_BLEACH_BLONDE,	$79edf7);
ds_list_insert(masterList,	COLORS.HAIR_LIGHT_GREEN,	$57f7a4);
ds_list_insert(masterList,	COLORS.HAIR_DARK_GREEN,		$237816);
ds_list_insert(masterList,	COLORS.HAIR_LIGHT_BLUE,		$dee354);
ds_list_insert(masterList,	COLORS.HAIR_DARK_BLUE,		$7d391a);
ds_list_insert(masterList,	COLORS.HAIR_PINK,			$db31eb);
ds_list_insert(masterList,	COLORS.HAIR_PURPLE,			$960860);
ds_list_insert(masterList,	COLORS.HAIR_NOIR,			$42032a);

// convert master list to an encoded string
global.allColors = encode_list(masterList);

// delete the master 
ds_list_destroy(masterList);
