extends Area2D

var entered_counts = 0

signal pressed
signal released

func _on_body_entered(body):
  if body is RigidBody2D or body.name == "player":
    entered_counts += 1

    if entered_counts == 1:
      if $animated_sprite.animation != "pressed":
        $animated_sprite.play("pressed")

      emit_signal("pressed")


func _on_body_exited(body):
  if body is RigidBody2D or body.name == "player":
    entered_counts -= 1

    if entered_counts <= 0:
      if $animated_sprite.animation != "default":
        $animated_sprite.play("default")

      emit_signal("released")
