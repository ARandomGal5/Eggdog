//Sets the color to white.
draw_set_color(c_white);

//Draws your party members.
draw_sprite_ext(spr_egg, -1, 215, 300, 4, 4, 0, c_white, 1);
draw_sprite_ext(spr_egg, -1, 250, 500, 4, 4, 0, c_white, 1);

//Draws the enemy.
draw_sprite_ext(spr_egg, -1, 1100, 375, -4, 4, 0, c_white, 1);
//(There is probably a better way to do this tbh) draws a white copy of the sprite when they're being selected and changes the opacity to make it look like they're fading in/out white.
draw_sprite_ext(spr_eggWhite, -1, 1100, 375, -4, 4, 0, c_white, whitealpha);

draw_sprite_ext(spr_sword, -1, 1140, 375, 4, 4, 0, c_white, 1);

//Sets the font to the deltarune font.

//Draws your TP and subtracts 20 from the X for some reason? I just trail and errored compared it to a screenshot and this is what made it always match deltarune no matter the value of TP (it still is a fucking pixel off sometimes, though).
draw_set_font(fnt_Deltamainbig);
//Removes 'tpup' which is a variable that is in place to create the 'tallying' effect.
draw_text(16 - string_width(tp)/20, 229, string(tp - tpup));

//Draws the member stats.
//Checks if it's the first party member's turn.
if turn == 0 {
	//Draws the head sprite.
	draw_sprite_ext(spr_headegg, 0, 240, 606 - yoffset[0], 2, 2, 0, c_white, 1);
	//Draws their HP.
	draw_set_font(fnt_Deltahealth);
	draw_text(488, 604 - yoffset[0], string(party[0].hp));
	draw_text(578, 604 - yoffset[0], string(party[0].maxhp));
	//Draws their health bar.
	draw_healthbar(472, 630 - yoffset[0], 623, 647 - yoffset[0], (party[0].hp/party[0].maxhp)*100, c_white, c_white, c_white, 0, false, false);
	//Draws the line things.
	//Moves the lines inward every frame.
	linex[0] += 2;
	linex[1] -= 10;
	linealpha[0] -= 0.03;
	
	if linex[0] == 74 linex[0] = 0;
	if linealpha[0] <= 0 linealpha[0] = 1;
	
	draw_set_alpha(linealpha[0]);
	draw_line_width(464 + linex[0], 745, 464 + linex[0], 812, 5)
	//Draws the buttons.
	if button[0] == 0 draw_sprite_ext(spr_encounterButton, 1, 256, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 0, 256, 666, 2, 2, 0, c_white, 1);
	if button[0] == 1 draw_sprite_ext(spr_encounterButton, 3, 326, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 2, 326, 666, 2, 2, 0, c_white, 1);
	if button[0] == 2 draw_sprite_ext(spr_encounterButton, 5, 396, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 4, 396, 666, 2, 2, 0, c_white, 1);
	if button[0] == 3 draw_sprite_ext(spr_encounterButton, 7, 466, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 6, 466, 666, 2, 2, 0, c_white, 1);
	if button[0] == 4 draw_sprite_ext(spr_encounterButton, 9, 536, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 8, 536, 666, 2, 2, 0, c_white, 1);
//Otherwise...
} else {
	//Draws the head sprite.
	draw_sprite_ext(spr_headegg, action[0], 242, 674 - yoffset[0], 2, 2, 0, c_white, 1);
	//Drwas their health.
	draw_set_font(fnt_Deltahealth);
	draw_text(488, 668 - yoffset[0], string(party[0].hp));
	draw_text(578, 668 - yoffset[0], string(party[0].maxhp));
	//Draws their heatlh bar.
	draw_healthbar(472, 694 - yoffset[0], 623, 711 - yoffset[0], (party[0].hp/party[0].maxhp)*100, c_white, c_white, c_white, 0, false, false)
}

draw_set_alpha(1);
if turn == 1 {
	//Draws the head sprite.
	draw_sprite_ext(spr_headegg, 0, 668, 606 - yoffset[1], 2, 2, 0, c_white, 1);
	//Draws their health.
	draw_text(916, 604 - yoffset[1], string(party[1].hp));
	draw_text(1006, 604 - yoffset[1], string(party[1].maxhp));
	//Draws their healthbar.
	draw_healthbar(900, 630 - yoffset[1], 1051, 647 - yoffset[1], (party[1].hp/party[1].maxhp)*100, c_white, c_white, c_white, 0, false, false);
	//Draws the button.
	//Checks if the button is selected and if so draw the second button frame (selected button), otherwise draw the first (unselected)
	if button[1] == 0 draw_sprite_ext(spr_encounterButton, 1, 684, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 0, 684, 666, 2, 2, 0, c_white, 1);
	if button[1] == 1 draw_sprite_ext(spr_encounterButton, 11, 754, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 10, 754, 666, 2, 2, 0, c_white, 1);
	if button[1] == 2 draw_sprite_ext(spr_encounterButton, 5, 824, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 4, 824, 666, 2, 2, 0, c_white, 1);
	if button[1] == 3 draw_sprite_ext(spr_encounterButton, 7, 894, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 6, 894, 666, 2, 2, 0, c_white, 1);
	if button[1] == 4 draw_sprite_ext(spr_encounterButton, 9, 966, 666, 2, 2, 0, c_white, 1) else draw_sprite_ext(spr_encounterButton, 8, 966, 666, 2, 2, 0, c_white, 1);
} else {
	draw_sprite_ext(spr_headegg, action[1], 668, 674 - yoffset[1], 2, 2, 0, c_white, 1);
	//Draws their health.
	draw_text(916, 668 - yoffset[1], string(party[1].hp));
	draw_text(1006, 668 - yoffset[1], string(party[1].maxhp));
	//Draws their health bar.
	draw_healthbar(900, 694 - yoffset[1], 1051, 711 - yoffset[1], (party[1].hp/party[1].maxhp)*100, c_white, c_white, c_white, 0, false, false);
}

//Sets the font to the encounter font.
draw_set_font(fnt_Deltamainbig);

//Sets the font to the custom font created in the create even from spr_deltaFont.
draw_set_font(font);
//Sets the draw color to white.
draw_set_color(c_white);
//Draws the flavor text at the bottom of the screen.
if select == 0 {
	//The * is drawn seperatly because for some reason the space between it and the rest of the text is different than the normal space size.
	draw_text(60, 756, "*");
	draw_text(120, 756, flavor[0]);
}

//Checks if it should show the enemy list.
if select == 1 || select == 2 && actselect == false || select == 4 {
	//Sets the font.
	draw_set_font(fnt_Deltamainbig);
	//Draws the enemy's name.
	draw_text(160, 753, string(enemy[0]._name));
	//Draws the soul selector.
	draw_sprite_ext(spr_soul, -1, 108, 768, 2, 2, 0, c_white, 1);
	//White overlay effect thing.
	//A sprite is drawn on top of the enemy sprite that is pure white to give it the white flashing effect, this increases/decrease the whiteness every frame.
	whitealpha += 0.05*whitealphadir;
	//If white alpha is one.
	if whitealpha == 1 {
		//Multiply the direction by -1 to make it start decreasing instead.
		whitealphadir*= -1;
		//Set the alpha to 0.9 so it doesn't keep multiplying and addding/subtracting over and over again.
		whitealpha = 0.9;
	} else if whitealpha == 0 {
		//Same thing as above but the reverse.
		whitealphadir*= -1;
		whitealpha = 0.1;
	}
} else {
	whitealpha = 0;
	whitealphadir = 1;
}

//Checks if it should show the act list.
if select == 2 && actselect == true {
	//Sets the font.
	draw_set_font(fnt_Deltamainbig);
	//Draws the selecting soul.
	if actx == 0 && acty == 0 draw_sprite_ext(spr_soul, -1, 18, 768, 2, 2, 0, c_white, 1);
	if actx == 1 && acty == 0 draw_sprite_ext(spr_soul, -1, 478, 768, 2, 2, 0, c_white, 1);
	if actx == 0 && acty == 1 draw_sprite_ext(spr_soul, -1, 18, 828, 2, 2, 0, c_white, 1);
	//Draws the acts's name.
	draw_text(60, 753, string(enemy[0].act0));
	draw_text(520, 753, string(enemy[0].act1));
	draw_text(60, 813, string(enemy[0].act2));
}