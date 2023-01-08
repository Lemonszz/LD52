extends CharacterBody2D


@onready var light = $FlashLight;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var par : PathFollow2D = get_parent();
	var rot = par.rotation_degrees;
	
	rotation_degrees = -par.rotation_degrees;
	light.rotation_degrees = par.rotation_degrees;
	
	if(rot > -45 && rot < 45):
		$AnimatedSprite2D.animation = "right";
	elif(rot > 45 && rot < 135):
		$AnimatedSprite2D.animation = "down";
	elif(rot > 135 && rot < 225):
		$AnimatedSprite2D.animation = "left";
	else:
		$AnimatedSprite2D.animation = "up";
