extends Node

func save_Data():
	print("saving")
	var file = FileAccess.open(Global.save_game_path,FileAccess.WRITE)
	file.store_var(Global.CurrentLevel)
	file.store_var(Global.UnlockedLevel)
	for i in 4:
		file.store_var(Global.Volume[i])
	
	for i in Global.UnlockedWeapon:
		file.store_var(i)
	
	for i in Global.UnlockedSpecial:
		file.store_var(i)
	
	for i in Global.EquippedWeapon:
		file.store_var(i);
		
	file.store_var(Global.SpecialType)
	
func load_Data():
	if FileAccess.file_exists(Global.save_game_path):
		print("loading")
		var file = FileAccess.open(Global.save_game_path,FileAccess.READ)
		Global.CurrentLevel=file.get_var(Global.CurrentLevel)
		Global.UnlockedLevel=file.get_var(Global.UnlockedLevel)
		for i in 4:
			Global.Volume[i]=file.get_var(Global.Volume[i])
			print(Global.Volume[i])
		
		for i in Global.UnlockedWeapon:
			i=file.get_var(i)
		
		for i in Global.UnlockedSpecial:
			i=file.get_var(i)
			
		for i in Global.EquippedWeapon:
			i=file.get_var(i);
		
		Global.SpecialType=file.get_var(Global.SpecialType)
			
	else:
		print("cc ko cos file")

