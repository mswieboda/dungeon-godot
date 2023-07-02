extends CharacterBody2D

const SPEED = 6900
const PUSH_FORCE = 300

func _physics_process(delta):
  movement(delta)

func movement(delta):
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

  if move_and_slide() and (h_direction or v_direction): # true if collision
    for i in get_slide_collision_count():
      var col = get_slide_collision(i)

      # TODO: also check if it's a "block"
      if col.get_collider() is RigidBody2D:
        col.get_collider().apply_force(col.get_normal() * -PUSH_FORCE)
