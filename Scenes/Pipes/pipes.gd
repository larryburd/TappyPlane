extends Node2D

@onready var score_sound = $ScoreSound

var _plane_died: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_plane_died.connect(on_plane_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta * GameManager.SCROLL_SPEED

func on_plane_died() -> void:
	_plane_died = true
	set_process(false)

func _on_screen_exited():
	queue_free()


func _on_laser_body_exited(body):
	var isPlayer: bool = body.is_in_group(GameManager.GROUP_PLAYER)
	
	# Make sure the plane is still alive and is the player
	if !_plane_died && isPlayer:
		ScoreManager.increment_score()
		score_sound.play()


func _on_pipe_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLAYER):
		if body.has_method("die"):
			body.die()
