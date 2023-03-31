extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/Winner.visible = false


func _on_KillPlane_body_entered(body):
	body.position.x = 120
	body.position.y = 500


func _on_Coin_body_entered(_body):
	score += 1
	$HUD/Score.text = 'Score: ' + str(score)
	
	if score >= 5:
		$HUD/Winner.visible = true
	
