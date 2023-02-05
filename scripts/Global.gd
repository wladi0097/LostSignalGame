extends Node2D

onready var timer = $Timer
onready var timeLabel = $CanvasLayer/Label
var player

var ms = 0
var s = 0
var m = 0

func _input(event):
	if event.is_action_pressed("reset"):
		hardResetGame()

func hardResetGame():
	get_tree().change_scene("res://worlds/01_tutorial.tscn")
	startTimer()

func _ready():
	startTimer()

func gameOver():
	get_tree().reload_current_scene()

func startTimer():
	ms = 0
	s = 0
	m = 0
	timer.start()

func getFinalTime():
	timer.stop();
	return timeLabel.text

func cleanTimeString(time):
	return "0" + str(time) if time < 10 else str(time)

func _on_Timer_timeout():
	ms += 1
	if ms > 9:
		s += 1
		ms = 0
	
	if s > 59:
		m += 1
		s = 0
		
	timeLabel.text = cleanTimeString(m)+":"+cleanTimeString(s)+":"+str(ms)
