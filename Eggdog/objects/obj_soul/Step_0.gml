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

//Runs all the logic if the soul isn't being moved to/from the party member.
if moveto == 0 {
	if !input(vk_shift) {
		xspeed = 8*input(global.left);
		yspeed = 8*input(global.up);
	} else {
		xspeed = 4*input(global.left);
		yspeed = 4*input(global.up);
	}
	x += xspeed;
	y += yspeed;
} else if moveto == 1 {
	if (distance_to_point(622, 322)) > 30 move_towards_point(622, 322, 30) else {
		x = 622;
		y = 322;
		speed = 0;
		moveto = 0;
	}
}