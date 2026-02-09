extends Node2D

class_name Structure

#in seconds
@export var work_time: float = 2
@export var recovery_time: float = 1
@export var detection_radius: float = 0

var clock: float = 0
var engaged: bool = false

var hovered: bool = false

@onready var player: Player = $"/root/Game/Player"

func harvest(p: Player) -> void:
	pass

func is_occupied() -> bool:
	return bool(clock)

func engage(p: Player) -> void:
	p.lock(work_time)
	clock = work_time + recovery_time
	engaged = true

func disengage(p: Player) -> void:
	if engaged:
		harvest(p)
		engaged = false
		
func _process(delta: float) -> void:
	clock = max(0, clock - delta)
	
	if !player:
		return
		
	if player.global_position.distance_to(global_position) <= detection_radius:
		if !is_occupied():
			engage(player)
		else:
			if clock <= recovery_time:
				disengage(player)
	
	var rate := (work_time + recovery_time - clock) / work_time
	if rate > 1:
		$ProgressBar.visible = false
	else:
		$ProgressBar.visible = true
		$ProgressBar.set_percentage(rate)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if hovered && (event.button_index == MouseButton.MOUSE_BUTTON_LEFT):
			player.add_instruction([global_position])
			
	pass # Replace with function body.

func _on_mouse_entered() -> void:
	hovered = true


func _on_mouse_exited() -> void:
	hovered = false
