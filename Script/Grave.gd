extends StaticBody2D

@export var inProgressTexture : Texture;
@export var doneTexture : Texture;
var organScene = preload("res://Scene/organ.tscn");


@export_node_path(Area2D) var interactAreaPath;
var interactArea : Area2D;
var inArea := false;
var player : Player;

var digging = false;
var digProgress := 0.0;

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
	
	if(digging && player.state == Player.State.DEAD):
		interuptDigging();
	
	if(digging):
		$GPUParticles2D.emitting = true;
		digProgress += Global.digSpeed;
		if(digProgress >= 1.0):
			finishDigging();
	else:
		$GPUParticles2D.emitting = false;

func finishDigging():
	digging = false;
	player.state = Player.State.IDLE;
	digProgress = 1.0;
	sprite.texture = doneTexture;
	
	var min = 1.0;
	var max = 3 + Global.luck;
	
	for i in range(randf_range(min, max)):
		var organ = organScene.instantiate();
		organ.position = position;
		Global.OBJECTS.add_child(organ);

func interuptDigging():
	digging = false;

func eraseSelf():
	if(Global.ACTIVE_INTERACTABLES.has(self)):
		Global.ACTIVE_INTERACTABLES.erase(self);

func doInteraction(doEffects = true):
	Global.hideTips = true;
	if(digging):
		interuptDigging();
		player.state = Player.State.IDLE;
	else:
		digging = true;
		player.state = Player.State.DIG;
		sprite.texture = inProgressTexture;

func canInteract():
	return digProgress < 1.0;

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
