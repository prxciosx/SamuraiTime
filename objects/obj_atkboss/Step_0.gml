// só define posição UMA VEZ (no primeiro frame)
if (life == 10) {

    var dir = 1;

    if (instance_exists(owner)) {
        dir = sign(owner.image_xscale); // USA A DIREÇÃO REAL
    }

    x = owner.x
    y = owner.y

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