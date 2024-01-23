extends Node2D

var TileTypes = ["green", "blue", "brown"]

var Map = []
var mapHeight = 8
var MapWidth = 8

func _ready():
	SetupMapArray()
	GenerateMap()
	PlaceGrayCat()
	DrawMap()

func _process(delta):
	pass

func GenerateMap():
	var rng = RandomNumberGenerator.new()
	
	for i in MapWidth:
		for j in mapHeight:
			Map[i][j] = TileTypes[rng.randi_range(0, 2)]

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
			var tile = CreateTile(Map[i][j])
			var tileInstance = tile.instantiate()
			tileInstance.position.x = startPosition.x + ((i) * widthMargin)
			tileInstance.position.y = startPosition.y + ((j) * heightMargin)
			add_child(tileInstance)

func PlaceGrayCat():
	pass

func CreateTile(type):
	if type == "green":
		return load("res://Scenes/green_tile.tscn")
	if type == "blue":
		return load("res://Scenes/blue_tile.tscn")
	if type == "brown":
		return load("res://Scenes/brown_tile.tscn")
		
