/// @desc

if (ynPrompt) {
	yesNo.method_step();
}

if !(ynPrompt) {
	if global.back || global.select {
		visible = false;
		ds_list_delete(overworld.alertStack, 0);
		instance_destroy(id);
	}
}

if !textFormatted {
	text = format_text(text, 232);
	textFormatted = true;
}


if (writtenText != text)
&& !(global.gameTime mod 1) 
	writtenText = increment_text(text, writtenText);