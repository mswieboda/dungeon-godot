extends Node2D

@onready var gate = $tilemap.get_node("gate")

func _on_pressure_switch_body_entered(body):
  if body is RigidBody2D or body.name == "player":
    if gate.has_method("open"):
      gate.open()

func _on_pressure_switch_body_exited(body):
  if body is RigidBody2D or body.name == "player":
    if gate.has_method("close"):
      gate.close()
