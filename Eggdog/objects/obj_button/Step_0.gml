image_index = firstframe + state;

if place_meeting(x, y, obj_rock) || place_meeting(x, y, obj_player) {
	if state == 0 statechange = true;
	state = 1
}

if state = 1 && !place_meeting(x, y, obj_rock) && !place_meeting(x, y, obj_player) {
	statechange = true;
	state = 0;
}

if statechange = true {
	for(var _i = 0; _i < instance_number(obj_ruinsSpike); _i++) {
		if instance_find(obj_ruinsSpike, _i)._id == _id {
			instance_find(obj_ruinsSpike, _i).state = !instance_find(obj_ruinsSpike, _i).state;	
		}
	}
	audio_play_sound(snd_ruinsSwitch, 1, false);
	statechange = false;
}