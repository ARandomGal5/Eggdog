// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function input(key){
	//Horizontal inputs, accepts either left or right key for convience. Returns -1 on left inputs, 1 on right inputs, and 0 if there is no horizontal input.
	if (key == global.left || key == global.right) {
		return keyboard_check(global.right) - keyboard_check(global.left);	
	} else if (key == global.up || key == global.down) {
		return keyboard_check(global.down) - keyboard_check(global.up);	
	} else if key == global.jump {
		return keyboard_check(global.jump);
	} else {
		return keyboard_check(key);	
	}
}