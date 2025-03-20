extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_group("Movement")
@export var jump_velocity = -200.0 # Сила прыжка
@export var max_speed = 100 # Максимальная скорость
var acceleration = 1 # Ускорение
var friction = 3 # Торможение
@export_group("Health")
@export var health: int = 3 # Здоровье игрока
@export_group("Fight")
@export var projectile_scene: PackedScene # Сцена снаряда
@export var fire_rate: float = 0.2 # Задержка между выстрелами
var can_shoot: bool = true # Возможность стрельбы

@export var knockback_force: float = 200.0  # Сила отталкивания
@export var knockback_time: float = 0.3  # Время отталкивания
var is_knockbacked: bool = false

var at_death: bool = false


@onready var animation_player = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var audio_shoot = $AudioStreamPlayer2D

func take_damage(enemy_position: Vector2):
	if is_knockbacked:
		return
		
	is_knockbacked = true
	
	var knockback_direction = (position - enemy_position).normalized()
	velocity = knockback_direction * knockback_force
	health -= 1
	if health <= 0:
		at_death = true
		die()
	await get_tree().create_timer(knockback_time).timeout
	is_knockbacked = false
		
func die():
	animation_player.stop()
	collision_layer = 1 << 9
	animation_player.play("death")
	await animation_player.animation_finished
	camera.reparent(get_parent())
	camera.position = Vector2(130, 54)
	camera.make_current()
	queue_free()
	
func shoot():
	if projectile_scene:
		var projectile = projectile_scene.instantiate() # Создаем снаряд
		projectile.direction = Vector2.RIGHT if $AnimatedSprite2D.flip_h == false else Vector2.LEFT
		projectile.position = position + Vector2(0, 0) # Позиция выстрела
		audio_shoot.play()
		get_parent().add_child(projectile) # Добавляем снаряд в сцену
		can_shoot = false
		await get_tree().create_timer(fire_rate).timeout # Задержка между выстрелами
		can_shoot = true
	
func _process(delta):
	if Input.is_action_just_pressed("ui_shoot") and can_shoot:
		shoot()

func _physics_process(delta):
	
	if at_death:
		position.y -= 5 * delta
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * max_speed, acceleration)
		if direction < 0:
			animation_player.flip_h = true
		elif direction > 0:
			animation_player.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		
	
	
	if  velocity.x == 0 and velocity.y == 0:
		animation_player.play("idle")
	elif velocity.y > 0 or velocity.y < 0:
		animation_player.play("jump")
	elif velocity.x > 0 or velocity.x < 0 and is_on_floor():
		animation_player.play("run")

	move_and_slide()
