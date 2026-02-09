extends CharacterBody2D

class_name Player

var speed: float = 500
var lock_time: float = 0
#contains the points the player must go through
var route_instructions: Array[Vector2]
var pending_route_instructions: Array[Vector2]

var resources := PlayerResources.new()

func is_locked() -> bool:
	return bool(lock_time)

func lock(t: float) -> void:
	lock_time = t

func add_instruction(data: Array[Vector2]) -> void:
	pending_route_instructions = data
	
func _process(delta: float) -> void:
	lock_time = max(0, lock_time - delta)
	
	if len(pending_route_instructions) && !is_locked():
		var instruction := pending_route_instructions[0]
		route_instructions.append(instruction)
		pending_route_instructions.remove_at(0)
		
	if len(route_instructions):
		global_position = global_position.move_toward(route_instructions[0], speed * delta)
	
		if route_instructions[0].distance_to(global_position) == 0:
			route_instructions.remove_at(0)
