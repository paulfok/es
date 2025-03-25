extends Node2D

func _ready() -> void:
	$Timer.connect("timeout",_on_timer_timeout)

func _on_timer_timeout():
	reproduce()

#func _process(delta: float) -> void:
	#pass

func reproduce() -> void:
	var child = $RigidBody2D.duplicate()
	child.position = Vector2(0,0)
	self.add_child(child)
