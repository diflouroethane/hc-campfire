extends Node2D

class_name EnemySpawner

@export var toSpawn: PackedScene
@export var dir: directions
@export_range(0.0, 100.0) var time_to_wait: float = 1.75
enum directions {LEFT, RIGHT}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if time_to_wait == 0:
		$Timer.queue_free()
	else:
		$Timer.wait_time = time_to_wait if time_to_wait > 0 else 1.0




func _on_timer_timeout() -> void:
	var enemy: Enemy = toSpawn.instantiate()
	enemy.global_position = global_position
	get_parent().get_parent().add_child(enemy)
	match dir:
		directions.LEFT:
			enemy.dir = "left"
			#enemy.global_rotation = deg_to_rad(180)
			#enemy.animated_sprite_2d.flip_v = true
		directions.RIGHT:
			enemy.dir = "right"
	
	$Timer.wait_time = randf_range(time_to_wait-2, time_to_wait+2)

	
	
