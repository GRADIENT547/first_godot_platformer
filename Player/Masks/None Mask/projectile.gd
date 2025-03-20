extends Area2D

@export_group('stats')
@export var speed: float = 400.0 # скорость снаряда
@export var damage: int = 1 # урон снаряда

var direction: Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	# Таймер на уничтожение снаряда
	await get_tree().create_timer(2.0).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# движение снаряда
	position += direction * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemies"): # Проверяем, что это враг
		body.take_damage(damage) # Наносим урон
	queue_free() # Удалить снаряд
