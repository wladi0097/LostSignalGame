extends StaticBody2D

onready var shootPoint := $canon/shootPoint
onready var canon := $canon
onready var dance := $DanceAnimation
var bullet := preload("res://entities/Bullet.tscn")

func _ready():
	set_meta('enemy', true)
	BeatMachine.connect("beatEvent", self, 'shoot')
	BeatMachine.connect("subBeatEvent", self, "doDance")

func _process(delta):
	self.look_at(Global.player.global_position)
	
func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.position = shootPoint.global_position
	bullet_instance.set_bullet_direction(Vector2(1, 0).rotated(self.global_rotation))
	bullet_instance.isFromEnemy = true
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
	$canon/shootinSmoke.emitting = true

func doDance():
	dance.play("dance")

func die():
	queue_free()
