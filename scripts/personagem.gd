extends KinematicBody2D

onready var sprite = get_node("sprite")
onready var colisao = get_node("colisao") 


export var speed = 350 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		velocity = velocity.normalized() * speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		velocity = velocity.normalized() * speed
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		velocity = velocity.normalized() * speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		velocity = velocity.normalized() * speed
		
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("parada")
	else:
		$AnimationTree.get("parameters/playback").travel("andando")
		$AnimationTree.set("parameters/parada/blend_position", velocity)
		$AnimationTree.set("parameters/andando/blend_position", velocity)
		
	
	sprite.scale.x = 0.1 + position.y/600
	sprite.scale.y = 0.1 + position.y/600
	
	colisao.scale.x = sprite.scale.x * 2
	colisao.scale.y = sprite.scale.y * 2
	
	colisao.position.x = sprite.position.x
	colisao.position.y = -sprite.position.y * 6 
	
	move_and_slide(velocity)
	
	if(position.x > screen_size.x):
		position.x = screen_size.x
	if(position.x < 0):
		position.x = 0
	if(position.y > screen_size.y):
		position.y = screen_size.y
	if(position.y < 0):
		position.y = 0
	
