if (optionsChangingDown) {
	if (rowFiveFrame == 1) {
		alarm[1] = alarmTime;
		rowFiveFrame = 0;
	}
	
	else if (rowFourFrame == 1) {
		rowFiveFrame = 1;
		rowFourFrame = 0;
	}
	
	else if (rowThreeFrame == 1) {
		rowFourFrame = 1;
		rowThreeFrame = 0;
	}	
	
	else if (rowTwoFrame == 1) {
		rowThreeFrame = 1;
		rowTwoFrame = 0;
	}
	
	else if (rowOneFrame == 1) {
		rowTwoFrame = 1;
		rowOneFrame = 0;
	}
}

if (optionsChangingUp) {
	if (rowOneFrame == 1) {
		alarm[1] = alarmTime;
		rowOneFrame = 0;
	}
	
	else if (rowTwoFrame == 1) {
		rowOneFrame = 1;
		rowTwoFrame = 0;
	}
	
	else if (rowThreeFrame == 1) {
		rowTwoFrame = 1;
		rowThreeFrame = 0;
	}	
	
	else if (rowFourFrame == 1) {
		rowThreeFrame = 1;
		rowFourFrame = 0;
	}
	
	else if (rowFiveFrame == 1) {
		rowFourFrame = 1;
		rowFiveFrame = 0;
	}
}