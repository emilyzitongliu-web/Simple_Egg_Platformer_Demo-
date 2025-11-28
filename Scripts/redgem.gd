extends Area2D

@onready var game_manager: Node = %GameManager #access gamemmanger script


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"): #ensures gem only destroyed if collision is with character, not tilemap 
		queue_free() #destroy object 
		game_manager.add_points()  #calls function to update points
