xspeed = 0;
yspeed = 0;

//Saves the inital position of the rock to reset it on player death.
firstx = x;
firsty = y;

//Unclips the rock if it spawns in the floor.
if tile_meeting(x, y + 1, "tiles") y -= 1;