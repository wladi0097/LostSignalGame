extends Node

onready var audioPlayer := $AudioStreamPlayer
onready var subBeat := $subBeat
signal beatEvent
signal subBeatEvent

var counter = 0

func _ready():
	subBeat.wait_time = 0.5
	subBeat.connect("timeout", self, "emitSubBeat")
	audioPlayer.connect("finished", self, "startAudio")
	startAudio()

func startAudio():
	counter = 0
	audioPlayer.play()
	subBeat.start(0)
	emitSubBeat()

func emitBeatEvent():
	emit_signal("beatEvent")

func emitSubBeat():
	counter += 1
	if counter % 4 == 0:
		emitBeatEvent()
	emit_signal("subBeatEvent")
