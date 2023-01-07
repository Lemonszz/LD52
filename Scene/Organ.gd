extends Sprite2D

@export var textures : Array[Texture2D] = [];
var velocity;
@export var speed := 5.0;
@export var friction = 0.80;

var travelling = false;
var tween : Tween;

func _ready() -> void:
	texture = textures[randi() % textures.size()];
	velocity = Vector2(randi_range(-speed, speed), randi_range(-speed, speed));
	
func _physics_process(delta: float) -> void:
	if(!travelling):	
		position += velocity;
		velocity *= friction;
		if(velocity.length() < 0.0025):
			travelling = true;
			tween = create_tween();
			tween.tween_property(self, "position", Global.PLAYER.position, 0.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK);
			tween.connect("finished", onTweenFinish)
			
func onTweenFinish():
	queue_free();
	Global.organs += 1;
	pass;	
	
