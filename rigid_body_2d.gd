extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate.a = 0
	get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).tween_property(self, "modulate:a", 1, 1)
	pass
