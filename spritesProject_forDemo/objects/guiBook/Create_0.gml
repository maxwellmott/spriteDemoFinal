/// @description Insert description here
// You can write your code in this editor

ID = -1;

name	= "";
author	= "";
color	= -1;
text	= -1;
font	= -1;

pages		= ds_list_create();
spriteIDs	= ds_list_create();

rightPageX	= 135;
leftPageX	= 12;

textY = 30;

pageHeight	= 324;
pageWidth	= 218;

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