x += xspeed;
y += yspeed;

if !input(vk_shift) {
	xspeed = 8*input(global.left);
	yspeed = 8*input(global.up);
} else { 
	xspeed = 4*input(global.left);
	yspeed = 4*input(global.up);
}

//Runs all the logic if the soul isn't being moved to/from the party member.
if moveto == 1 {
	if (distance_to_point(622, 322)) > 30 move_towards_point(622, 322, 30) else {
		x = 622;
		y = 322;
		speed = 0;
		moveto = 0;
	}
}

//Checks for collision with bullets.
if place_meeting(x, y, obj_bullet) && iframes < 0 {
	var _bullet = instance_place(x, y, obj_bullet)
	obj_battle.party[obj_battle.partytarget].hp -= (_bullet.attack - obj_battle.party[obj_battle.partytarget].defense)
	audio_play_sound(snd_soulHurt, 1, false);
	iframes = 31;
}
if collision_rectangle(bbox_left - 20, bbox_top - 20, bbox_right + 20, bbox_bottom + 20, obj_bullet, false, true) {
	graze = true;	
} else graze = false;

if graze == true {
	if grazetime == 0 {
		if obj_battle.tp <= 98 obj_battle.tp += 2 else obj_battle.tp = 100;
		audio_play_sound(snd_soulGraze, 1, false);
	}
	grazetime += 1;
} else grazetime = 0;
if iframes >= 0 {
	iframes -= 1;
}
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