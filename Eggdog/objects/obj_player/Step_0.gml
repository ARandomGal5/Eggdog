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

//Checks if you collect a strawberry.
if place_meeting(x, y, obj_strawberry) {
	//Increases your berry count by 1.
	berry += 1;
	//Saves the instance ID of the collected berry.
	var _berry = instance_place(x, y, obj_strawberry)
	//Destroys the collected berry.
	instance_destroy(_berry);
}

//Checks if you collect a yolk heart
if place_meeting(x, y, obj_yolk) {
	//Increase your health by 1 if you are not at max health.
	if _health < 3 _health += 1;
	//Saves the instance ID of the yolk heart.
	var _yolk = instance_place(x, y, obj_yolk)
	//Destroys the collected yolk heart.
	instance_destroy(_yolk);
}

//Checks if you collide with an enemy.
if place_meeting(x, y, obj_enemy) {
	//Checks if you are in the spinning state,
	if state == spin {
		//Saves the instance ID of the enemy.
		var _enemy = instance_place(x, y, obj_enemy);
		//Destroys the enemy.
		instance_destroy(_enemy);
	//If you are not in the spinning state and don't have invincibilty frames, set your state to the hurt state.
	} else if iframe <= 0 state = hurt;
}

//Checks if you collide with a spike.
if place_meeting(x, y, obj_spike) {
	//Set your health to 0.
	_health = 0;	
}


//Floor states.
if onfloor == true {
	//Make the hurt state override all of the other ground states.
	if state != hurt {
		//Make the spin state override the running and idle state.
		if state != spin {
			//Checks if you are pressing a horizontal key and sets your state to running, otherwise set it to idle.
			if input(global.left) != 0 state = running else state = idle;
		}
		//Checks if you press the jump button and send you into the jumping state.
		if input(global.jump) {
			yspeed = -jumpinit;
			state = jumping;
		}
		//Checks if you press down while unstretched, and will make you spin.
		if input(global.down) == 1 && (xspeed >= 8 || xspeed <= -8) && spinpressed == true state = spin;
	}
//Off floor states.
} else {
	//Make the hurt state override all of the other ground states.
	if state != hurt {
		if state != jumping state = falling;
		//Checks if you have ledge tolerence and press the jump button, and will cause you to jump.
		if input(global.jump) && ledgetol >= 0 {
			yspeed = -jumpinit;
			state = jumping;
		}
	}
}

//Checks if you are pressing up and not unstretching.
if input(global.up) == -1 && stretchreset == false {
	//If you are under the maximum stretch amount and there is not a collision object above where you will stretch to next, increase your stretch amout by 5 every frame.
	if stretch < stretchmax && place_empty(x, y - 10, obj_col) stretch += 5;
	//If you are over the max stretch length, reset to the max.
	if stretch > stretchmax stretch = stretchmax;
	//Checks if the next space filled by your stretch will be occupied.
	if place_meeting(x, y - 10, obj_col) {
		//Loops until you are level with the ceiling to snap you against it.
		for(var _i = 1; place_empty(x, y - _i - 5, obj_col); _i++) {
			stretch += 1;
		}
	}
}

//Checks if you press a vertical input and are currently stretched, and aren't unstretching already.
if input_pressed(global.down) != 0 && stretch > 1 && stretchreset = false {
	//Sets if you are unstretching up or down.
	if input_pressed(global.up) = -1 stretchdir = 0
	if input_pressed(global.down) = 1 stretchdir = 1;
	//Sets that you are unstretching.
	stretchreset = true;
}

//Checks if you are unstretching.
if stretchreset == true {
	//Unstretch by 30 every frame.
	stretch -= 30; 
	//If you are unstretching up, decrease your Y by double the unstretch rate so that you go up.
	if stretchdir = 0 && stretch > 0 y -= 60;
	//If you are done strecthing, set your stretch to 0 and stpo unstretching.
	if stretch <= 0 {
		stretch = 0;
		stretchreset = false;
	}
}

//Sets your image xscale to 4 (to resize the pixel art) times your x-direction (to flip the image if you are facing left)
image_xscale = 4*xdir;
//If you are currently stretching, set your yscale to 4 + your stretch/8 (honestly I am unsure why this specifically works), and if you are not stretching set it to the default of 4.
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
	xdir = input(global.left);
	//Activates ledge tolerence, making it so that it is only in effect if you were previously running before falling.
	ledgetol = 3;
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

if state == spin {
	xspeed -= 0.25*xdir;
	if (xspeed < 0.25 && xspeed > 0 || xspeed > -0.25 && xspeed < 0) xspeed = 0;
	if xspeed == 0 || input(global.down) != 1 state = idle;
	spinpressed = false;
	sprite_index = spr_eggSpin;
} else {
	if input(global.down) != 1 spinpressed = true;
	if frac(xspeed) != 0 xspeed = round(xspeed);
	sprite_index = spr_egg;
}
if state == hurt {
	//If is your first frame of being hurt decrease your health by 1 and set your invincibilty frames to 30 frames (so it is only done once).
	if hurttime == 20 {
		iframe = 30;
		_health -= 1;
		yspeed = -20;
	}
	if yspeed < termveloc yspeed += 2;
	//Decreases the hurt timer by 1 every frame.
	hurttime -= 1;
	//Sets your horizontal speed to 5 in the opposite way you are facing.
	xspeed = -5*xdir;
	//If your hurt time is up, change states.
	if hurttime == 0 state = idle;
} else hurttime = 20;
//If you have invincibilty frames decrease the counter by 1 every frame.
if iframe >= 0 iframe -= 1;

//Checks if you have died.
if _health <= 0 {
	//Sets your position to the position of your last checkpoint.
	x = chx;
	y = chy;
	//Resets your state to idle.
	state = idle;
	//Resets your speeds to 0.
	xspeed = 0;
	yspeed = 0;
	//Gives you 30 frames of invincibility.
	iframe = 30;
	//Resets your stretch.
	stretch = 0;
	//Resets your health to 3.
	_health = 3;
}