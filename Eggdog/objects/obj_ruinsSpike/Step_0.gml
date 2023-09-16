if image_index != 0 && image_index != 1 startframe = image_index;
//Checks if this object contacts the player while it's deployed.
if place_meeting(x, y, obj_player) && state == 1 {
	//Sets their health to 0 to instant-kill them.
	obj_player._health = 0;	
}

//Resets the state if the player dies.
if obj_player._health == 0 state = 1;
//Sets the image index based off of the state, the active frame is one more than the non-active, so it simply adds one to the frame if the spike is active.
image_index = startframe + state;

//Sets the frame of the sprite to the state, 0 will have it use the undeployed sprite, 1 will have it use the deployed sprite.
image_index = state;