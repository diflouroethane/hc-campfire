extends CanvasLayer
class_name UI



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/HBoxContainer/VBoxContainer/HealthLabel.text = "health: " + str(Global.playerHealth)
	$Control/HBoxContainer/VBoxContainer2/Scorelabel.text = "score: " + str(Global.score)
	$Control/HBoxContainer/VBoxContainer/ProgressBar.max_value = Global.playerBurrowTime
	$Control/HBoxContainer/VBoxContainer/ProgressBar.value = Global.playerBurrowTimeLeft
