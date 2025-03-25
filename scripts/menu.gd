extends Control

var menu_page

func _ready() -> void:
	hide_settings()
	show_menu()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		match menu_page:
			"open":
				hide_menu()
			"closed":
				show_menu()
			"settings":
				hide_settings()

func show_menu():
	$"../World".get_tree().paused = true
	show()
	menu_page = "open"

func hide_menu():
	$"../World".get_tree().paused = false
	hide()
	menu_page = "closed"
	
func show_settings():
	$Settings.show()
	menu_page = "settings"

func hide_settings():
	$Settings.hide()
	menu_page = "open"
