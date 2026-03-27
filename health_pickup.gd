extends Area2D

class_name Pickup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")




func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health += 1
		print("heal by 1")
		queue_free()
