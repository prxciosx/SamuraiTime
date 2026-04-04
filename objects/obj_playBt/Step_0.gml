image_speed = 0;
if (position_meeting(mouse_x, mouse_y, id)) {
    image_index = 1;
	if (mouse_check_button(1)){
		room_goto_next();
	}
} else{
	image_index = 0;
}