extends Node

func save_Data():
	var file = FileAccess.open(Global.save_game_path,FileAccess.WRITE)
	file.store_var(Global.CurrentLevel)
	file.store_var(Global.UnlockedLevel)
	file.store_var(Global.Volume)
	
	for i in Global.UnlockedWeapon:
		file.store_var(i)
	
	for i in Global.UnlockedSpecial:
		file.store_var(i)
		
func load_Data():
	if FileAccess.file_exists(Global.save_game_path):
		var file = FileAccess.open(Global.save_game_path,FileAccess.READ)
		Global.CurrentLevel=file.get_var(Global.CurrentLevel)
		Global.UnlockedLevel=file.get_var(Global.UnlockedLevel)
		Global.Volume=file.get_var(Global.Volume)
		
		for i in Global.UnlockedWeapon:
			i=file.get_var(i)
		
		for i in Global.UnlockedSpecial:
			i=file.get_var(i)
	else:
		print("cc ko cos file")
