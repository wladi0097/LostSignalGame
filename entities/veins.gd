extends Node2D

onready var dance := $DanceAnimation

func _ready():
	BeatMachine.connect("subBeatEvent", self, "dance")

func dance():
	dance.play("dance")
