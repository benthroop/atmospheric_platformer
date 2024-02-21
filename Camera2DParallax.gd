extends Camera2D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	var parentNode = get_parent();
	player = parentNode.get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func  _physics_process(delta):
	updatePosition()
	pass

func updatePosition():
	position = player.position
