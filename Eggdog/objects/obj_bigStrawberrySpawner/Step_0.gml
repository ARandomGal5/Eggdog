//Used to spawn big strawberries once all 5 strawberry slices are collected.
//Checks if the player has all 5 slices.
if obj_player.slice = 5 {
	//Creates a big strawberry at this object's position.
	instance_create_layer(x, y, "objects", obj_bigStrawberry);
	//Deactivates self so only one strawberry is spawned and extra preformance.
	instance_deactivate_object(self);
}