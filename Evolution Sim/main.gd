extends Node2D
onready var organism = preload("res://organism.tscn")
onready var food = preload("res://food.tscn")
onready var organism_container = get_node("organsism_container")
onready var food_container = get_node("food_container")
onready var generation_label = get_node("HUD/generation_label")

var generation = 0
# Mutation rate as a percent
const MUTATION_RATE = 10

var time_start = 0
var time_now = 0

const MIN_SIZE = 0.5
const MAX_SIZE = 3

var new_gen_organisms = null
var screensize
func _ready():
	time_start = OS.get_unix_time()
	screensize = get_viewport_rect().size
	print(screensize)
	#add_child(food_container)
	#add_child(organism_container)
	
	initial_population(5)
	spawn_food(30)
	pass

#spawn random organisms for inital population
#num parameter specifies how many random organisms to spawn
func initial_population(num):
	randomize()
	for i in range(num):
		spawn_organism(rand_range(MIN_SIZE,MAX_SIZE))
	pass

func spawn_organism(size):
	var o = organism.instance()
	o.init(size)
	organism_container.add_child(o)
	o.set_position(Vector2(rand_range(0,screensize.x - 10), 
		                   rand_range(0, screensize.y - 10)))

func spawn_food(num):	
 randomize()
	for i in range(num):
		var f = food.instance()
		food_container.add_child(f)
		f.set_position(Vector2(rand_range(0,screensize.x - 10),rand_range(0, screensize.y - 10)))
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func reproduction():
	update_generation()
	new_gen_organisms = []
	var num_curr_organisms = organism_container.get_child_count()
	
	for i in range (num_curr_organisms):
		new_gen_organisms.append(select_organism())
	for o in organism_container.get_children():
		print("old gen gene: " + str(o.get_gene()))
	kill_curr_organisms()
	for i in new_gen_organisms:
		print("new gen gene: " + str(i))
	spawn_new_generation()
	
func kill_curr_organisms():
	for organism in organism_container.get_children():
		organism.queue_free()

func spawn_new_generation():
	var o
	for i in new_gen_organisms:
		#if entry is null we create a random organism
		if i == null || mutation():
			o = spawn_organism(rand_range(MIN_SIZE,MAX_SIZE)) 
		else:
			o = spawn_organism(i)
		organism_container.add_child(o)
	
# Selects organisms for reproduction using roulette wheel selection
func select_organism():
	var sum_fitness =  total_fitness()
	var rand = rand_range(0,sum_fitness)
	var partial_sum = 0
	for organism in organism_container.get_children():
		partial_sum += organism.calculate_fitness()
		if(partial_sum >= rand):
			return organism.get_gene()
	return null

func total_fitness():
	var sum = 0
	for organism in organism_container.get_children():
		sum += organism.calculate_fitness()
	return sum
		
# Updates variable and HUD lable by 1
func update_generation():
	generation += 1
	generation_label.set_text("Generation : " + str(generation))

# Randomly mutates organism 
func mutation():
	randomize()
	var rand = rand_range(0,100)
	if(rand < MUTATION_RATE):
		return true
	else:
		return false


func _process(delta):
		if food_container.get_child_count() == 0:
#			new 
			reproduction()
			spawn_food(30)