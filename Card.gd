extends Node2D
class_name Card


func _ready():
    pass


func _process(delta):
    pass


func get_rect():
    return Rect2($TopLeft.global_position, $BottomRight.global_position - $TopLeft.global_position)
