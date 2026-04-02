// define destino baseado de onde veio
switch (room) {
    case Room2: sala = Room5; break;
	case Room5: sala = Room2; break;
    case Room3: sala = Room10; break;
	case Room10: sala = Room3; break;
    case Room7: sala = Room11; break;
	case Room11: sala = Room7; break;
}

// interação
if (place_meeting(x,y,obj_player) && keyboard_check_pressed(ord("X"))) {
    entrada = room;
    room_goto(sala);
}