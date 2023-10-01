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
//What act you use.
act = array_create(2, 0);
//What item you used.
itemuse = array_create(2, 0);
//What party member you used an item on.
itemmember = array_create(2, 0);
//Which party member you are selecting for.
turn = 0;
//If you are selecting which act to use.
actselect = false;
//If you are selecting which party member to use an item on.
itemselect = false;
//What act column you are selecting.
actx = 0;
//What act row you are selecting.
acty = 0;
//What item column you are selecting,
itemx = 0;
//What item row you are selecting.
itemy = 0;
//Used to make the "party box" smoothly go down, offsets the Y position by an amount that decreases every frame.
yoffset = array_create(2, 0);
partyoffset = array_create(2, 0);
//Sets the opacity of the white effect while selecting an enemy.
whitealpha = 0;
//Whither to add or remove opacity from the white effect (1 for adding -1 for removing).
whitealphadir = 1;
//Creates the flavor text font.
font = font_add_sprite(spr_deltaFont, ord(" "), false, -2);
//Sets the depth (used to layer the enemy correctly with the spinning sword.)
depth = 0;

var _layer = layer_get_id("GUI");
_party0 = layer_sprite_get_id(_layer, "party0");
_party1 = layer_sprite_get_id(_layer, "party1");

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

item[1] = {
	_name: "Strawberry",
	desc : "Heals 20HP",
	hp : 20,
	tp : 0,
	atk: 0,
	def : 0,
}
item[2] = {
	_name: "Spaghetti",
	desc : "Heals 100HP",
	hp : 100,
	tp : 0,
	atk : 0,
	def : 0,
}
item[3] = {
	_name : "Milk",
	desc : "Raises TP 20%",
	hp : 0,
	tp : 20,
	atk : 0,
	def : 0,
}

item[4] = {
	_name : "Cake",
	desc : "Raises defense 20%",
	hp : 0,
	tp : 0,
	atk : 0,
	def : 20,
}

inv = array_create(4, 0);

inv[0] = 2;
inv[1] = 1;
inv[2] = 1;
inv[3] = 1;
inv[4] = 3;
inv[5] = 4;