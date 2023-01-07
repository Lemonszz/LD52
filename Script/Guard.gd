extends CharacterBody2D


@onready var light = $FlashLight;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var par : PathFollow2D = get_parent();
	
	rotation_degrees = -par.rotation_degrees;
	light.rotation_degrees = par.rotation_degrees;
	
	pass
