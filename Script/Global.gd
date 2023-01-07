extends Node

var ACTIVE_LIGHTS := [];
var ACTIVE_INTERACTABLES := [];

var MUSIC := true;
var SOUND := true;

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
	
func isInLight(player : Player) -> bool:
	for li in ACTIVE_LIGHTS:
		if(li.enabled):
			return true;
	return false;
	
func restartLevel():
	levelStartOrgans *= 0.85;
	organs = levelStartOrgans; 
	
	get_tree().reload_current_scene()
	pass;
