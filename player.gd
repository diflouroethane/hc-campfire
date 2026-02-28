extends CharacterBody2D

class_name Player

const SPEED: float = 175.0
const BURROW_SPEED: float = 250.0
const JUMP_VELOCITY: float = -300.0
var is_attacking: bool = false
var is_under: bool = false
var maxHealth: int = 10
var health: int = maxHealth
var dir = "left"
var damageable: bool = true
signal game_over
@onready var _animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	_animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	set_globals()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#print(is_attacking)
	if is_under:
		_animated_sprite_2d.play("burrow")
	#elif !is_attacking:
		#_animated_sprite_2d.play("default")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_under:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("burrow") and is_on_floor():
		if !is_under:
			$BurrowTimer.start()
			_animated_sprite_2d.play("burrow")
			is_under = true
		elif !is_attacking:
			is_attacking = false
			if !$BurrowTimer.is_stopped(): $BurrowTimer.stop()
			is_under = false
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("left"):
		_animated_sprite_2d.flip_h = true
		dir = "left"
	if Input.is_action_just_pressed("right"):
		_animated_sprite_2d.flip_h = false
		dir = "right"
		
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * BURROW_SPEED if is_under else direction * SPEED
		if _animated_sprite_2d.animation != "walk" and !is_under and !is_attacking:
			#print(_animated_sprite_2d.animation)
			_animated_sprite_2d.play("walk")
			#print(_animated_sprite_2d.animation)
	else:
		if !is_under and !is_attacking:
			_animated_sprite_2d.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("attack"):
		#if !is_attacking:
		_animated_sprite_2d.play("attack")
		is_attacking = true
		if dir == "left":
			$ShapeColl/CollisionShapeLeft.disabled = false
			$ShapeColl/CollisionShapeRight.disabled = true
		else:
			$ShapeColl/CollisionShapeLeft.disabled = true
			$ShapeColl/CollisionShapeRight.disabled = false
		
		
		
	if !is_on_floor():
		is_under = false
	move_and_slide()
	
func set_globals() -> void:
	Global.playerBurrowTimeLeft = $BurrowTimer.time_left
	Global.playerBurrowTime = $BurrowTimer.wait_time
	Global.playerHealth = health

func hurt(amt = 1):
	if damageable:
		health -= amt
		$HurtTimer.start()
		print("damageable no mpore")
		damageable = false
	
	if health <= 0:
		game_over.emit()

func _on_burrow_timer_timeout() -> void:
	print("kicking player out of burrow")
	if is_under:
		is_under = false
		_animated_sprite_2d.play("walk")


func _on_animated_sprite_2d_animation_finished() -> void:
		is_attacking = false
		$ShapeColl/CollisionShapeLeft.disabled = true
		$ShapeColl/CollisionShapeRight.disabled = true
		
		


func _on_shape_coll_body_entered(body: Node2D) -> void:
	if body is Enemy:
		print("hit enemy!!")
		body.hurt()


func _on_hurt_timer_timeout() -> void:
	damageable = true
	print("damageable now")
