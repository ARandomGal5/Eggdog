//Tile Collisions
//Check for horizontal collision.
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

//Also has object based collisions, which has two uses.
//A. Allow for dedicated 'oveerride' collisions like invisible walls in places where there should be no tiles.
//B. Allows the collision object to parent objects that should be solid like obj_break

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


if place_meeting(x, y + yspeed, obj_semiSolid) {
	if collision_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom, obj_semiSolid, false, false) {
		while !place_meeting(x, y + sign(yspeed), obj_semiSolid) {
			y += sign(yspeed)
		}
		yspeed = 0;
	}
}

//Checks for the "pause" variable, which is set to true when you pause the game or are in a cutscene.
if pause == false {
//Increment your position by your speed values every frame.
x += xspeed;
y += yspeed;

//Checks if you are on the floor, by checking if there is a collision object or semisolid below you.
if tile_meeting(x, y + 1, "tiles") || place_meeting(x, y + 1, obj_col) || collision_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom, obj_semiSolid, false, false) {
	if collision_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom, obj_semiSolid, false, false) {
		var semisolid = collision_line(bbox_left, bbox_bottom, bbox_right, bbox_bottom, obj_semiSolid, false, false)
		if bbox_bottom >= semisolid.bbox_top && yspeed >= 0 onfloor = true;
	} else onfloor = true;
} else onfloor = false;



//Checks if you collect a strawberry.
if place_meeting(x, y, obj_strawberry) {
	//Increases your berry count by 1.
	berry += 1;
	//Saves the instance ID of the collected berry.
	var _berry = instance_place(x, y, obj_strawberry)
	//Plays the strawberry collecting sound.
	audio_play_sound(snd_strawberry, 1, false);
	//Deactivates the collected berry.
	instance_deactivate_object(_berry);
}

//Checks if you collect a yolk heart
if place_meeting(x, y, obj_yolk) {
	//Increase your health by 1 if you are not at max health.
	if _health < 3 _health += 1;
	//Saves the instance ID of the yolk heart.
	var _yolk = instance_place(x, y, obj_yolk)
	//Plays the yolk heart collecting sound.
	audio_play_sound(snd_yolk, 1, false);
	//Deactivates the collected yolk heart.
	instance_deactivate_object(_yolk);
}

//Checks if you collect a strawberry slice.
if place_meeting(x, y, obj_strawberrySlice) {
	//Increase your health by 1 if you are not at max health.
	if slice < 5 slice += 1;
	//Saves the instance ID of the yolk heart.
	var _slice = instance_place(x, y, obj_strawberrySlice)
	numx = _slice.x;
	numy = _slice.y;
	//Plays the yolk heart collecting sound.
	audio_play_sound(snd_strawberrySlice, 1, false);
	//Deactivates the collected yolk heart.
	instance_deactivate_object(_slice);
}

//Checks if you collide with an enemy.
if place_meeting(x, y, obj_enemy) {
	//Checks if you are in the spinning state,
	if state == spin {
		//Saves the instance ID of the enemy.
		var _enemy = instance_place(x, y, obj_enemy);
		//Plays the enemy destroy sound effect.
		if !audio_is_playing(snd_explosion) audio_play_sound(snd_explosion, 1, false);
		//Deactivates the enemy.
		instance_deactivate_object(_enemy);
	//If you are not in the spinning state and don't have invincibilty frames, set your state to the hurt state.
	} else if iframe <= 0 && _health > 0 state = hurt;
}

//Checks if you collide with a spike.
if place_meeting(x, y, obj_spike) {
	//Set your health to 0.
	_health = 0;	
}


//Floor states.
if onfloor == true {
	//Make the hurt state override all of the other ground states, and freezes you when you have no health (dead).
	if state != hurt && _health > 0 {
		//Make the spin state override the running and idle state.
		if state != spin {
			//Checks if you are pressing a horizontal key and sets your state to running, otherwise set it to idle.
			if input(global.left) != 0 state = running else state = idle;
		}
		//Checks if you press the jump button without a ceiling touching you and send you into the jumping state.
		if input(global.jump) && !tile_meeting(x, y - 1, "tiles") && !place_meeting(x, y - 1, obj_col) {
			//Sets your initial vertical velocity.
			yspeed = -jumpinit;
			//Plays the jump sound effect.
			audio_play_sound(snd_jump, 1, false);
			//Sets the player to the jumping state.
			state = jumping;
		}
		//Checks if you press down while unstretched, and will make you spin.
		if input(global.down) == 1 && (xspeed >= 8 || xspeed <= -8) && spinpressed == true {
			audio_play_sound(snd_spin, 1, false);
			state = spin;
		}
	}
//Off floor states.
} else {
	//Make the hurt state override all of the other off-ground states, and freezes you when you have no health (dead).
	if state != hurt && _health > 0 {
		if state != jumping state = falling;
		//Checks if you have ledge tolerence and press the jump button, and will cause you to jump.
		if input(global.jump) && ledgetol >= 0 {
			yspeed = -jumpinit;
			state = jumping;
		}
	}
}

//Checks if you are pressing up and not unstretching, and not dead.
if input(global.up) == -1 && stretchreset == false && _health > 0 {
	if stretch = 0 unstretch = false;
	//If you are under the maximum stretch amount and there is not a collision object above where you will stretch to next, increase your stretch amout by 5 every frame.
	if stretch < stretchmax && !tile_meeting(x, y - 10, "tiles") && !place_meeting(x, y - 10, obj_col) stretch += 5;
	//If you are over the max stretch length, reset to the max.
	if stretch > stretchmax stretch = stretchmax;
	//Checks if the next space filled by your stretch will be occupied.
	if tile_meeting(x, y - 10, "tiles") {
		//Loops until you are level with the ceiling to snap you against it.
		for(var _i = 1; !tile_meeting(x, y - _i - 5, "tiles"); _i++) {
			stretch += 1;
		}
	}
	
	if place_meeting(x, y - 10, obj_col) {
		//Loops until you are level with the ceiling to snap you against it.
		for(var _i = 1; !place_meeting(x, y - _i - 5, obj_col); _i++) {
			stretch += 1;
		}
	}
	
	if !audio_is_playing(snd_stretch) audio_play_sound(snd_stretch, 1, false);
	
	//Stops the streching sound if you stretch into a ceiling.
	if (tile_meeting(x, y - 10, "tiles") || place_meeting(x, y - 10, obj_col)) && audio_is_playing(snd_stretch) audio_pause_sound(snd_stretch) else audio_resume_sound(snd_stretch);
} 
if input(global.up) != -1 unstretch = true;

//Checks if you press a vertical input and are currently stretched, and aren't unstretching already.
if input_pressed(global.down) != 0 && stretch > 1 && stretchreset == false && unstretch == true {
	//Sets if you are unstretching up or down.
	if input_pressed(global.up) == -1 stretchdir = 0
	if input_pressed(global.down) == 1 stretchdir = 1;
	//Sets that you are unstretching.
	stretchreset = true;
}

//Checks if you are unstretching.
if stretchreset == true {
	//If you are unstretching up, decrease your Y by double the unstretch rate so that you go up.
	if stretchdir = 0 {
		if stretch >= 30 y -= 60 else {
			y -= stretch*2;
			if !tile_meeting(x, y - 2, "tiles") && !place_meeting(x, y - 2, obj_col) y -= 2;
		}
	}
	//Unstretch by 30 every frame.
	if stretch >= 30 stretch -= 30 else stretch = 0; 

	//If you are done strecthing, set your stretch to 0 and stpo unstretching.
	if stretch <= 0 {
		stretch = 0;
		stretchreset = false;
	}
	if !audio_is_playing(snd_stretch) audio_play_sound(snd_stretch, 1, false);
}

if (input(global.up) == 0 && stretchreset == false || stretch = stretchmax || place_meeting(x, y - 10, obj_col)) audio_stop_sound(snd_stretch);

//Sets your image xscale to 4 (to resize the pixel art) times your x-direction (to flip the image if you are facing left)
image_xscale = 4*xdir;
//If you are currently stretching, set your yscale to 4 + your stretch/8 (honestly I am unsure why this specifically works), and if you are not stretching set it to the default of 4.
if stretch != 0 image_yscale = 4+stretch/8 else image_yscale = 4;

if state == idle {
	//If you are moving, decrease your speed by your acceleration every frame.
	if xspeed > 0 xspeed -= accel;
	if xspeed < 0 xspeed += accel;
	//Round your speed down to 0 once it is equal to 1.
	if xspeed = 1 || xspeed = -1 xspeed = 0;
	if _health > 0 yspeed = 0;
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
	//Makes it so that if you touch the floor you instantly go to the idle state.
	if onfloor == true {
		yspeed = 0;
		state = idle;
	}
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
	//Decrease your speed by 0.25 every frame relative to the direction you are facing.
	xspeed -= 0.25*xdir;
	//Rounds down your speed once it gets within 0.24 of 0.
	if (xspeed < 0.25 && xspeed > 0 || xspeed > -0.25 && xspeed < 0) xspeed = 0;
	//If your speed is 0, you stop holding down, or are not moving in the direction you are facing, set yourself to idle (last one is done to prevenet jumping into a backwards roll giving you insane speed.)
	if xspeed == 0 || input(global.down) != 1 || sign(xspeed) != xdir {
		audio_stop_sound(snd_spin);
		state = idle;
	}
	//Sets that you have to let go of down before spinning again.
	spinpressed = false;
	//Set your sprite to the spin sprite.
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
		//If the hit is not fatal play the hurt sound effect.
		if _health > 0 audio_play_sound(snd_hurt, 1, false);
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
	//Resets your stretch.
	stretch = 0;
	if deathtime == -1 deathtime = 150;
	if deathtime == 150 {
		audio_play_sound(snd_explosion, 1, false);	
	}
	if deathtime >= 0 deathtime -= 1;
	state = idle;
	xspeed = 0;
	if yspeed < 0 yspeed = 0;
	if yspeed < termveloc yspeed += jumpdeccel;
	if deathtime == 0 {
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
		//Reduces your strawberries by 10 (yes going into the negatives is intentional, it is funny).
		berry -= 10;
		//Reactives all of the strawberries.
		instance_activate_object(obj_strawberry);
		//Reactives all of the yolk hearts.
		instance_activate_object(obj_yolk);
		//Reactivates all of the breakable tiles.
		instance_activate_object(obj_break);
		//Reactivates all of the enemies.
		instance_activate_object(obj_enemy);
		//Tells the game to do the reverse rectangle effect.
		undie = true;
		//Resets your health to 3.
		_health = 3;
	}
	sprite_index = spr_eggFried;
} else deathtime = -1;
}