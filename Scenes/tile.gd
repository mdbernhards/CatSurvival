extends StaticBody2D

var Row
var Column

var Map

func _ready():
	Map = get_parent()

func _process(delta):
	pass

func SetUpTile(type, row, column):
	Row = row
	Column = column
	if type == "green":
		$Sprite2D.texture = load("res://Art/Tiles/GreenTile.png")
	if type == "blue":
		$Sprite2D.texture = load("res://Art/Tiles/BlueTile.png")
	if type == "brown":
		$Sprite2D.texture = load("res://Art/Tiles/BrownTile.png")

func _on_mouse_entered():
	var colDiff = Map.catLocationColumn-Column
	var rowDiff = Map.catLocationRow-Row
	
	if CanInteractWithCat():
		$TransparentSprite.visible = true

func _on_mouse_exited():
	$TransparentSprite.visible = false

func CanInteractWithCat():
	var colDiff = Map.catLocationColumn-Column
	var rowDiff = Map.catLocationRow-Row
	
	if (colDiff >= -1 and colDiff <= 1) and (rowDiff >= -1 and rowDiff <= 1) and !(colDiff == 0 and rowDiff == 0):
		return true
	return false

func _on_input_event(viewport, event, shape_idx):
	if event.is_action("MoveCat") and CanInteractWithCat():
		Map.MoveCat(Column, Row, position)
