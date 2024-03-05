#region manage selector movement
if (global.menu_up) 
&& (currentRow > 0) {
	selectedNameSlot -= rowWidth;
}

if (global.menu_down)
&& (currentRow < columnHeight) {
	selectedNameSlot += rowWidth;
}

if (global.menu_left)
&& (selectedNameSlot > 0) {
	selectedNameSlot -= 1;	
}

if (global.menu_right) 
&& (selectedNameSlot < rosterHeight - 1) {
	selectedNameSlot += 1;
}

// correct for overshooting the first or last name
if (selectedNameSlot < 0)					selectedNameSlot = 0;
if (selectedNameSlot > rosterHeight - 1)	selectedNameSlot = rosterHeight - 1;

#endregion

// reset bottom and top rowNum
bottomRowNum	= selectedNameSlot div rowWidth;
topRowNum		= bottomRowNum + 4;

// check if rows have shifted higher or lower
if (bottomRowNum > lastBottomRowNum) {
	optionsChangingUp = true;
	
	//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
}

if (bottomRowNum < lastBottomRowNum) {
	optionsChangingDown = true;
	
	//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
}

// reset currentRow and currentColumn
currentRow = selectedNameSlot div rowWidth;
currentColumn = (rowWidth - 1) - ((selectedNameSlot + 1) mod rowWidth);

// manage spriteslot selection

// manage nameSlot selection

// reset selectorIndex
var start = (bottomRowNum * rowWidth) - 1;

selectorIndex = selectedNameSlot - start;

// reset selectorX and selectorY
switch (selectorIndex) {
	case 0:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowOne;	break;
	case 1:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowOne;	break;
	case 2:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowOne;	break;
	
	case 3:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowTwo;	break;
	case 4:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowTwo;	break;
	case 5:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowTwo;	break;
	
	case 6:		selectorX = nameSlotColumnOne;		 selectorY = nameSlotRowThree;	break;
	case 7:		selectorX = nameSlotColumnTwo;		 selectorY = nameSlotRowThree;	break;
	case 8:		selectorX = nameSlotColumnThree;	 selectorY = nameSlotRowThree;	break;
}