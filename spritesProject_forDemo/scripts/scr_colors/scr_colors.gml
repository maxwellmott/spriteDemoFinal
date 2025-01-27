// these two macros are used to get the "black" and "white" for the UI
#macro COL_WHITE	$a9dbd2
#macro COL_BLACK	$0f0f0d
#macro COL_GREEN	$803300
#macro COL_RED		$090085

// this is an enumerator of IDs used to map color values
enum colors {
	magenta,
	mauve,
	maroon,
	scarlet,
	cream,
	lightBrown,
	brown,
	chestnut,
	rust,
	orange,
	saffron,
	gold,
	yellow,
	chartreuse,
	lime,
	lightGreen,
	darkGreen,
	sage,
	seaGreen,
	teal,
	cyan,
	turquoise,
	lightBlue,
	silver,
	darkBlue,
	indigo,
	noir,
	violet,
	fuchsia,
	skintone1,
	skintone2,
	skintone3,
	skintone4,
	skintone5,
	skintone6,
	height
}

// load textGrid from csv file
var textGrid = load_csv("colors_english.csv");

// create color list
var masterList = ds_list_create();

// create all colors							$BBGGRR
ds_list_insert(masterList,	colors.magenta,		$ff00ff);
ds_list_insert(masterList,	colors.mauve,		$ffa0c8);
ds_list_insert(masterList,	colors.maroon,		$000080);
ds_list_insert(masterList,	colors.scarlet,		$0024ff);
ds_list_insert(masterList,	colors.cream,		$d0fdff);
ds_list_insert(masterList,	colors.lightBrown,	$1d65b5);
ds_list_insert(masterList,	colors.brown,		$004696);
ds_list_insert(masterList,	colors.chestnut,	$354595);
ds_list_insert(masterList,	colors.rust,		$0e41b7);
ds_list_insert(masterList,	colors.orange,		$00a5ff);
ds_list_insert(masterList,	colors.saffron,		$30c4f4);	
ds_list_insert(masterList,	colors.gold,		$00c8ff);
ds_list_insert(masterList,	colors.yellow,		$00ffff);	
ds_list_insert(masterList,	colors.chartreuse,	$00ffdf);	
ds_list_insert(masterList,	colors.lime,		$2fffad);	
ds_list_insert(masterList,	colors.lightGreen,	$90ee90);
ds_list_insert(masterList,	colors.darkGreen,	$006400);
ds_list_insert(masterList,	colors.sage,		$89ab9a);
ds_list_insert(masterList,	colors.seaGreen,	$578b2e);
ds_list_insert(masterList,	colors.teal,		$808000);
ds_list_insert(masterList,	colors.cyan,		$ffff00);
ds_list_insert(masterList,	colors.turquoise,	$c8d530);
ds_list_insert(masterList,	colors.lightBlue,	$e6d8ad);
ds_list_insert(masterList,	colors.silver,		$d4b8b8);
ds_list_insert(masterList,	colors.darkBlue,	$800000);
ds_list_insert(masterList,	colors.indigo,		$82004b);
ds_list_insert(masterList,	colors.noir,		$29001e);
ds_list_insert(masterList,	colors.violet,		$ff0080);
ds_list_insert(masterList,	colors.fuchsia,		$ff20b8);
ds_list_insert(masterList,	colors.skintone1,	$80b3ff);
ds_list_insert(masterList,	colors.skintone2,	$6c9ade);
ds_list_insert(masterList,	colors.skintone3,	$5981be);
ds_list_insert(masterList,	colors.skintone4,	$45699e);
ds_list_insert(masterList,	colors.skintone5,	$32507e);
ds_list_insert(masterList,	colors.skintone6,	$1f385e);

// convert master list to an encoded string
global.allColors = encode_list(masterList);

// delete the master 
ds_list_destroy(masterList);
