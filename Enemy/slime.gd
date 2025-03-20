extends CharacterBody2D

@export var health: int = 2 # Здоровье
@export var speed: float = 15.0  # Скорость врага
@export var gravity: float = 900.0  # Гравитация

var is_hurt: bool = false

@onready var animation_slime = $AnimatedSprite2D
@onready var audio_hit = $AudioStreamPlayer2D
func take_damage(amount: int):
	is_hurt = true
	collision_layer = 1 << 9
	audio_hit.play()
	animation_slime.stop()
	animation_slime.play("hit")
	health -= amount
	await animation_slime.animation_finished
	if health <= 0:
		die()
	else:
		collision_layer = 1 << 1
		is_hurt = false
		
func die():
	animation_slime.play("death")
	await animation_slime.animation_finished
	queue_free() # Уничтожение

func _physics_process(delta):
	
	if is_hurt:
		return # Если враг получает урон, он не двигается
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Движение по горизонтали
	velocity.x = speed
	animation_slime.play("walk")
	move_and_slide()
	
	if velocity.length() > 0 and animation_slime.is_playing():
		animation_slime.play("walk")

	# Разворот при столкновении со стеной
	if is_on_wall():
		speed *= -1
		scale.x *= -1  # Отражаем спрайт
