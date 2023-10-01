if _id == 0 {
	if ctime > 130 {
		draw_sprite_ext(spr_deltaExclamation, -1, 352, 864, 4, 4, 0, c_white, 1);
	}
	if ctime > 180 {
		//Draws the text box itself.
		draw_sprite_ext(spr_deltaText, -1, 960, 0, 4, 4, 0, c_white, 1);
		//Creates a font from the deltarune font sprite and saves it to 'font'.
		font = font_add_sprite(spr_deltaFont, ord(" "), true, 6);
		//Draws the eggdog portrait sprite.
		draw_sprite_ext(spr_eggPortrait, -1, 458, 76, 4, 4, 0, c_white, 1);
		//Saves the string in a local variable.
		var _string = "eg\nEGGDOG WANTS TO BATTLE"
		//Increases a ticker called "textcount"
		textcount += 1
		//If the ticker is divisible by four (or two while holding jump to make the text scroll faster) and the text isn't done 'scrolling'...
		if (frac(textcount/4) == 0 && !input(global.jump) || frac(textcount/2) == 0 && input(global.jump)) && textprogress < string_length(_string) {
			//Increase the amount of characters drawn.
			textprogress += 1;
			//Play the talk sound effect for each character.
			audio_play_sound(snd_eggTalk, 1, false);
		}
		//Creates a NEW string that is the original string, but with the characters 'cropped' to the variable that is incremented on every four ticks.
		var _stringpart = string_copy(_string, 0, textprogress);
		
		//Sets the font to the deltarune font.
		draw_set_font(font);
		//Sets the font color to white.
		draw_set_color(c_white);
		//Draws the two * seperatly so that they don't scroll.
		draw_text_ext(668, 60, "*", 72, 850);
		draw_text_ext(668, 132, "*", 72, 850);
		//Draws the actual string we got from the string_copy function.
		draw_text_ext(728, 60, _stringpart, 72, 850);
	}
}