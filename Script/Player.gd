extends CharacterBody2D
class_name Player

enum State{
	IDLE,
	WALK,
	DIG
}

enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

const state_names := ["idle", "walk", "dig"];
const dir_names := ["up", "down", "left", "right"];

@export var speed := 100.0;
@export var digSpeed := 0.025;
var state := State.IDLE;
var direction := Direction.DOWN;

@onready var interactCast  := $InteractCast;
@onready var lightCast  := $LightCast;

func get_movement_input():
	var inputDir := Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = inputDir * speed;
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
			
func handleIdle():
	listenForMovement();
	
	if(velocity.length() != 0):
		state = State.WALK;
	listenForInteraction();
	
func handleWalk():
	listenForMovement();
	
	if(velocity.length() == 0):
		state = State.WALK;
	listenForInteraction();
	
func handleDig():
	listenForInteraction();

func listenForMovement():
	get_movement_input();
	move_and_slide();

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
