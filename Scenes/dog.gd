extends StaticBody2D

var Row
var Column

var Map
var RNG

var Angry = false

func _ready():
	Map = get_parent().Map
	RNG = RandomNumberGenerator.new()

func _process(delta):
	pass

func Move():
	Row = Row + RNG.randi_range(-1, 1)
	Column = Column + RNG.randi_range(-1, 1)
	
	if Row > 7: Row = 7
	if Row < 0: Row = 0
	if Column > 7: Column = 7
	if Column < 0: Column = 0
	
	position = Map[Row][Column].position
