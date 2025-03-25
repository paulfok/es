extends HSlider

func _ready() -> void:
	$"../FoodPerRoundLabel".text = "\n Food per round: " + str(value)

func _gui_input(event: InputEvent) -> void:
	$"../../../World".food_per_round = value
	$"../FoodPerRoundLabel".text = "\n Food per round: " + str(value)
