extends CanvasLayer

var GonnaPause:bool = true

func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_resume_pressed():
	ResumeGame()

func _process(_delta):
	if Input.is_action_just_pressed("PauseToggle") and !GonnaPause:
		ResumeGame()
		
	if GonnaPause:
		GonnaPause=false

func PauseGame():
	visible=true
	get_tree().paused=true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Engine.time_scale=0
	GonnaPause=true
	
func ResumeGame():
	visible=false
	get_tree().paused=false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Engine.time_scale=1
	GonnaPause=true
