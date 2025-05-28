/// @description Insert description here
// You can write your code in this editor

audio_push_sfx(sfx_bookOpen);

ID = -1;

name	= "";
author	= "";
color	= -1;
text	= -1;
font	= -1;

pages		= ds_list_create();
spriteIDs	= ds_list_create();

rightPageX	= 138;
leftPageX	= 15;

textY = 29;

pageHeight	= 160;
pageWidth	= 104;

pageIndex		= 0;
leftPageNum		= 0;
rightPageNum	= 0;

rightPageText	= "";
leftPageText	= "";

imageGrid	= ds_grid_create(4, 0);
headingGrid = ds_grid_create(4, 0);

bookBuilt = false;

turningPageRight = false;
turningPageLeft = false;
turningPage = false;
pageTurned = false;

headingCount	= 0;
imageCount		= 0;

flipFrame = 0;

textColor = $14506e;

fontHeight = 8;

introFinished = false;
outroStarted = false;