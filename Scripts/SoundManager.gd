extends Node2D

var background_music: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
	set_master_volume(0.2)
	set_music_volume(0.2)
	set_effects_volume(0.7)

func play_music():
	background_music.play()

func get_master_volume() -> float:
	return background_music.volume_db

func set_master_volume(volume: float) -> void:
	background_music.volume_db = linear_to_db(volume)

func get_music_volume() -> float:
	return background_music.volume_db

func set_music_volume(volume: float) -> void:
	background_music.volume_db = linear_to_db(volume)

func get_effects_volume() -> float:
	return background_music.volume_db

func set_effects_volume(volume: float) -> void:
	background_music.volume_db = linear_to_db(volume)

func save_settings() -> void:
	var config_file = ConfigFile.new()
	config_file.set_section_key("Audio", "master_volume", str(get_master_volume()))
	config_file.set_section_key("Audio", "music_volume", str(get_music_volume()))
	config_file.set_section_key("Audio", "effects_volume", str(get_effects_volume()))
	config_file.save("user://audio_settings.cfg")

func load_settings() -> void:
	var config_file = ConfigFile.new()
	if config_file.load("user://audio_settings.cfg") == OK:
		set_master_volume(float(config_file.get_section_key("Audio", "master_volume", "0.5")))
		set_music_volume(float(config_file.get_section_key("Audio", "music_volume", "0.5")))
		set_effects_volume(float(config_file.get_section_key("Audio", "effects_volume", "0.8")))
