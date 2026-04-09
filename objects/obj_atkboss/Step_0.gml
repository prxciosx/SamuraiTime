// só define posição UMA VEZ (no primeiro frame)
if (life == 10) {

    var dir = 1;

	if (instance_exists(owner) && variable_instance_exists(owner, "dir")) {
		dir = owner.dir;
	}

    x = (dir > 0) ? owner.bbox_right : owner.bbox_left;
    y = owner.y - 40;

    image_xscale = dir;
}

// countdown
life--;

// destrói
if (life <= 0) {

    if (instance_exists(owner)) {
        owner.ataque = false;
    }

    instance_destroy();
}