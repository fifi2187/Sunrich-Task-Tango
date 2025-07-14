extends CharacterBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export var speed: float = 200.0

func _ready():
	$AnimationPlayer.play("idle_front")

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Tastaturinput vorhanden? (ja 7 nein) 
	if input_vector != Vector2.ZERO:
		# Optionale Normierung für gleichmäßige Geschwindigkeit in Diagonalen
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
		
		# 1. Abfrage: bewegt sich Player primär auf der x oder y Achse? 
		if abs(input_vector.x) > abs(input_vector.y):
			# 2. Abfrage: nach rechts oder links 
			if input_vector.x > 0:
				animation_player.play("waling_right")
			else:
				animation_player.play("walking_left")
		else:
			if input_vector.y > 0:
				animation_player.play("walking_front")
			else:
				animation_player.play("walking_back")	
	else:
		# Abbremsen bei keiner Eingabe (Bremsfaktor 0.05 kann geänedrt werden) 
		velocity.x = move_toward(velocity.x, 0, speed*0.15)
		velocity.y = move_toward(velocity.y, 0, speed*0.15)
		
	move_and_slide()
	


func _process(_delta):
	if velocity == Vector2.ZERO:

		$AnimationPlayer.play("idle_front")
