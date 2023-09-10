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

//Increment your position by your speed values every frame.
x += xspeed;
y += yspeed;

//Checks if you are on the floor.
if place_meeting(x, y + 1, obj_col) onfloor = true else onfloor = false;

//Floor states.
if onfloor == true {
	//Checks if you are pressing a horizontal key and sets your state to running, otherwise set it to idle.
	if input(global.left) != 0 state = running else state = idle;
	//Checks if you press the jump button and send you into the jumping state.
	if input(global.jump) {
		yspeed = -jumpinit;
		state = jumping;
	}
//Off floor states.
} else {
	if state != jumping state = falling;
	//Checks if you have ledge tolerence and press the jump button, and will cause you to jump.
	if input(global.jump) && ledgetol >= 0 {
		yspeed = -jumpinit;
		state = jumping;
	}
}

if input_pressed(global.down) != 0 && stretch > 1 && stretchreset = false {
	if input_pressed(global.up) = -1 stretchdir = 0
	if input_pressed(global.down) = 1 stretchdir = 1;
	stretchreset = true;
}

if input(global.up) == -1 && stretchreset == false {
	if stretch < stretchmax && place_empty(x, y - 10, obj_col) stretch += 5;
	if place_meeting(x, y - 10, obj_col) {

	}
}

if stretchreset == true {
	stretch -= 15; 
	if stretchdir = 0 y -= 30;
	if stretch <= 0 {
		stretch = 0;
		stretchreset = false;
	}
}
if stretch != 0 image_yscale = 4+stretch/8 else image_yscale = 4;

if state == idle {
	//If you are moving, decrease your speed by 2 every frame.
	if xspeed > 0 xspeed -= 2;
	if xspeed < 0 xspeed += 2;
	//Round your speed down to 0 once it is equal to 1.
	if xspeed = 1 || xspeed = -1 xspeed = 0;
}
if state == running {
	//Checks if you are under the speed cap in the direction you are holding, then accelerates your speed every frame.
	if (input(global.left) == -1 && xspeed > -maxspeed || input(global.right) == 1 && xspeed < maxspeed) xspeed += accel*input(global.left);
	//Activates ledge tolerence, making it so that it is only in effect if you were previously running before falling.
	ledgetol = 5;
}

if state == falling {
	//Same horizontal movement as running.
	if (input(global.left) == -1 && xspeed > -maxspeed || input(global.right) == 1 && xspeed < maxspeed) xspeed += accel*input(global.left);
	//If you stop pressing horizontal keys, decrease your speed by 1 every frame.
	if input(global.left) == 0 {
		if xspeed > 0 xspeed -= 1;
		if xspeed < 0 xspeed += 1;
	}
	//If your vertical speed is less than terminal velocity, and you aren't unstretching, increase your falling speed.
	if yspeed < termveloc && stretchreset = false yspeed += fallaccel;
	//If you are unstretching, set your vertical speed to 0.
	if stretchreset = true yspeed = 0;
	ledgetol -= 1;
}

if state == jumping {
	//Same horizontal movement as running.
	if (input(global.left) == -1 && xspeed > -maxspeed || input(global.right) == 1 && xspeed < maxspeed) xspeed += accel*input(global.left);
	//If you are not pressing horizontal keys, decrease your speed by 1 every frame.
	if input(global.left) == 0 {
		if xspeed > 0 xspeed -= 1;
		if xspeed < 0 xspeed += 1;
	}
	//If your vertical speed is less than terminal velocity, and you aren't unstretching, increase your falling speed.
	if yspeed < termveloc && stretchreset = false yspeed += jumpdeccel;
	//If you are unstretching, set your vertical speed to 0.
	if stretchreset = true yspeed = 0;
	//If you let go of the jump key start falling.
	if !input(global.jump) state = falling;
	//If you start moving down, start falling.
	if yspeed >= 0 state = falling;
	ledgetol = -1;
}