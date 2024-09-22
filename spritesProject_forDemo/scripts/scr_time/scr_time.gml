// enumerator containing season IDs
enum seasons {
	daysOfBones,
	mothersMoon,
	gamnsWalk,
	spherasRest,
	height
}

//  enumerator containing weekday IDs
enum weekdays {
	hyggsun,
	plughsun,
	rumnsun,
	famelsun,
	height
}

///@desc This function fades a layer of darkness in/out
/// depending on the time of day
function set_dark() {
	if (hours < 5) || (hours >= 19) {
		sundown = true;
	}
	
	if (hours >= 5) && (hours < 19) {
		sundown = false;	
	}
}

///@desc This function fades a layer of darkness in/out
/// depending on the type of indoor location
function indoor_set_dark() {
	
}

///@desc This function increments seconds in the game world
function increment_seconds() {
	if !(global.gameTime mod room_speed) {
		seconds += 30;
	}
}

///@desc This function increments minutes in the game world
function increment_minutes() {
	if (seconds >= 60) {
		minutes += 1;
		seconds -= 60;
		
		if (global.overworld) {
			if (instance_exists(overworld)) {
				with (overworld) {
					if (global.rainActive)
					&& !(lightningActive) {
						minutesSinceLightning++;
					}
				}
			}
		}
	}
}

///@desc This function increments hours in the game world
function increment_hours() {
	if (minutes >= 60) {
		hours += 1;
		minutes -= 60;
	}
}

///@desc This function indicates that it is time to begin the day
/// change cutscene
function begin_day_change() {
	if hours >= 24 
	&& !(instance_exists(transitionManager)) {
		room_transition(x, y, facing, rm_dayChange, bgm_dayChange);	
	}
}

///@desc This function is called during the day change cutscene. The
/// function sets all of the time/day parameters for the player for
/// the next day
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

///@desc This function is called at the beginning of a new game to set the
/// first week.
function initialize_week() {
	
}

///@desc This function is called at the beginning of a new game to set the
/// first year.
function initialize_year() {
	
}

///@desc This function is called at the beginning of a new game to set the
/// first day
function initialize_day() {
	
}

///@desc This function is called at the beginning of a new game to set the
/// first season
function initialize_season() {
	
}