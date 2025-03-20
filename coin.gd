extends Area2D

@onready var audio_collect = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		remove_child(audio_collect)
		get_parent().add_child(audio_collect)
		audio_collect.play()
		queue_free()
