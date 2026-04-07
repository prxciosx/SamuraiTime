if (instance_exists(obj_boss)){
	if (global.kc_ativo){
		image_alpha -= fade;
		if (image_alpha <= 0) {
			instance_destroy();
		}
	}
} else{
	instance_destroy();
}