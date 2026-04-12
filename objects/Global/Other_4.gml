global.inm = 0;
global.inimigo_atacando = noone;
global.inm_max = (instance_number(obj_ghost) + instance_number(obj_inm) + instance_number(obj_boss));

if (room == Room1){
	global.tutorial = true;
}