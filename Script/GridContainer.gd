extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"





# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Start_button_down():
	pass # Replace with function body.

func check(i:int):
	if(indexs.back() == i):
		print("wouhou !")

func _on_Button0_button_down():
	check(0)
	pass # Replace with function body.


func _on_Button1_button_down():
	check(1)
	pass # Replace with function body.


func _on_Button2_button_down():
	check(2)
	pass # Replace with function body.


func _on_Button3_button_down():
	check(3)
	pass # Replace with function body.
