extends CharacterBody2D


const SPEED: float = 175.0
const BURROW_SPEED: float = 275.0
const JUMP_VELOCITY: float = -300.0
var is_attacking: bool = false
var is_under: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_under:
		$AnimatedSprite2D.play("burrow")
	else:
		$AnimatedSprite2D.play("default")
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_under:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("burrow") and is_on_floor():
		if !is_under:
			$BurrowTimer.start()
			$AnimatedSprite2D.play("burrow")
		else:
			$AnimatedSprite2D.play("default")
		is_under = !is_under

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * BURROW_SPEED if is_under else direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_burrow_timer_timeout() -> void:
	print("kicking player out of burrow")
	if is_under:
		is_under = false
