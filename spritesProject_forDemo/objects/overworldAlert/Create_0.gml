/// @desc

x = 0;
y = guiHeight - sprite_get_height(spr_talkBubble);

global.overworld = false;

alertID = overworld.alertStack[|0];

alertGrid = ds_grid_create(overworldAlertParams.height, overworldAlerts.height);

decode_grid(global.allOverworldAlerts, alertGrid);

text		= alertGrid[# overworldAlertParams.text,			alertID];
ynPrompt	= real(alertGrid[# overworldAlertParams.ynPrompt,	alertID]);
func		= real(alertGrid[# overworldAlertParams.func,		alertID]);

ds_grid_destroy(alertGrid);

textX	= x + 4;
textY	= y + 4;

if (ynPrompt) {
	global.ynFunction = func;
	create_once(0, 0, LAYER.meta, yesNoPrompt);
}

textFormatted = false;
writtenText = "";