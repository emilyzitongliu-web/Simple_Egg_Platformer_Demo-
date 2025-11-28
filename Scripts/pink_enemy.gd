extends RigidBody2D
@onready var Pink_Enemy = $AnimatedEnemy
@onready var game_manager = %GameManager
@onready var enemy_body = $"."
@onready var collision_shape = $CollisionShape2D

var finish = false

func _ready():
	Pink_Enemy.animation = "Idle"

func _process(delta):
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y 
		var x_delta = body.position.x - position.x
		print(y_delta)
		if (y_delta > 25):
			print("destroy")
			Pink_Enemy.animation = "blood"
			enemy_body.gravity_scale = 0
			collision_shape.set_deferred("disabled", true)
			
		else:
			print("dec player health")
			game_manager.decrease_lives()
			if (x_delta > 0):
				body.jump_side(300)
			else:
				body.jump_side(-300)

func _on_animated_enemy_animation_finished():
	if Pink_Enemy.animation == "blood":
		finish = true
		print("blood animation finished")
		queue_free()
	
