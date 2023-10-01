image_index = state;

if place_meeting(x, y, obj_player) && state == 0 {
	obj_player.chx = x;
	obj_player.chy = y;
	//If there are ruins spikes in the map save the state of all of them.
	if instance_exists(obj_ruinsSpike) {
		for(var _i = 0; _i < instance_number(obj_ruinsSpike); _i++) {
			instance_find(obj_ruinsSpike, _i).firststate = instance_find(obj_ruinsSpike, _i).state;
		}
	}
	state = 1;
}

