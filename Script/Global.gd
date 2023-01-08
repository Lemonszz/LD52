extends Node

var levels := [
	preload("res://Scene/Level1.tscn"),
	preload("res://Scene/Level2.tscn"),
	preload("res://Scene/Level3.tscn"),
	preload("res://Scene/Level4.tscn"),
];

var usedLevels := [
	
]

var ACTIVE_LIGHTS := [];
var ACTIVE_INTERACTABLES := [];

var MUSIC := 0.5;
var SOUND := 1.0;

var hideTips = false;

var UI : UI;
var OBJECTS : Node2D;
var PLAYER : Player;

var speed := 100.0;
var speedUpgradeCount = 0;

var digSpeed := 0.0025;
var digUpgradeCount = 0;

var maxLightTime = 1.5;
var detectUpgradeCount = 0;

var luck := 1.0;
var luckUpgradeCount = 0;

var organs := 0;
var levelStartOrgans := organs;

func getClosestInteractable(player : Player) -> StaticBody2D:
	var closest = null;
	var closestDist = 999999;
	
	for n in ACTIVE_INTERACTABLES:
		var dis = player.position.distance_to(n.position);
		if(dis < closestDist):
			closestDist = dis;
			closest = n;
			
	return closest;
	
func isInLight(player : Player):
	for li in ACTIVE_LIGHTS:
		if(li.enabled):
			return li;
	return false;
	
func nextLevel():
	if(levels.is_empty()):
		levels = usedLevels;
		usedLevels = [];
		
	var next = levels.pop_front();
	usedLevels.append(next);
	get_tree().change_scene_to_packed(next);
		

func restartLevel():
	levelStartOrgans *= 0.85;
	organs = levelStartOrgans; 
	
	get_tree().reload_current_scene()
	pass;

