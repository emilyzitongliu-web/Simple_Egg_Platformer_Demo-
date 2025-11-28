extends Area2D

@export var target_portal : Node2D

var recently_used = false

func set_recently_used(truth):
	recently_used = truth
	return

func _on_body_entered(body: Node2D) -> void:
	if target_portal == null:
		return 
	
	if recently_used == true:
		recently_used = false
		return 
	
	#check if body player or not
	if (body.name == "CharacterBody2D") :
		body.position = target_portal.position
		target_portal.set_recently_used(true)
