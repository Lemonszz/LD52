extends Control

@onready var digButton : Button = $PanelContainer/MarginContainer/VBoxContainer/HFlowContainer/PanelContainer/VBoxContainer/HBoxContainer/DigButton;
@onready var moveButton : Button = $PanelContainer/MarginContainer/VBoxContainer/HFlowContainer/PanelContainer2/VBoxContainer/HBoxContainer/SpeedButton;
@onready var detectButton : Button = $PanelContainer/MarginContainer/VBoxContainer/HFlowContainer/PanelContainer3/VBoxContainer/HBoxContainer/DetectionButton;
@onready var luckButton : Button = $PanelContainer/MarginContainer/VBoxContainer/HFlowContainer/PanelContainer4/VBoxContainer/HBoxContainer/LuckButton;
@onready var friendButton : Button = $PanelContainer/MarginContainer/VBoxContainer/HFlowContainer/PanelContainer5/VBoxContainer/HBoxContainer/FriendButton;

@onready var organsText : RichTextLabel = $OrgansText;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateCosts();

func _process(delta: float) -> void:
	pass

func _on_dig_button_pressed() -> void:
	if(Global.organs >= getDigCost()):
		Global.digUpgradeCount += 1;
		Global.digSpeed += 0.005;
		Global.organs -= getDigCost();
		
		updateCosts();
	
func _on_speed_button_pressed() -> void:
	if(Global.organs >= getMoveCost()):
		Global.speedUpgradeCount += 1;
		Global.speed += 25;
		Global.organs -= getMoveCost();
		updateCosts();

func _on_detection_button_pressed() -> void:
	if(Global.organs >= getDetectCost()):
		Global.detectUpgradeCount += 1;
		Global.maxLightTime += 0.25;
		Global.organs -= getDetectCost();
		updateCosts();
		
func _on_luck_button_pressed() -> void:
	if(Global.organs >= getLuckCost()):
		Global.luckUpgradeCount += 1;
		Global.luck += 1;
		Global.organs -= getLuckCost();
		updateCosts();

func updateCosts():
	digButton.text = str(getDigCost());
	moveButton.text = str(getMoveCost());
	detectButton.text = str(getDetectCost());
	luckButton.text = str(getLuckCost());
	
	organsText.text = "Parts:       " + str(Global.organs);


func getDigCost():
	return 2 + (Global.digUpgradeCount * 2);

func getMoveCost():
	return 2 + (Global.speedUpgradeCount * 2);

func getDetectCost():
	return 2 + (Global.detectUpgradeCount * 2);
	
func getLuckCost():
	return 5 + (Global.luckUpgradeCount * 3);
