enum PATHS {
	BOOKISH_LIBRARY_PATH,
	HEIGHT
}

var bookishLibraryPath = ds_list_create();

								// the first step of a path like this should always match the sprite's starting coordinates for that room
ds_list_add(bookishLibraryPath, "<`80`208>","<`180`208>","<`180`320>","<`144`320>",
								"<`144`304>","<`-2`200>","<`144`320>","<`112`320>","<`112`304>",
								"<`-2`200>","<`112`320>","<`272`320>","<`272`304>","<`-2`200>",
								"<`272`320>","<`356`320>","<`356`208>","<`404`208>","<`404`192>",
								"<`-2`200>","<`404`208>","<`560`208>","<`560`192>","<`-2`200>",
								"<`560`208>","<`496`208>","<`496`320>","<`272`320>","<`272`304>",
								"<`-2`200>","<`272`320>","<`212`320>","<`212`208>","<`80`208>",
								"<`80`192>","<`-2`200>");

var pathMasterList = ds_list_create();

pathMasterList[| PATHS.BOOKISH_LIBRARY_PATH]	= encode_list(bookishLibraryPath);

global.allPaths = encode_list(pathMasterList);