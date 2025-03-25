extends RigidBody2D

var type = "square"
var speed
var id
var jumping_freq
var jump_height
var food = 1
var dying = false

func _ready() -> void:
	contact_monitor = 1
	max_contacts_reported = 100
	connect("body_entered", _on_body_entered)
	$"../Timer".connect("timeout",_on_main_timer_timeout)
	$Timer.connect("timeout",_on_timer_timeout)
	$JumpTimer.connect("timeout",_on_jump_timer_timeout)
	
	if id == null:
		id = 0
		food = 10
		speed = 0
		jumping_freq = 2500
		jump_height = -250

	jumping_freq += randi_range(-1000, 1000)
	$JumpTimer.wait_time = float(abs(jumping_freq)) / 1000
		
	jump_height += randi_range(-500, 500)
	jump_height = abs(jump_height) * -1

	speed += randi_range(-500, 500)
	constant_force.x = speed
	self.modulate.a = 0
	get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 1, 1)
	$Label.text = "ID: " + str(id) + "\nSpeed: " + str(speed) + "\nFood: " + str(food) + "\nJump Freq: " + str(float(jumping_freq)/1000) + "\nJump Height: " + str(jump_height)
	$JumpTimer.start()

func _on_jump_timer_timeout():
	apply_central_impulse(Vector2(0,jump_height))
	$JumpTimer.start()

func _on_body_entered(body) -> void:
	if body.type == "food":
		food += 1
		$Label.text = "ID: " + str(id) + "\nSpeed: " + str(speed) + "\nFood: " + str(food) + "\nJump Freq: " + str(float(jumping_freq)/1000) + "\nJump Height: " + str(jump_height)
	elif body.type == "wall" or body.type == "square" and abs(body.position.y - position.y) < 75:
		speed *= -1
		constant_force.x = speed
		$Label.text = "ID: " + str(id) + "\nSpeed: " + str(speed) + "\nFood: " + str(food) + "\nJump Freq: " + str(float(jumping_freq)/1000) + "\nJump Height: " + str(jump_height)
		

func _on_main_timer_timeout():
	if food >= 2:
		food -= 1
		var child = self.duplicate()
		child.position.y = 0
		child.position.x = randi_range(-960,960)
		child.speed = speed
		child.jump_height = jump_height
		child.jumping_freq = jumping_freq
		$"..".highest_id += 1
		child.id = $"..".highest_id
		add_sibling(child)
	elif food >= 1:
		food -= 1
	elif dying == false and food < 1:
		get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 0, 1)
		dying = true
		$CollisionShape2D.queue_free()
		$Timer.start()
		
func _on_timer_timeout():
	queue_free()
