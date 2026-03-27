extends Node
var playerHealth: int
var playerBurrowTimeLeft: float
var playerBurrowTime: float
var score: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_score() -> void:
	score += 1
