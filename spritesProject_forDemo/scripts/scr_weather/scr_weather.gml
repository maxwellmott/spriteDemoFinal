// this is a global variable that stores
// the number of days since it last rained
global.daysSinceRain	= 0;
global.rainActive = true;

///@desc This function is called incrementally by the overworld
/// object to roll to see if it should rain on the current day.
/// it takes into consideration the currentSeason as well as daysSinceRain
function overworld_check_rain_begin() {
	// reset the seed
	randomize();
	
	// initialize the highest value for the roll
	var rollMax = 0;
	
	// initialize the lowest possible roll to START rain
	var minRoll = 0;
	
	// use a switch statement to process the currentSeason's roll logic
	// (this statement excludes the days of bones because it snows every
	// day during that season)
	switch (player.currentSeason) {
		case seasons.gamnsWalk:		// SPRING
			// do a "final check"
			if (global.daysSinceRain == 12) {
				// set global.rainActive to true
				global.rainActive = true;
				
				// reset daysSinceRain
				global.daysSinceRain = 0;
			}
			// if it hasn't hit the final point before rain must start
			// then just perform a regular check
			else {
				// if it rained in the last eleven days
				if (global.daysSinceRain <= 11) {
					// there should be a good chance that it will rain
					rollMax = 10;
					minRoll = 2;
				}				
				
				// if it rained in the last eight days
				if (global.daysSinceRain <= 8) {
					// there should be a slight chance that it will rain
					rollMax = 10;
					minRoll = 6;
				}
				
				// if it rained in the last four days
				if (global.daysSinceRain <= 4) {
					// there should be little chance that it will rain
					rollMax = 10;
					minRoll = 8;
				}				
				
				// if it rained yesterday
				if (global.daysSinceRain <= 1)	{
					// there should be a good chance that it will rain again
					rollMax = 10;
					minRoll = 3;
				}
				
				// get a random integer using the set rollMax
				var r = irandom_range(1, rollMax);
				
				// check if the random integer is higher than the minimum
				if (r >= minRoll) {
					// set rain active to true
					global.rainActive = true;
					
					// reset daysSinceRain
					global.daysSinceRain = 0;
				}
			}
		break;
		
		case seasons.mothersMoon:	// SUMMER
			// do a "final check"
			if (global.daysSinceRain == 16) {
				// set global.rainActive to true
				global.rainActive = true;
				
				// reset daysSinceRain
				global.daysSinceRain = 0;
			}
			// if it hasn't hit the final point before rain must start
			// then just perform a regular check
			else {
				// if it rained in the last fifteen days
				if (global.daysSinceRain <= 15) {
					// there should be a good chance that it will rain
					rollMax = 10;
					minRoll = 2;
				}
				
				// if it rained in the last eight days
				if (global.daysSinceRain <= 8) {
					// there should be a slight chance that it will rain
					rollMax = 10;
					minRoll = 6;
				}
				
				// if it rained in the last 4 days
				if (global.daysSinceRain <= 4) {
					// there should be a good chance of rain
					rollMax = 9;
					minRoll = 4;
				}
				
				// if it rained yesterday
				if (global.daysSinceRain <= 1) {
					// there should be a very small chance of rain
					rollMax = 11;
					minRoll = 2;
				}
			}
		break;
		
		case seasons.spherasRest:	// AUTUMN
			// do a "final check"
			if (global.daysSinceRain == 6) {
				// set global.rainActive to true
				global.rainActive = true;
				
				// reset daysSinceRain
				global.daysSinceRain = 0;
			}
			// if it hasn't hit the final point before rain must start
			// then just perform a regular check
			else {
				// if it rained in the last 5 days
				if (global.daysSinceRain <= 5) {
					// there should be a good chance of rain
					rollMax = 15;
					minRoll = 2;
				}
				
				// if it rained in the last 3 days
				if (global.daysSinceRain <= 3) {
					// there should be a chance of rain
					rollMax = 15;
					minRoll = 4;
				}
				
				// if it rained yesterday
				if (global.daysSinceRain <= 1) {
					// there should be a chance of rain
					rollMax = 7;
					minRoll = 3;
				}
			}
		break;
	}
}

function overworld_check_lightning_start() {
	
}

function overworld_check_lightning_stop() {
	
}

function overworld_lightning_step() {
	
}