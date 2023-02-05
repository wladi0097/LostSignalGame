extends KinematicBody2D

var movementSpeed = 50
onready var navigation: Navigation2D = get_parent()
onready var dance := $DanceAnimation

func _ready():
	BeatMachine.connect("subBeatEvent", self, "dance")
	
func dance():
	dance.play("dance")

func _physics_process(_delta):
	movement()

func movement():
	var path = navigation.get_simple_path(self.position, Global.player.position)
	if path.size() > 1:
		path.remove(0)
		var nextWantedPosition: Vector2 = path[0]
		move_and_slide(self.position.direction_to(nextWantedPosition) * movementSpeed)
	look_at(Global.player.global_position)

func die():
	queue_free()


func _on_killRange_body_entered(body):
	if body == Global.player:
		Global.gameOver()
