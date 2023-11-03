/// @desc

x = player.x;
y = player.y;

alpha = 0.0;
targetAlpha = 1.00;

index = 0;

// create menu name list
nameList = ds_list_create();

nameList[|0] = "TALISMANS";
nameList[|1] = "CONTACTS";
nameList[|2] = "TRANSPORT";
nameList[|3] = "LICENSES";
nameList[|4] = "TO-DO LIST";


// create button dimension vars
var tbWidth		= sprite_get_width(ss_MainMenu_TopButton);
var tbHeight	= sprite_get_height(ss_MainMenu_TopButton);

var cbWidth		= sprite_get_width(ss_MainMenu_CenterButton);
var cbHeight	= sprite_get_height(ss_MainMenu_CenterButton);

var bbWidth		= sprite_get_width(ss_MainMenu_BottomButton);
var bbHeight	= sprite_get_height(ss_MainMenu_BottomButton);

var buttonDiff	= (cbHeight / 2) + (tbHeight / 2);

// initialize button name vars
tbName = "";
cbName = "";
bbName = "";

// initialize button function vars
tbFunc = noone;
cbFunc = noone;
bbFunc = noone;

// set y values for buttons
tbDrawY	= y - (buttonDiff);
cbDrawY	= y;
bbDrawY	= y + (buttonDiff);

// create all buttons
// @TODO replace these with the new button object
/*
topButton		= new button(ss_MainMenu_TopButton,		tbFunc, x, tbDrawY,	tbWidth, tbHeight);
centerButton	= new button(ss_MainMenu_CenterButton,	cbFunc, x, cbDrawY,	cbWidth, cbHeight);
bottomButton	= new button(ss_MainMenu_BottomButton,	bbFunc, x, bbDrawY,	bbWidth, bbHeight);
*/

// set x and y for clock
clockX = x + 56;
clockY = tbDrawY;

// initialize drawHours and drawMinutes
drawHours = string(player.hours mod 12);
drawMinutes = string(player.minutes);