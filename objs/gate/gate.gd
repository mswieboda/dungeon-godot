extends AnimatableBody2D

func open():
  if $animated_sprite.animation == "open":
    return
  $animated_sprite.play("open")

func close():
  if $animated_sprite.animation == "close":
    return
  $animated_sprite.play("close")

func _on_animated_sprite_animation_finished():
  if $animated_sprite.animation == "open":
    $collision.disabled = true
  else:
    $collision.disabled = false
