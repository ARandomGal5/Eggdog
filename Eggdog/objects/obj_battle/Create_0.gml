//Your tp which stands for... uh... uhhhh...
tp = 0;
//Used to create the 'tallying' effect on the TP number, the drawn number has this value subtracted from it, with said value being reduced by 1 every frame.
tpup = 0;
//The flavor text to draw in the text box.
flavor[0] = "Eggdog wants to battle!"
flavor[1] = "Smells like fried eggs."
flavor[2] = "Bark!"
flavor[3] = "Eggdog is dancing to the rhythm."
//Which button you are selecting.
button = array_create(2, 0);
//What button you have selected (0 for none).
select = 0;
//What action you use (each array index is for a party member)
action = array_create(2, 0);
//Which party member you are selecting for.
turn = 0;
//If you are selecting which act to use.
actselect = false;
//What act column you are selecting.
actx = 0;
//What act row you are selecting.
acty = 0;
//Used to make the "party box" smoothly go down, offsets the Y position by an amount that decreases every frame.
yoffset = array_create(2, 0);
//Sets the opacity of the white effect while selecting an enemy.
whitealpha = 0;
//Whither to add or remove opacity from the white effect (1 for adding -1 for removing).
whitealphadir = 1;
//Creates the flavor text font.
font = font_add_sprite(spr_deltaFont, ord(" "), false, -2);

linex = array_create(2, 0);
linealpha = array_create(2, 1);

enemy[0] = {
	_name : "Eggdog",
	hp : 200,
	atk : 10,
	defense : 3,
	act0 : "Check",
	act1 : "Pet",
	act2 : "Bark",
}

party[0] = {
	_name : "Eggdog",
	maxhp : 160,
	hp: 160,
	atk: 12,
	defense: 2,
	magic: 0,
}

party[1] = {
	_name: "Eggdog",
	maxhp: 140,
	hp: 140,
	atk: 16,
	defense: 2,
	magic: 2,
}

item[0] = {
	_name: "Strawberry"
}
item[1] = {
	_name: "Spaghetti"
}
item[2] = {
	_name : "Milk"	
}
item[3] = {
	_name : "Baguette"	
}
item[4] = {
	_name : "Cake"
}
