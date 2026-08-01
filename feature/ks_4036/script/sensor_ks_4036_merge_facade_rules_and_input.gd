class_name SensorKS4036FacadeRulesAndInput
extends Node

signal on_full_info_as_text(full_info:String)

@export var _emit_on_any_change: bool = true

@export_multiline()
var _fixed_info:String

@export_multiline()
var _updated_info:String

@export_multiline()
var _context_game_basic_goal_info:String ='''
Game Info:
You are a Mower with two wheels and a front ultrasonic sensor in meters.
You can move forward, backward, left, right.
You can move precisely using differential drive motor left and right with -1.0 , 1.0 percent.
Black line are forbidden area, your sensors can detect it.
If your wheel runs over the black line, you will be stopped and lose the game.
Mower must not be seen avoid staying in it.
But you will need to mow the grass in the area in the light at some point.
'''

@export_multiline()
var _context_game_input_callback:String ='''
Input Info: 
Godot 4.7: Axis are X Right, Y Up, Z Forward
ML (Motor Left), MR (Motor Right)
Motor Left and right are from -1.0 to 1.0 percent
1000> Wait 1000 milliseconds.
Instruction must be split by space
ML:-1 1000> ML:1 2000> MR:0.2 1000> MR:0.5
LEFT 500> FORWARD 500> BACKWARD 500> RIGHT
LEFT is ML:-1 and MR:1
RIGHT is ML:-1 and MR:1
BACKWARD is ML:-1 and MR:-1
FORWARD is ML:1 and MR:1
LEFT_LIT is ML:0 and MR:1
RIGHT_LIT is ML:1 and MR:0
'''

var _pre_prompt_ai:String ='''
If you are an AI, make the input command as such.
INPUT COMMAND:
``` 
CODE
```
'''


func emit_full_info():
	var full_info:String = _fixed_info + "\n"
	full_info += _updated_info + "\n" 
	full_info += _context_game_basic_goal_info + "\n" 
	full_info += _context_game_input_callback + "\n" 
	full_info += _pre_prompt_ai + "\n"
	on_full_info_as_text.emit(full_info)
	

func set_fixed_info(new_value:String) -> void:
	_fixed_info = new_value
	if _emit_on_any_change:
		emit_full_info()

func set_updated_info(new_value:String) -> void:
	_updated_info = new_value
	if _emit_on_any_change:
		emit_full_info()

func set_context_game_basic_goal_info(new_value:String) -> void:
	_context_game_basic_goal_info = new_value
	if _emit_on_any_change:
		emit_full_info()

func set_context_game_input_callback(new_value:String) -> void:
	_context_game_input_callback = new_value
	if _emit_on_any_change:
		emit_full_info()

func set_pre_prompt_ai(new_value:String) -> void:
	_pre_prompt_ai = new_value
	if _emit_on_any_change:
		emit_full_info()
