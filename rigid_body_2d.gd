extends RigidBody2D

var type = "square"
var speed
var id
var food = 0
var dying = false

func _ready() -> void:
	contact_monitor = 1
	max_contacts_reported = 100
	connect("body_entered", _on_body_entered)
	$"../Timer".connect("timeout",_on_main_timer_timeout)
	$Timer.connect("timeout",_on_timer_timeout)
	
	if id == null:
		id = 0
		food = 10
	
	if speed == null:
		speed = 0
		
	speed += randi_range(-500, 500)
	constant_force.x = speed
	self.modulate.a = 0
	get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 1, 1)
	$Label.text = "ID: " + str(id) + "\nSpeed: " + str(speed)

func _on_body_entered(body) -> void:
	if body.type == "food":
		food += 1

func _on_main_timer_timeout():
	if food >= 1:
		food -= 1
		var child = self.duplicate()
		child.position.y = 0
		child.position.x = randi_range(-960,960)
		child.speed = speed
		$"..".highest_id += 1
		child.id = $"..".highest_id
		$"../".add_child(child)
	elif dying == false:
		get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 0, 1)
		dying = true
		$Timer.start()
		
func _on_timer_timeout():
	queue_free()

#func _process(delta: float) -> void:
	#pass
	
