extends KinematicBody2D

onready var canon := $canon
onready var shootPoint := $canon/ShootPoint
onready var danceAnimation := $DanceAnimation
var moveSpeed = 200
var knockback = 400
var rotationSpeed = 2
var bullet := preload("res://entities/Bullet.tscn")

func _ready():
	$SpawnAnimation.play("spawn")
	Global.player = self
	BeatMachine.connect("beatEvent", self, "shoot")
	BeatMachine.connect("subBeatEvent", self, "dance")

func _physics_process(delta):
	movement()

func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.position = shootPoint.global_position
	bullet_instance.set_bullet_direction(Vector2(1, 0).rotated(canon.global_rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
	$canon/shootinSmoke.emitting = true
	
	self.move_and_slide(get_global_mouse_position().direction_to(global_position).normalized() * knockback)
	
func movement():
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed("down"):
		movement.x = -1;
	if Input.is_action_pressed("up"):
		movement.x = 1;
	if Input.is_action_pressed("left"):
		self.rotation_degrees -= rotationSpeed;
	if Input.is_action_pressed("right"):
		self.rotation_degrees += rotationSpeed;
		
	self.move_and_slide(movement.rotated(self.rotation) * moveSpeed)
	canon.look_at(get_global_mouse_position())
	
func dance():
	danceAnimation.play("dance")
