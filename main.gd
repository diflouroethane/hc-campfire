extends Node

@export var health_pickup: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthSpawnTimer.start()
	$GameOver.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#var enemy_spawners = $EnemySpawners.get_children()
	##for i in enemy_spawners:
		##print(i.time_to_wait)
		##i.time_to_wait -= 0.0005 if i.time_to_wait >= 0.0001 else 0

func _on_health_spawn_timer_timeout() -> void:
	var possible_locs: Array[Node] = $HealthSpawners.get_children()
	var loc: Marker2D = possible_locs.pick_random()
	var pickup: Pickup = health_pickup.instantiate()
	pickup.global_position = loc.global_position
	get_parent().add_child(pickup)
	print("spawned(?)")
	$HealthSpawnTimer.wait_time = randf_range(3, 10)
	$HealthSpawnTimer.start()


func _on_player_game_over() -> void:
	$GameOver/HBoxContainer/VBoxContainer/Label.text = "Game over.... score: " + str(Global.score)
	$SadTrombone.play()
	$GameOver.show()
	#get_tree().paused = true
