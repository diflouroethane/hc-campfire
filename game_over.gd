extends Control

func _on_restart_button_pressed() -> void:
	print("restart")
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	print("quit")
	get_tree().quit()
