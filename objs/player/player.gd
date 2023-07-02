extends CharacterBody2D

const SPEED = 6900

func _physics_process(delta):
  # Get the input direction and handle the movement/deceleration.
  var h_direction = Input.get_axis("move_left", "move_right")
  var v_direction = Input.get_axis("move_up", "move_down")
  var speed = SPEED * delta

  if h_direction:
    $animated_sprite.flip_h = h_direction < 0
    $animated_sprite.play("walk_horizontal")

    velocity.x = h_direction * speed
    velocity.y = move_toward(velocity.y, 0, speed)
  elif v_direction:
    $animated_sprite.flip_h = false
    $animated_sprite.play("walk_down" if v_direction > 0 else "walk_up")

    velocity.y = v_direction * speed
    velocity.x = move_toward(velocity.x, 0, speed)
  else:
    $animated_sprite.flip_h = false
    $animated_sprite.play("default")

  if h_direction and v_direction:
    velocity.x = 0.707 * h_direction * speed
    velocity.y = 0.707 * v_direction * speed

  if not h_direction:
    velocity.x = move_toward(velocity.x, 0, speed)

  if not v_direction:
    velocity.y = move_toward(velocity.y, 0, speed)

  move_and_slide()
