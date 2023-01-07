extends PointLight2D

@export_node_path(Area2D) var areaPath = NodePath("Area2D");
@export_node_path var collisionShape;
@export var adjustCircle := true;
@export var inverted := false;

var area;
var inArea;
var player : Player;


func _ready() -> void:
	area = get_node(areaPath);
	collisionShape = get_node(collisionShape);
	
	if(adjustCircle):
		collisionShape = collisionShape.duplicate();
		collisionShape.shape.radius = (texture.get_width() * texture_scale) / 2;


func _process(delta: float) -> void:

	if(inArea):
		var canInteract = player.canSeeLight(area);
		if(canInteract):
			if(!Global.ACTIVE_LIGHTS.has(self)):
				Global.ACTIVE_LIGHTS.append(self);
		else:
			eraseSelf();

func eraseSelf():
	if(Global.ACTIVE_LIGHTS.has(self)):
		Global.ACTIVE_LIGHTS.erase(self);

func playerEntered(body):
	if(body is Player):
		inArea = true;
		player = body;
	
func playedExited(body):
	if(body is Player):
		inArea = false;
		player = null;
		eraseSelf();

func set_active(active : bool, doEffects = true):
	enabled = !active if inverted else active;
