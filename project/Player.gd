extends KinematicBody2D

# change these to adjust feel of motion
const GRAVITY = 1000
const MAX_SPEED = 500
const ACCELERATION = 800
const FRICTION = 1500
const JUMP = 600

var velocity = Vector2.ZERO
onready var anim = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# right, left, idle
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCELERATION * delta)
		anim.play("walk")
		anim.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCELERATION * delta)
		anim.play("walk")
		anim.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		anim.play("idle")
		
	# jump
	if Input.is_action_pressed("ui_select") and is_on_floor():
		velocity.y = -JUMP
		
	if not is_on_floor():
		anim.play("jump")
	
func _physics_process(delta):
	# gravity
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
