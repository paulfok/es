extends RigidBody2D

var type = "food"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if name == "Food":
		$CollisionShape2D.disabled = false
		gravity_scale = 1
		
	$Timer.connect("timeout",_on_timer_timeout)
	contact_monitor = 1
	max_contacts_reported = 100
	connect("body_entered", _on_body_entered)
	
	name = "Food" + str($"../".highest_food_id)
	$"../".highest_food_id += 1
	
	self.modulate.a = 0
	get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 1, 1)

func _on_body_entered(body) -> void:
	if body.type == "square":
		get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 0, 1)
		$Timer.start()
		$CollisionShape2D.queue_free()
		type = "fading_food"

func _on_timer_timeout():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
