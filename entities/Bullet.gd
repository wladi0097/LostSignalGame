extends KinematicBody2D

var speed = 350
var velocity = Vector2()
var bouncesLeft = 1
var isFromEnemy = false

func _ready():
	if isFromEnemy:
		modulate = Color('ff0036')

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider == Global.player:
			Global.gameOver()
			die()
			
		if collision.collider.has_method('die'):
			if isFromEnemy && collision.collider.has_meta('enemy'):
				die()
			else:
				collision.collider.die()
				die()
			
		velocity = velocity.bounce(collision.normal)
		if bouncesLeft == 0:
			die()
		bouncesLeft -= 1

func set_bullet_direction(direction: Vector2):
	velocity = direction * speed

func die():
	self.queue_free()
	
