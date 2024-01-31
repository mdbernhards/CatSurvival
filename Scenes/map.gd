extends Node2D

var TileTypes = ["green", "blue", "brown"]

var Map = []
var mapHeight = 8
var MapWidth = 8

var RNG

var catLocationColumn
var catLocationRow

var Turn = 0

var Cat

func _ready():
	RNG = RandomNumberGenerator.new()
	SetupMapArray()
	GenerateMap()
	DrawMap()
	PlaceGrayCat()
	PlaceDog()

func _process(delta):
	pass

func GenerateMap():
	for i in MapWidth:
		for j in mapHeight:
			Map[i][j] = TileTypes[RNG.randi_range(0, 2)]

func SetupMapArray():
	for i in MapWidth:
		Map.append([])
		for j in mapHeight:
			Map[i].append(-1)

func DrawMap():
	var widthMargin = 130
	var heightMargin = 130
	
	var startPosition = $TileSpawnStartPosition.position
	
	for i in MapWidth:
		for j in mapHeight:
			var tile = CreateTile(Map[i][j], j, i)
			tile.position.x = startPosition.x + ((i) * widthMargin)
			tile.position.y = startPosition.y + ((j) * heightMargin)
			Map[i][j] = tile
			add_child(tile)

func PlaceGrayCat():
	catLocationColumn = RNG.randi_range(0, 7)
	catLocationRow = RNG.randi_range(0, 7)
	var tilePlaced = Map[catLocationColumn][catLocationRow]
	Cat = load("res://Scenes/GrayCat.tscn").instantiate()
	Cat.position = tilePlaced.position
	add_child(Cat)

func PlaceDog():
	var tilePlaced = Map[RNG.randi_range(0, 7)][RNG.randi_range(0, 7)]
	var dog = load("res://Scenes/dog.tscn").instantiate()
	dog.position = tilePlaced.position
	dog.Row = tilePlaced.Row
	dog.Column = tilePlaced.Column
	add_child(dog)

func MoveCat(catColumn, catRow, position):
	catLocationColumn = catColumn
	catLocationRow = catRow
	Cat.position = position
	Turn += 1
	$Label.text = "Turn: " + str(Turn)
	MoveEnemies()
	
func CreateTile(type, row, column):
	var newTile = load("res://Scenes/tile.tscn").instantiate()
	newTile.SetUpTile(type, row, column)
	return newTile
	if type == "green":
		return load("res://Scenes/green_tile.tscn").instantiate()
	if type == "blue":
		return load("res://Scenes/blue_tile.tscn").instantiate()
	if type == "brown":
		return load("res://Scenes/brown_tile.tscn").instantiate()
		
func MoveEnemies():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		enemy.Move()
