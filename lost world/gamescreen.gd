extends CanvasLayer
@onready var collectable_label = $VBoxContainer/HBoxContainer/collectable_Label

func _ready():
	CollactableManager.on_collectible_award_received.connect(on_collectible_award_received)
	

func on_collectible_award_received(total_aword : int):
	collectable_label.text = str(total_aword)

func _on_purse_texture_button_pressed():
	GameManager.purse_game()
