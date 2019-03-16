extends Area2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_food_body_entered(body):
	#queue_free
	
#	body.add_food()
#	print(body.get_method)
	if body.get_class() == 'RigidBody2D':
		body.add_food()
		print("curr food eaten: " + str(body.get_food()))
		queue_free()
#	for child in body.get_children():
#		print(child.get_name())
	pass # replace with function body
