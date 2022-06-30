extends TileMap

# new astar navigation node
onready var astar = AStar.new()
# Used to find the centre of a tile
onready var halfCell = cell_size / 2
#all tiles used
onready var pathfindingTiles = get_used_cells()
# The bounds of map
onready var usedRect = get_used_rect()

func _ready():
	# Add all tiles to the navigation grid
	_add_path_tiles(pathfindingTiles)
	# Connects all added tiles
	_connect_path_tiles(pathfindingTiles)

# Adds tiles navigation map
func _add_path_tiles(_pathfindingTiles):
	for tile in pathfindingTiles:
		var id = _get_id_for_point(tile)
		astar.add_point(id, Vector3(tile.x, tile.y, 0))

# Connects tiles with neighbour tile
func _connect_path_tiles(_pathfindingTiles):
	for tile in pathfindingTiles:
		var id = _get_id_for_point(tile)
		for x in range(3):
			for y in range(3):
				if x != y:
					var target = tile + Vector2(x - 1, y - 1)
					var targetId = _get_id_for_point(target)
					# Do not connect if point is same or point does not exist
					if tile == target or not astar.has_point(targetId):
						continue
					astar.connect_points(id, targetId, true)

# Determines a unique ID for a given point on the map
func _get_id_for_point(point):
	var x = point.x - usedRect.position.x
	var y = point.y - usedRect.position.y
	return x + y * usedRect.size.x

func get_path_thing(start, end):
	var startTile = world_to_map(start)
	var endTile = world_to_map(end)
	# Determines IDs
	var startId = _get_id_for_point(startTile)
	var endId = _get_id_for_point(endTile)
	if not astar.has_point(startId) or not astar.has_point(endId):
		return null
	# Otherwise, find the map
	var pathMap = astar.get_point_path(startId, endId)
	# Convert Vector3 array
	var pathWorld = []
	for point in pathMap:
		var pointWorld = map_to_world(Vector2(point.x, point.y)) + halfCell
		pathWorld.append(pointWorld)
	return pathWorld
