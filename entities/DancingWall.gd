extends StaticBody2D

onready var dance := $DanceAnimation
export(PackedScene) var nextLevel

func _ready():
	BeatMachine.connect("beatEvent", self, "dance")

func dance():
	dance.play("dance")
