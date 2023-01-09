extends CharacterBody2D
class_name Player

enum State{
	IDLE,
	WALK,
	DIG,
	DEAD
}

enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

const state_names := ["idle", "walk", "dig", "dead"];
const dir_names := ["up", "down", "left", "right"];

var state := State.IDLE;
var direction := Direction.DOWN;
var lightTime := 0.0;

@onready var interactCast  := $InteractCast;
@onready var lightCast  := $LightCast;
@onready var sprite := $AnimatedSprite2D;

func _ready() -> void:
	Global.PLAYER = self;
	
	if(!Global.hideTips):
		$Start.play();

func get_movement_input():
	var inputDir := Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = inputDir * Global.speed;
	updateDirection();
	
func updateDirection():
	if(velocity.x < 0):
		direction = Direction.LEFT;
	elif(velocity.x > 0):
		direction = Direction.RIGHT;
	elif(velocity.y > 0):
		direction = Direction.DOWN;
	elif(velocity.y < 0):
		direction = Direction.UP;

func _physics_process(delta: float) -> void:	
	match state:
		State.IDLE:
			handleIdle();
		State.WALK:
			handleWalk();
		State.DIG:
			handleDig();

func updateUI():
	Global.UI.lightProgress.max_value = Global.maxLightTime;
	Global.UI.lightProgress.value = lightTime;
	Global.UI.organCount.text = str(Global.organs);

func _process(delta: float):

	updateAnimation()
	updateLightDetection(delta);
	updateUI();

func handleIdle():
	listenForMovement();
	
	if(velocity.length() != 0):
		state = State.WALK;
	listenForInteraction();
	
func handleWalk():
	listenForMovement();
	
	if(velocity.length() == 0):
		state = State.IDLE;
	listenForInteraction();
	
func handleDig():
	listenForInteraction();

func listenForMovement():
	get_movement_input();
	move_and_slide();
	
func updateLightDetection(delta : float):
	if(state == State.DEAD):
		return;
	
	var li = Global.isInLight(self);
	if(li):
		var dist = position.distance_to(li.global_position);
		var change = (128 / dist) / 1.5;
		
		lightTime += change * delta;
	else:
		lightTime -= 2.0 * delta;
		
	lightTime = max(0, lightTime);
	if(lightTime >= Global.maxLightTime):
		gameOver();
		
func gameOver():
	state = State.DEAD
	$Caught.play();
	Global.UI.showGameOver();

func listenForInteraction():
	if(Input.is_action_just_released("interact")):
		var interactable = Global.getClosestInteractable(self);
		if(interactable != null):
			interactable.doInteraction();

func canInteractWith(interactable : Node2D) -> bool:
	if(!interactable.canInteract()):
		return false;
	
	interactCast.target_position = to_local(interactable.global_position);
	interactCast.force_raycast_update();
	return interactCast.get_collider() == interactable;
	
func canSeeLight(light : Node2D) -> bool:
	lightCast.target_position = to_local(light.global_position);
	lightCast.force_raycast_update();
	return lightCast.get_collider() == null;
	
func updateAnimation():
	if(state == State.DEAD):
		sprite.visible = false;
		return;
	
	var anim = state_names[state] + "_" + dir_names[direction];
	if(sprite.animation != anim):
		sprite.animation = anim;
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if(sprite.animation.begins_with("dig")):
		$DigSounds.play();
	pass # Replace with function body.
	
func playPickup():
	$Pickup.play();

func playLeave():
	if(Global.organs <= Global.levelStartOrgans):
		$LeaveEmpty.play();
	else:
		$LeaveFull.play();
		
func playDugSound():
	$DigGrave.play();
