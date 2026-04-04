
// controla efeito King Crimson
if (global.kc_ativo) {
    global.kc_timer--;

    if (global.kc_timer <= 0) {
        global.kc_ativo = false;
    }
}

// diminui shake
if (global.shake > 0) {
    global.shake--;
}

// aplica shake na câmera
var cam = view_camera[0];

var sx = random_range(-global.shake, global.shake);
var sy = random_range(-global.shake, global.shake);

// posição base da câmera
var cx = camera_get_view_x(cam);
var cy = camera_get_view_y(cam);

// aplica offset
camera_set_view_pos(cam, cx + sx, cy + sy);

if (!instance_exists(obj_boss)){
	global.time_scale = 2;
}