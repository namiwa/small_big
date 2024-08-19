extends Node2D

func _process(_delta):	
	if Input.is_action_pressed("Transform"):
		if $Small.get_type() == "small":
			$AnimationPlayer.play("transform")
		else:
			$AnimationPlayer.play_backwards("transform")
