extends AnimatableBody2D

const PLAYER_Z_INDEX = 1

var animation_speed = 0

func open():
  animate_play(1)

func close():
  animate_play(-1)

func _on_animated_sprite_animation_finished():
  if animation_speed > 0:
    $collision.disabled = true
    z_index = PLAYER_Z_INDEX + 1
  else:
    $collision.disabled = false
    z_index = 0

  animation_speed = 0

func animate_play(speed):
  if animation_speed == speed:
    return

  animation_speed = speed

  var frame = $animated_sprite.frame
  var progress = $animated_sprite.frame_progress

  $animated_sprite.play("default", speed)
  $animated_sprite.set_frame_and_progress(frame, progress)
