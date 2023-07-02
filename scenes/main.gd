extends Node2D

@onready var gate = $tilemap.get_node("gate")

func _on_pressure_switch_pressed():
  if gate.has_method("open"):
    gate.open()

func _on_pressure_switch_released():
  if gate.has_method("close"):
    gate.close()
