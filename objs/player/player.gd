extends CharacterBody2D

const SPEED = 6900
const PUSH_FORCE = 300

var direction = Vector2.ZERO
var last_direction = Vector2.ZERO

func _physics_process(delta):
  movement(delta)
  actions(delta)

func should_switch_to_walk_animation():
  return $animated_sprite.animation != "whip_horizontal" or !$animated_sprite.is_playing()

func movement(delta):
  var speed = SPEED * delta

  # Get the input direction and handle the movement/deceleration.
  direction.x = Input.get_axis("move_left", "move_right")
  direction.y = Input.get_axis("move_up", "move_down")

  if direction.x:
    if should_switch_to_walk_animation():
      $animated_sprite.flip_h = direction.x < 0
      $animated_sprite.play("walk_horizontal")

    velocity.x = direction.x * speed
    velocity.y = move_toward(velocity.y, 0, speed)
  elif direction.y:
    if should_switch_to_walk_animation():
      $animated_sprite.flip_h = false
      $animated_sprite.play("walk_down" if direction.y > 0 else "walk_up")

    velocity.y = direction.y * speed
    velocity.x = move_toward(velocity.x, 0, speed)
  elif should_switch_to_walk_animation():
    $animated_sprite.pause()

  if direction.x and direction.y:
    direction *= 0.707

    velocity.x = direction.x * speed
    velocity.y = direction.y * speed

  if not direction.x:
    velocity.x = move_toward(velocity.x, 0, speed)

  if not direction.y:
    velocity.y = move_toward(velocity.y, 0, speed)

  if direction.x or direction.y:
    last_direction = direction

  if move_and_slide() and direction != Vector2.ZERO: # true if collision
    for i in get_slide_collision_count():
      var col = get_slide_collision(i)

      # TODO: also check if it's a "block"
      if col.get_collider() is RigidBody2D:
        col.get_collider().apply_force(col.get_normal() * -PUSH_FORCE)

func actions(delta):
  if last_direction.x != 0 and Input.is_action_just_pressed("whip"):
    $animated_sprite.flip_h = last_direction.x < 0
    $animated_sprite.play("whip_horizontal")
