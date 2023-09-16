if place_meeting(x, y, obj_player) && active == true {
	for(var _i = 0; _i < instance_number(obj_ruinsSpike); _i++) {
		if instance_find(obj_ruinsSpike, _i)._id == _id {
			instance_find(obj_ruinsSpike, _i).state = !instance_find(obj_ruinsSpike, _i).state;	
		}
	}
	active = false;
}
if !place_meeting(x, y, obj_player) active = true;