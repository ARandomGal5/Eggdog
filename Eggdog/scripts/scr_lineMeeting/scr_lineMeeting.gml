function line_meeting(){
	if place_meeting(x, y, obj_semiSolid) {
		var semisolid = instance_place(x, y, obj_semiSolid)
		if bbox_bottom == semisolid.bbox_top return true else return false;
	}
}