extends Line2D

func _ready() -> void:
	if(Global.hideTips):
		queue_free();

func _process(delta: float) -> void:
	if(Global.hideTips):
		modulate.a -= 0.025;
		if(modulate.a <= 0):
			queue_free();
	pass
