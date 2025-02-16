enum DYES {
	WINTERBERRY_RED,
	TIDEMOLD_BLUE,
	STUMPMOSS_GREEN,
	
	HEIGHT
}

var dyesList = ds_list_create();

var i = 0;	repeat (DYES.HEIGHT) {
	dyesList[| i] = i;

	i++;	
}