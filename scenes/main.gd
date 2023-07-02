extends Node2D


func _on_pressure_switch_body_entered(body):
  if body is RigidBody2D:
    var gate = $tilemap.get_cell_tile_data(1, Vector2i(9, 0))



func _on_pressure_switch_body_exited(body):
  if body is RigidBody2D:
    $tilemap.set_cell(0, Vector2i(9, 0), 0, Vector2i(1, 0))
