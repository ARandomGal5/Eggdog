if tile_meeting(x + xspeed, y, "tiles") {
	//Loop you out of it.
	while !tile_meeting(x + sign(xspeed), y, "tiles") {
		x += sign(xspeed)
	}
	//Set your horizontal speed to 0.
	xspeed = 0;
}

//Same thing but vertical.
if tile_meeting(x, y + yspeed, "tiles") {
	while !tile_meeting(x, y + sign(yspeed), "tiles") {
		y += sign(yspeed)
	}
	yspeed = 0;
}

//Check for horizontal collision.
if place_meeting(x + xspeed, y, obj_col) {
	//Loop you out of it.
	while !place_meeting(x + sign(xspeed), y, obj_col) {
		x += sign(xspeed)
	}
	//Set your horizontal speed to 0.
	xspeed = 0;
}

//Same thing but vertical.
if place_meeting(x, y + yspeed, obj_col) {
	while !place_meeting(x, y + sign(yspeed), obj_col) {
		y += sign(yspeed)
	}
	yspeed = 0;
}

x += xspeed;
y += yspeed;

if place_meeting(x - obj_player.xspeed, y, obj_player) {
	if (obj_player.x < x && sign(obj_player.xspeed) == 1 || obj_player.x > x && sign(obj_player.xspeed) == -1) {
		xspeed = obj_player.xspeed;
	}
}
if place_meeting(x, y, obj_player) {
	if tile_meeting(x - sign(obj_player.xspeed), y, "tiles") x += 50*sign(obj_player.xspeed)
}


if !place_meeting(x, y, obj_player) xspeed = 0;

//Makes the rock fall if there is nothing below it
if !tile_meeting(x, y + 1, "tiles") && !place_meeting(x, y + 1, obj_col) yspeed += 1 else yspeed = 0;
//Resets the position of the rock if the player dies.
if obj_player._health == 0 {
	x = firstx;
	y = firsty;
	if tile_meeting(x, y + 1, "tiles") y -= 1;
}