extends Node2D

@export var award_amount: int = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var label = $Label
@onready var tween = $Tween  # Ensure the path is correct

func _ready():
	label.hide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("award amount")
		animated_sprite_2d.hide()

		# Set the label text using string concatenation
		label.text = "l1 " + str(award_amount)
		CollactableManager.give_pickup_amount(award_amount)
		label.show()
		queue_free()

		# Check if the tween is valid before using it
		if tween:
			tween.stop_all()  # Stop any existing tweens before starting a new one
			tween.interpolate_property(label, "position", label.position, Vector2(label.position.x, label.position.y - 10), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()

			# Properly connect the signal with a Callable
			tween.connect("tween_completed", Callable(self, "_on_tween_completed"))
		else:
			print("Tween node not found or is null.")
			queue_free()
			
func _on_tween_completed(object, key):
	queue_free()

