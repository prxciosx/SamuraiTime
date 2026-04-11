#region INPUT
var move = keyboard_check(ord("D")) - keyboard_check(ord("A"));
#endregion
#region ATAQUE NORMAL
if (attack_cooldown > 0) attack_cooldown--;

if (!tp && mouse_check_button_pressed(mb_left) && attack_cooldown <= 0) {
	move = 0;
	ataque = true;
	state = "A";

	var atk = instance_create_depth(x * 16, y - 50, depth - 1, obj_atk);
	atk.image_xscale = image_xscale;

	attack_cooldown = attack_delay;
}
#endregion
#region TIME STOP

if (keyboard_check(ord("C")) && global.tsu > 0) {

	tp = true;
	global.ts = true;

	if (som_ts == -1) {
		som_ts = audio_play_sound(sou_VFXTS, 3, true);
	}

} else {

	tp = false;
	global.ts = false;

	if (som_ts != -1) {
		audio_stop_sound(som_ts);
		som_ts = -1;
	}
}

#endregion
#region DIREÇÃO
if (move != 0 && !ataque) {
	image_xscale = move;
	dash_dir = move;
}
#endregion
#region TIME SCALE
var ts = 1;
if (global.time_scale != undefined) ts = global.time_scale;
#endregion
#region MOVIMENTO
if (!tp && !ataque) {
	hspd = move * spd;
	vspd += grv;
} else {
	hspd = 0;
	vspd = 0;
}
#endregion
#region VELOCIDADE FINAL
var h_final = hspd * ts;
#endregion
#region COLISÃO HORIZONTAL
if (place_meeting(x + h_final, y, obj_block)) {
	while (!place_meeting(x + sign(h_final), y, obj_block)) {
		x += sign(h_final);
	}
	h_final = 0;
}
x += h_final;
#endregion
#region PULO
if (!tp && keyboard_check_pressed(vk_space) && jump > 0 && !ataque) {
	vspd = jspd;
	jump--;
}
#endregion
#region COLISÃO VERTICAL
if (vspd > 0 && place_meeting(x, y + vspd, obj_block)) {
	while (!place_meeting(x, y + 1, obj_block)) {
		y += 1;
	}
	vspd = 0;
	jump = 2;
	dash_available = 1;
}

if (vspd < 0 && place_meeting(x, y + vspd, obj_block)) {
	while (!place_meeting(x, y - 1, obj_block)) {
		y -= 1;
	}
	vspd = 0;
}
y += vspd;
#endregion
#region DASH
if (!tp && keyboard_check_pressed(ord("Q")) && dash_available > 0 && !ataque) {
	if (!place_meeting(x + dash_power * dash_dir, y, obj_block)) {
		x += dash_power * dash_dir;
		dash_available--;
	}
}
#endregion
#region SLASH
if (tp && mouse_check_button_pressed(mb_left)) {	

	var x1 = x;
	var y1 = y - 64;

	var dir  = point_direction(x1, y1, mouse_x, mouse_y);
	var dist = point_distance(x1, y1, mouse_x, mouse_y);

	var final_x = x1;
	var final_y = y1;

	var boss_hit = noone;

	for (var i = 0; i < dist; i += 4) {

		var px = x1 + lengthdir_x(i, dir);
		var py = y1 + lengthdir_y(i, dir);

		if (place_meeting(px, py, obj_block)) break;

		final_x = px;
		final_y = py;

		var ghost = instance_place(px, py, obj_ghost);
		if (ghost != noone) ghost.vida = 0;

		if (boss_hit == noone) {
			var boss = instance_place(px, py, obj_boss);
			if (boss != noone) {
				boss.vida -= global.dano;
				boss_hit = boss;
			}
		}
	}

	if (!place_meeting(final_x, final_y, obj_block)) {
		x = final_x;
		y = final_y;
	}

	tp = false;
	global.ts = false;
	global.tsu -= 1;
}
#endregion
#region DANO 
if ((place_meeting(x,y,obj_atkinm) || place_meeting(x,y,obj_ghost) || place_meeting(x,y,obj_atkboss)) && !stun && !tp) {
	vida -= 1;
	stun = true;
	alarm[0] = 30;
	image_blend = c_red; 
	} 
	if (vida <= 0){
		room_goto(MenuI);
		global.key = false;
		instance_destroy(); 
	} 
#endregion
#region EFEITO KC
if (global.kc_ativo && irandom(2) == 0) {
	var ghost = instance_create_layer(x, y, "Instances", obj_playerghost);
	ghost.image_xscale = image_xscale;
	ghost.sprite_index = sprite_index;
	ghost.image_index = image_index; 
	}
#endregion
#region STATE

var no_chao = place_meeting(x, y+1, obj_block);

// PRIORIDADE MÁXIMA
if (global.ts) {
	image_xscale = 1;
	state = "TS";
}
else if (ataque){
	state = "A";
}
else if (!no_chao){
	state = "J";
}
else {
	switch (move){
		case -1: state = "WL"; break;
		case 0: state = "Idle"; break;
		case 1: state = "WR"; break;
	}
}

#endregion
#region ANIMAÇÃO

switch (state){

	case "TS":
		sprite_index = spr_playerTS;
		image_speed = 0;
		image_index = 0;
	break;

	case "Idle":
		image_index = 0;
		image_speed = 0;
	break;

	case "WL":
		sprite_index = spr_playerWL;
		image_speed = 1;
	break;

	case "WR":
		sprite_index = spr_playerWR;
		image_speed = 1;
	break;

	case "A":
		if (image_xscale > 0){
			sprite_index = spr_playerAR;
		} else {
			sprite_index = spr_playerAL;
		}
		image_speed = 1;
	break;

	case "J":
		image_speed = 0;

		if (vspd < 0){
			image_index = 1;
		} else {
			image_index = 0;
		}
	break;
}

#endregion
if (keyboard_check(ord("P"))){
	vida = 10000000000;
	vida_max=10000000000;
	global.tsu = 1000000000000;
}