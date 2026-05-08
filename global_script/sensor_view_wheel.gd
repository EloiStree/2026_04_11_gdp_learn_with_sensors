extends Node


@export var degree_per_seconds_max_speed: float = 720.0
@export var diameter_of_wheels_in_millimeters: float = 33.2


@export_range(-1.0,1.0,0.01) var motor_percent_power: float = 0.0
