extends Control

var menu_page = "open"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("menu"):
		match menu_page:
			"open":
				hide_menu()
			"closed":
				show_menu()
	pass
	
func show_menu():
	get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 1, 1)
	var menu_page = "open"

func hide_menu():
	get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 0, 1)
	var menu_page = "closed"
