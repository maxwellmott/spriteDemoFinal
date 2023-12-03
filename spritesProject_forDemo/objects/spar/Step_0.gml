/// @desc

// spar phase switch statement
switch (sparPhase) {
	case sparPhases.height:
	
	break;
	
	case sparPhases.turnEnd:
	
	break;
	
	case sparPhases.process:
	
	break;
	
	case sparPhases.select:
		// use a switch statement to manage all selectionPhases
		switch(selectionPhase) {
			case selectionPhases.ally:
				// set selection message
				selectionMsg = "Select a sprite to command";
				
				// create ready button if all sprites are ready
				if check_all_allies_ready() {
					create_once(0, 0, LAYER.ui, sparReadyButton);	
				}
			break;
			
			case selectionPhases.action:
				// destroy readyButton if it exists
				destroy_if_possible(sparReadyButton);
				
				// set selection message
				selectionMsg = "What should " + player.selectedAlly.name + " do this turn?";
				
				// create action menu
				create_once(x, y, LAYER.meta, sparActionMenu);
			break;
			
			case selectionPhases.target:
				var a = global.action;
				
				// switch statement to set selectionMsg text
				switch(a) {
					case sparActions.attack:
						selectionMsg = "Select a sprite within range to target with a basic attack";
					break;
					
					case sparActions.spell:
						selectionMsg = "Select a sprite within range to target with a spell";
					break;
					
					case sparActions.swap:
						selectionMsg = "Select the sprite with whom " + player.selectedAlly.name + " should swap";
					break;
				}
				
				// handle backspace input
				if (global.back) {
					selectionPhase = selectionPhases.action;
				}
			break;
		}
			
		if (player.ready) {
			destroy_if_possible(sparReadyButton);
			
			switch (global.sparType) {
				case sparTypes.inGame:
					sparPhase = sparPhases.process;
				break;
			}
			
			selectionMsg = "Waiting for the other player...";
		}
	break;
	
	case sparPhases.turnBegin:
		sparPhase = sparPhases.select;
	break;
}

// sparComplete logic
