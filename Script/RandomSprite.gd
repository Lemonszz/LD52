extends Sprite2D

@export var textures : Array[Texture] = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = textures[randi() % textures.size()];
