extends CharacterBody2D

const SPEED = 10.0
const JUMP_VELOCITY = -400.0
const DRAG_COEFFICIENT = 0.9
const VELOCITY_CAP = 200
const JUMSM = 5
var jumps_current = JUMSM;
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpFX

func _ready():
	jumpFX = $JumpFX

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
				jumps_current = JUMSM
		else:
			jumps_current -= 1
		if is_on_floor() or jumps_current > 1:
			velocity.y = jumps_current * JUMP_VELOCITY / 5
			jumpFX.emitting = true
			print(velocity.y)
			$JumpSfx.play()
			
		
	

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED + velocity.x
		$AnimatedSprite2D.play("run")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
		if abs(velocity.x) > VELOCITY_CAP: velocity.x = VELOCITY_CAP * (-1 if velocity.x < 0 else 1)
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)
		velocity.x *= DRAG_COEFFICIENT
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")

	move_and_slide()
