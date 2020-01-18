extends Node

var data = 0
const FILE_LOCATION = "user://data.dat" # ubicacion y nombre del archivo

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(FILE_LOCATION, file.WRITE)
	file.store_var(data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(FILE_LOCATION):
		return
	file.open(FILE_LOCATION, file.READ)
	data = file.get_var()
	file.close()