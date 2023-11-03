enum seasons {
	daysOfBones,
	mothersMoon,
	gamnsWalk,
	spherasRest,
	height
}

enum weekdays {
	hyggsun,
	plughsun,
	rumnsun,
	famelsun,
	height
}

function set_dark() {
	if (hours < 5) || (hours >= 19) {
		sundown = true;
	}
	
	if (hours >= 5) && (hours < 19) {
		sundown = false;	
	}
}

function indoor_set_dark() {
	
}

function increment_seconds() {
	if !(global.gameTime mod room_speed) {
		seconds += 30;
	}
}

function increment_minutes() {
	if (seconds >= 60) {
		minutes += 1;
		seconds -= 60;
	}
}

function increment_hours() {
	if (minutes >= 60) {
		hours += 1;
		minutes -= 60;
	}
}

function begin_day_change() {
	if hours >= 24 {
		room_transition(x, y, facing, rm_dayChange);	
	}
}

function dc_next_day() {
	with (player) {
		day++;
		hours = 8;
		weekday++;
	
		// increment week
		if (weekday = weekdays.height) {
			weekday -= weekdays.height;	
		}
		
		// increment season
		if (day > 48) {
			season++;
			day -= 48;
		}
		
		// increment year
		if (season == seasons.height) {
			year++;
			season -= seasons.height;
		}
	}
}

function initialize_week() {
	
}

function initialize_year() {
	
}

function initialize_day() {
	
}

function initialize_season() {
	
}