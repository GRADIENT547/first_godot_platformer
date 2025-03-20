extends Node



var music_volume: float = 1.0
var sound_volume: float = 1.0
var player_health: int = 100
var coins_collected: int = 0

func save_data():
	var data = {
		"music_volume": music_volume,
		"sound_volume": sound_volume,
		"player_health": player_health,
		"coins_collected": coins_collected
	}
	var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	
func load_data():
	if FileAccess.file_exists("user://save_data.json"):
		var file = FileAccess.open("user://save_data.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text()).result
		music_volume = data.get("music_volume", 1.0)
		sound_volume = data.get("sound_volume", 1.0)
		player_health = data.get("player_health", 1.0)
		coins_collected = data.get("coins_collected", 1.0)
