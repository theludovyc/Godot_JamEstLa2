extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const FLASH_BUT = 0.3

var cancel = preload("res://Art/lineLight33.png")

var childs

var indexs:Array

var start = false

var show = false

var fail = false

var index = 0

var asps

var vols = [0, 0, 0, 0]

func addRandIndex():
	indexs.push_back(randi()%childs.size())

# Called when the node enters the scene tree for the first time.
func _ready():
	childs = $GridContainer.get_children()
	
	asps = [$ASP_0, $ASP_1, $ASP_2, $ASP_3]
	
	randomize()
	
	addRandIndex()
	
	pass # Replace with function body.

func tween_inter(node, startTime):
	$Tween.interpolate_property(node, "modulate:v", null, 0.5, FLASH_BUT, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, startTime)
	$Tween.interpolate_property(node, "modulate:v", 0.5, 1, FLASH_BUT, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, startTime + FLASH_BUT)

func showSequence():
	for i in range(indexs.size()):
		tween_inter(childs[indexs[i]], i * FLASH_BUT * 2)
	
	show = true
	
	$Tween.start()

func _on_Start_button_down():
	if !start:
		$ASP_0.play()
		$ASP_1.play()
		$ASP_2.play()
		$ASP_3.play()
		
		showSequence()
	
		$Start.texture_normal = cancel
	
		start = true
	else:
		get_tree().reload_current_scene()

func enableButtons():
	for c in childs:
		c.disabled = false

func _on_Tween_tween_all_completed():
	if show and !fail:
		enableButtons()
		show = false

func disableButtons():
	for c in childs:
		c.disabled = true

func check(i:int):
	if(indexs[index] == i):
		index += 1
		
		if index >= indexs.size():
			disableButtons()
			
			addRandIndex()
			
			index = 0
			
			showSequence()
			
		return true
	
	disableButtons()
	
	for child in childs:
		$Tween.interpolate_property(child, "modulate", null, Color(0.98, 0.2, 0.2), 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()
	
	fail = true

func incVol(i:int, i1:int):
	vols[i] = clamp(vols[i]+i1, 0, 3)
	
func resetAspVol():
	for i in range(asps.size()):
		asps[i].volume_db = range_lerp(vols[i], 0, 3, -50, 0)

func incVols(i0:int, i1:int, i2:int, i3:int):
	incVol(i0, 2)
	incVol(i1, 1)
	incVol(i2, 1)
	incVol(i3, -1)
	
	resetAspVol()

func _on_Button0_button_down():
	if check(0):
		incVols(0, 1, 2, 3)
	
	pass # Replace with function body.


func _on_Button1_button_down():
	if check(1):
		incVols(1, 0, 3, 2)
	
	pass # Replace with function body.


func _on_Button2_button_down():
	if check(2):
		incVols(2, 0, 3, 1)
	
	pass # Replace with function body.


func _on_Button3_button_down():
	if check(3):
		incVols(3, 1, 2, 0)
	
	pass # Replace with function body.
