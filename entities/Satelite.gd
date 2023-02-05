extends StaticBody2D

onready var dance := $DanceAnimation
export(PackedScene) var nextLevel

func _ready():
	BeatMachine.connect("subBeatEvent", self, "dance")

func die():
	get_tree().change_scene_to(nextLevel)

func dance():
	dance.play("dance")
