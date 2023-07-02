extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  pass

func open():
  $animated_sprite.play("open")

func close():
  $animated_sprite.play("close")

func _on_animated_sprite_animation_finished():
  if $animated_sprite.animation == "open":
    $collision.disabled = true
  else:
    $collision.disabled = false
