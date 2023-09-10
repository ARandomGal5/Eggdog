//States, each state is asigned a number, then when you want to change the player state you do `state = statevar', so `state = idle` is the same as `state = 0`, just easier to read and remember.
state = 0;
idle = 0;
running = 1;
falling = 2;
jumping = 3;

//The health of the player.
_health = 3;
//How many strawberries they have.
berry = 0;

//How stretched the egg is (for every +1 to the value add 2 pixels to the center).
stretch = 0;
//The max amount the egg can stretch.
stretchmax = 255;
//When you press down, set stretch reset to true, which will rapidly unstretch you.
stretchreset = false;

//Speed variables, your X and Y position is increased by them every frame.
xspeed = 0;
yspeed = 0;
//The max speed the player can move while running
maxspeed = 15;
//The base rate they accelerate while running.
accel = 2;
//The base vertical speed your jump starts at.
jumpinit = 21;
//The rate at which you fall during a jump.
jumpdeccel = 1;
//The rate at which you fall.
fallaccel = 2;
//The max speed you can fall.
termveloc = 30;
//If you have ledgetolerence
ledgetol = true;

ledgetoltime = 0;

//The game checks if there is collision a pixel under you, and if so set this variable to true. Used to know what state to put the player in.
onfloor = false;