/// @desc

x = 0;
y = guiHeight - 96;

global.overworld = false;

alertID = overworld.alertStack[|0];

alertGrid = ds_grid_create(overworldAlertParams.height, overworldAlerts.height);

decode_grid(global.allOverworldAlerts, alertGrid);

text		= alertGrid[# overworldAlertParams.text,			alertID];
ynPrompt	= real(alertGrid[# overworldAlertParams.ynPrompt,	alertID]);
func		= real(alertGrid[# overworldAlertParams.func,		alertID]);

ds_grid_destroy(alertGrid);

//textX	= camera.x - 112;
//textY	= camera.y + 32;

textX	= x;
textY	= y;

if (ynPrompt) yesNo = new overworld_yesNoPrompt(func);

textFormatted = false;
writtenText = "";