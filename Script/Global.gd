extends Node

var ACTIVE_LIGHTS := [];
var ACTIVE_INTERACTABLES := [];

var MUSIC := true;
var SOUND := true;

var UI : UI;
var OBJECTS : Node2D;
var PLAYER : Player;

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
