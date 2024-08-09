/// @description Insert description here
// You can write your code in this editor
tied = false;

winner = -1;

p1 = spar.playerOne;
p2 = spar.playerTwo;

if (p1.currentHP <= 0) {
	winner = p2;	
	text = "YOU LOSE!";
}

if (p2.currentHP <= 0) {
	winner = p1;	
	text = "YOU WIN!";
}

if (p1.currentHP <= 0)
&& (p2.currentHP <= 0) {
	tied = true;
	text = "IT'S A TIE!";
}
