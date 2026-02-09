extends Resource

class_name PlayerResources

@export var satiety: Array[float] = [20, 20]
@export var energy: Array[float] = [20, 20]
@export var money: Array[float] = [0, -1]
@export var love: Array[float] = [0, -1]

var data = {
	"satiety": satiety,
	"energy": energy, 
	"money": money,
	"love": love,
}

func update_resource(res: String, offset: float) -> void:
	data[res][0] = max(0, data[res][0] + offset)
	if data[res][1] == -1:
		return
	
	data[res][0] = min(data[res][0], data[res][1])


		
