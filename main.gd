extends Node

@export var health_pickup: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthSpawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	pass # Replace with function body.
