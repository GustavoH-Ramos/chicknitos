extends CanvasLayer

@onready var label_score: Label = $LabelScore
@onready var label_best: Label = $LabelBest

func _ready():
	visible = false
	
func show_game_over(current_score : int, high_score : int):
	label_score.text = "Score:" + str(current_score)
	label_best.text = "Best Score:" + str(high_score)
	visible = true
	get_tree().paused = true	
	
func _unhandled_input(event):
	if visible and event.is_action_pressed("Jump"):
		get_tree().paused = false
		get_tree().reload_current_scene()

	
