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
		switch(selectionPhase) {
			case selectionPhases.ally:
				msg = "Select a sprite to command";
			break;
			
			case selectionPhases.action:
				msg = "What should " + player.selectedAlly.name + " do this turn?";
				create_once(x, y, LAYER.meta, sparActionMenu);
			break;
			
			case selectionPhases.target:
				var a = player.selectedAlly.selectedAction;
				
				switch(a) {
					case sparActions.attack:
					break;
					
					case sparActions.spell:
					break;
					
					case sparActions.dodge:
					break;
					
					case sparActions.swap:
					break;
					
					case sparActions.rest:
					break;
				}
			break;
		}
	break;
	
	case sparPhases.turnBegin:
		sparPhase = sparPhases.select;
	break;
}

// sparComplete logic
