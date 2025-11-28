extends Node


@onready var points_label: Label = %Points_LABEL
@export var hearts : Array[Node]
var points = 0 
var lives = 3

func add_points():   #creates func to total points
	points += 1       #update point
	print(points)
	points_label.text = str(points) #prints points to player screen, has to be str not int

func decrease_lives():
	lives = lives - 1
	print(lives)
	for x in 3:
		if(x<lives):
			hearts[x].show()
		else:
			hearts[x].hide()
	if lives == 0:
		get_tree().reload_current_scene()
	
