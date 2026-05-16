extends Node

var audio_stream_player : AudioStreamPlayer
var audio_stream_player2 : AudioStreamPlayer
var audio_stream_player_ui : AudioStreamPlayer

var players : Array[AudioStreamPlayer]

var audio : Dictionary = {
	"pickup1": load("res://assets/audio/pickup2.wav"),
	"engine1": load("res://assets/audio/engine1.wav"),
	"drill1": load("res://assets/audio/drill1.wav"),
	"explosion1": load("res://assets/audio/explosion1.wav"),
}

func _ready() -> void:
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player2 = AudioStreamPlayer.new()
	audio_stream_player_ui = AudioStreamPlayer.new()
	audio_stream_player_ui.volume_db = -2.0
	add_child(audio_stream_player)
	add_child(audio_stream_player2)
	add_child(audio_stream_player_ui)
	players.append(audio_stream_player_ui)
	players.append(audio_stream_player)
	players.append(audio_stream_player2)
	SignalBus.resource_gathered.connect(_on_resource_gathered)
	SignalBus.asteroid_split.connect(_on_asteroid_split)

func play_audio(key : String, i : int = 0) -> void:
	if key not in audio || i >= len(players):
		return

	var stream = audio[key]
	var player := players[i]
	if player.stream == stream:
		if !player.is_playing():
			player.play()
		return

	player.stream = stream
	player.play()

func stop_audio(key : String, i : int = 0) -> void:
	if key not in audio || i >= len(players):
		return

	var stream = audio[key]
	var player := players[i]
	if player.stream != stream:
		return

	player.stop()

func _on_resource_gathered(_data : ResourceData) -> void:
	audio_stream_player_ui.stop()
	audio_stream_player_ui.stream = audio["pickup1"]
	audio_stream_player_ui.play()

func _on_asteroid_split(_at : Vector2) -> void:
	audio_stream_player_ui.stop()
	audio_stream_player_ui.stream = audio["explosion1"]
	audio_stream_player_ui.play()
