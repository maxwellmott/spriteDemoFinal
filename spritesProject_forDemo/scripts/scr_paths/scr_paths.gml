enum PATHS {
	BOOKISH_LIBRARY_PATH,
	HEIGHT
}

var bookishLibraryPath = ds_list_create();

ds_list_add(bookishLibraryPath, "<`200`200>","<`240`200>","<`240`240>","<`200`240>");

var pathMasterList = ds_list_create();

pathMasterList[| PATHS.BOOKISH_LIBRARY_PATH]	= encode_list(bookishLibraryPath);

global.allPaths = encode_list(pathMasterList);