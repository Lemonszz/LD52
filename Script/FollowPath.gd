extends PathFollow2D

@export var speed = 100;

func _process(delta: float) -> void:
	progress = progress + speed * delta;
	
	pass
