extends StaticBody2D

@export_node_path(Area2D) var interactAreaPath;
var interactArea : Area2D;
var inArea := false;
var player : Player;

@onready var sprite = $Sprite2D;

func _ready() -> void:
	interactArea = get_node(interactAreaPath);
	interactArea.connect("body_entered", onEnterInteractArea);
	interactArea.connect("body_exited", onExitInteractArea);

func _process(delta: float) -> void:
	if(inArea):
		var canInteract = player.canInteractWith(self);
		sprite.material.set_shader_parameter("enabled", canInteract);
		if(canInteract):
			if(!Global.ACTIVE_INTERACTABLES.has(self)):
				Global.ACTIVE_INTERACTABLES.append(self);
		else:
			eraseSelf();
	

func eraseSelf():
	if(Global.ACTIVE_INTERACTABLES.has(self)):
		Global.ACTIVE_INTERACTABLES.erase(self);

func doInteraction(doEffects = true):
	get_tree().change_scene_to_packed(load("res://Scene/shop.tscn"))
	pass;

func canInteract():
	return true;

func onEnterInteractArea(body : Node):
	if(body is Player):
		inArea = true;
		player = body;
	
func onExitInteractArea(body : Node):
	if(body is Player):
		sprite.material.set_shader_parameter("enabled", false);
		inArea = false;
		player = body;
		eraseSelf();
