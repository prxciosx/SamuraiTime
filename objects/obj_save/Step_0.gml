if (place_meeting(x,y,obj_player)){
	texto = true;
	if keyboard_check(ord("C")){
		image_speed = 1;
		global.save = Room8;
		txt = "Saved";
	}
} else{
	texto = false;
}
if (image_index >= image_number - 1){
	image_speed = 0;
	image_index = 0;
}