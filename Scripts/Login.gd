extends Node2D

@onready var username = get_node("Control/MarginContainer/HeaderVBox/Label/MarginContainer/VolumeVBox/VBoxContainer/inputUsername")
@onready var password = get_node("Control/MarginContainer/HeaderVBox/Label/MarginContainer/VolumeVBox/VBoxContainer2/inputPassword")
@onready var authorizationFailed = get_node("Control/MarginContainer/HeaderVBox/Label/MarginContainer/VolumeVBox/AuthorizationStatus")
signal get_credentials(name, pw)

func _on_request_completed(result, response_code, headers, body):
	print("Sending to back end API...")
	var json = JSON.parse_string(body.get_string_from_utf8())
	print("Response Code: " + str(response_code))
	if response_code == 401:
		authorizationFailed.text = "invalid login credentials."
	elif response_code != 200:
		print("Problem with request.")
		authorizationFailed.text = "Something went wrong, try again."
	else:
		print("Connection successful.")
		SceneTransition.change_scene("res://Scenes/MainScenes/Menu.tscn")
		
func _on_submit_pressed():
	emit_signal("get_credentials", username.text, password.text)
	
	print("username: " + username.text)
	print("password: " + password.text)
	if username.text == "aaa" and password.text == "aaa":
		print("Credentials Valid")
		SceneTransition.change_scene("res://Scenes/MainScenes/Menu.tscn")
	else:
		authorizationFailed.text = "Attempting login..."
		var data = {
			"username": username.text,
			"password": password.text
		}
		var query = JSON.stringify(data, "",false )
		print(query)
		var headers = ["Content-Type: application/json"]
		
		$HTTPRequest.request_completed.connect(_on_request_completed)
		$HTTPRequest.request("http://localhost:3000/auth/login", headers, HTTPClient.METHOD_POST, query)

func _on_button_pressed():
	get_tree().quit()
