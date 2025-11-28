extends CharacterBody2D


const SPEED = 100
const JUMP_VELOCITY = -200.0
const JUMP_FORCE = -250
const max_jumps = 2
var jump_count = 0             #sets velocity when player jumps. -y is up, +y down
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#==================================
@onready var sprite_2d = $Sprite2D

func jump_side(x):
	velocity.x = x 
	velocity.y = -100
func _physics_process(delta):
	if (velocity.x > 1 || velocity.x < -1): #checks if the player is moving either left or right (isnt idle)
		sprite_2d.animation = "Running" #runs the running animation
	else:
		sprite_2d.animation = "Idle" #if no x movement, set animation to idle
	
	# add gravity
	if not is_on_floor(): #isonfloor returns true if sprite in contact with floor, not inverts it to false (like logic gate)
		velocity.y += gravity * delta #updates the y(vertical) movement.  * gravity by delta simulates acceleration down. 
		if velocity.y < 0:                      #checks if player is jumping/falling (+y is down, -y is up)
			sprite_2d.animation = "Jumping" 
		else:
			sprite_2d.animation = "Falling"
	
	if is_on_floor():
		jump_count = 0 
	
	
	# handle jump
	if Input.is_action_just_pressed("Jump") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	#get the input direction and handle the movement/deceleration
	#should replace UI actions with custom gameplay actions
	var direction = Input.get_axis("Left","Right") #"directions" stores the value "Inputgetaxis" returns (from user input), L = -1, R +1. 
	if direction: #checks the direction isnt 0, that the player is moving
		velocity.x = direction * SPEED #updates velocity to the direction L/R, (if L, speed*-1 so velocity moving to left)
	else:
		velocity.x = move_toward(velocity.x,0,24)  #when no L/R key pressed, simulates player deceleration by gradually coming to stop
	
	move_and_slide()
	
	var isLeft = velocity.x <0
	sprite_2d.flip_h = isLeft
