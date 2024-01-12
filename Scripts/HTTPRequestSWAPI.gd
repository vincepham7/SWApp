extends HTTPRequest

signal character_data_fetched(data: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_use_threads(true)
	var headers : PackedStringArray = []
	self.connect("request_completed", doSomething)
	self.request("https://swapi.dev/api/people/1/")
	
func doSomething(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	if(response_code == 200):
		var data = JSON.parse_string(body.get_string_from_utf8())
		
		emit_signal("character_data_fetched", data)
		
	else:
		print('response_code: ', response_code)
		print('problem with server')
