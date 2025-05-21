// create all action menu option functions
function open_appearance_editor() {
	// OPEN APPEARANCE EDITOR
	room_transition(player.x, player.y, player.facing, rm_appearanceEditor, bgm_menuTheme);
}

function open_spellbook_builder() {
	room_transition(player.x, player.y, player.facing, rm_spellbookBuilder, bgm_menuTheme);
}

function open_teambuilder() {
	room_transition(player.x, player.y, player.facing, rm_teambuilder, bgm_menuTheme);	
}

function open_wavephone_player() {
	player.state = humanStates.playingWavephone;
	
	create_once(x, y, LAYER.meta, wavephoneController);
}

function open_inventory() {
	
}