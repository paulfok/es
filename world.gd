extends Node2D

var highest_id = 0
var highest_food_id = 0
var food_per_round = 5

func _ready() -> void:
	$Timer.connect("timeout",_on_timer_timeout)

func _on_timer_timeout():
	for i in food_per_round:
		spawn_food()
		print(i)
func spawn_food():
	var food = $Food0.duplicate()
	food.position.y = -500
	food.position.x = randi_range(-960,960)
	add_child(food)

#func _process(delta: float) -> void:
	#pass
