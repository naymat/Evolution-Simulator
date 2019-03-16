extends RigidBody2D
var colshape
var energy = 0
var size = 0
func init(s):
	size = s
	_set_circle_properties(self,size)
	_scale_orgranism(self,size)
	pass

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	pass
	
func _set_circle_properties(rigid_circle,size):
	var mass = pow(size,5)
	var velocity = 626.668 - (322.6793 * size) + (39.93924 * (pow(size,2)))
#	print("velocity: " + str(velocity))
#	print("size: " + str(size) )
#	print("mass: " + str(mass))
#	rigid_circle.global_position = Vector2(rand_position())
	
	rigid_circle.set_linear_velocity(Vector2(velocity,velocity))
	rigid_circle.set_linear_damp(0) 
	rigid_circle.set_angular_damp(0)
	rigid_circle.set_friction(0)
	rigid_circle.set_bounce(0.999)
	rigid_circle.set_mass(mass)
	rigid_circle.set_gravity_scale(0)
	pass
	
func _scale_orgranism(body,new_scale):
	var scale = body.get_scale()
	
	var sprite = body.get_child(0)
	var collision_circle = body.get_child(1)
	
	var scale_sprite = sprite.get_scale()
	var scale_collision = collision_circle.get_scale()
	
	scale_sprite = multiplyVector2(scale_sprite, new_scale)
	scale_collision = multiplyVector2(scale_collision, new_scale* 1.0)
	
	sprite.set_scale(scale_sprite)
	collision_circle.set_scale(scale_collision)
	scale= scale * new_scale
	pass
func add_food():
	energy += 1
func get_food():
	pass
	return energy
	pass
func get_gene():
	return size
	pass
func calculate_fitness():
	return energy
	pass
	
func multiplyVector2(vector, number):
	vector.x = vector.x * number
	vector.y = vector.y * number
	return vector
	pass

