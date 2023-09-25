//Checks for horizontal collision.
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

if !input(vk_shift) {
	xspeed = 8*input(global.left);
	yspeed = 8*input(global.up);
} else {
	xspeed = 4*input(global.left);
	yspeed = 4*input(global.up);
}