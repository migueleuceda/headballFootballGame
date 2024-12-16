extends AudioStreamPlayer


func _ready():
	MusicManager.music_tracks = [
		"res://sonido/Waka_Waka_Esto_es_Africa_Cancion_Oficial_de_la_Copa_Mundial_de_la_FIFA_Sudafrica_2010_[_YouConvert.net_].mp3",
		"res://sonido/Avicii - The Nights (FIFA 15 Soundtrack)_[_YouConvert.net_].mp3"
	]
	MusicManager.current_track_index = clamp(MusicManager.current_track_index, 0, MusicManager.music_tracks.size() - 1)
	stream = load(MusicManager.music_tracks[MusicManager.current_track_index])
	play()

func _process(_delta):
	if Input.is_action_just_pressed("ui_Pass_Music"):
		_change_music()

func _change_music():
	MusicManager.current_track_index = (MusicManager.current_track_index + 1) % MusicManager.music_tracks.size()
	stop()
	stream = load(MusicManager.music_tracks[MusicManager.current_track_index])
	play()
	print("Reproduciendo: " + MusicManager.music_tracks[MusicManager.current_track_index])
