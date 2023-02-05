extends Node2D


func _ready():
	$scoreLabel.text = Global.getFinalTime()
