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
				selectionMsg = "Select a sprite to command";
			break;
			
			case selectionPhases.action:
				selectionMsg = "What should " + player.selectedAlly.name + " do this turn?";
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
	break;
	
	case sparPhases.turnBegin:
		sparPhase = sparPhases.select;
	break;
}

// sparComplete logic
