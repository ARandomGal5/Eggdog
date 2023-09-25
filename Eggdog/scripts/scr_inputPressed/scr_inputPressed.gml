// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function input_pressed(key){
	//Horizontal inputs, accepts either left or right key for convience. Returns -1 on left inputs, 1 on right inputs, and 0 if there is no horizontal input.
	if (key == global.left || key == global.right) {
		return keyboard_check_pressed(global.right) - keyboard_check_pressed(global.left);	
	}
	
	if (key == global.up || key == global.down) {
		return keyboard_check_pressed(global.down) - keyboard_check_pressed(global.up);	
	}
	
	if key == global.jump {
		return keyboard_check_pressed(global.jump);
	}
	
	if key == global.back {
		return keyboard_check_pressed(global.back);
	}
}