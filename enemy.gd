extends CharacterBody2D

class_name Enemy
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var SPEED = 150.0
var p_inside = 0
var player
var health: int = 2
var dir = "left"

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	if dir == "left":
		if $ShapeCastRight.is_colliding():
			animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
			dir = "right"
	else:
		if $ShapeCastLeft.is_colliding():
			animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
			dir = "left"
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if dir == "left":
		velocity.x = SPEED
	else:
		velocity.x = -SPEED
	if p_inside >= 1:
		print("hurt player")
		player.hurt()
		p_inside -= 1
		
	move_and_slide()



func _on_coll_body_entered(body: Node2D) -> void:
	if body is Player:
		if player == null: player = body
		p_inside += 0.5
		print("ooh player")
		if !body.is_under:
			#var default_scl = Engine.time_scale
			#Engine.time_scale = 0
			#await get_tree().create_timer(0.05, true, false, true).timeout
			#Engine.time_scale = default_scl
			body.hurt()
		else:
			print("burrowing")

func hurt(_amt=1):
	SPEED = -SPEED
	$RecoilTimer.start()
	health -= 1
	if health <= 0:
		Global.update_score()
		queue_free()

func _on_coll_body_exited(body: Node2D) -> void:
	if body is Player:
		p_inside -= 0.5


func _on_recoil_timer_timeout() -> void:
	SPEED = -SPEED
