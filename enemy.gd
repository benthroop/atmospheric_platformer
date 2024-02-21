extends CharacterBody2D

var player
var dir
const SPEED = 0.2
const KILL_RADI = 20
const MAX_SPEED = 1
const ROT_AMNT = 30
var v = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	$AnimatedSprite2D.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	dir = (player.position - position)
	rotation = clamp(dir.x/80,-1,1)
	var d = dir.normalized()
	d.x = dir.x / 25
	position += d

func _process(delta):

	#v *= 0.999999
	if (tryHitPlayer()):
		get_parent().restartScene()
	
func tryHitPlayer():
	return position.distance_to(player.position) <= KILL_RADI
