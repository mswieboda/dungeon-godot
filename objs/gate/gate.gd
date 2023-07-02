extends AnimatableBody2D

const PLAYER_Z_INDEX = 2

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
    z_index += PLAYER_Z_INDEX
  else:
    $collision.disabled = false
    z_index -= PLAYER_Z_INDEX
