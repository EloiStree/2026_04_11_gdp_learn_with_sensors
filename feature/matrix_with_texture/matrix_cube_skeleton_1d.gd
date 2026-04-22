class_name MatrixCubeSkeleton1D
extends Node3D

@export var skeleton: Skeleton3D

@export var base_scale_at_ready: float = 1.0
@export var use_random_at_ready: bool = true

func _ready():
	if skeleton == null:
		push_error("Skeleton not assigned.")
		return

	for i in range(skeleton.get_bone_count()):
		var pose: Transform3D = skeleton.get_bone_pose(i)

		# var index_scale = 1.0 + (i * index_influence)
		# var rand_scale = randf_range(-random_range, random_range)
		# var final_scale = base_scale * index_scale * (1.0 + rand_scale)
		var final_scale = base_scale_at_ready
		if use_random_at_ready:
			final_scale = randf_range(0,base_scale_at_ready)


		# preserve rotation
		var rotation = pose.basis.get_rotation_quaternion()
		var scale = pose.basis.get_scale() * final_scale

		var new_basis = Basis(rotation).scaled(scale)

		pose.basis = new_basis
		skeleton.set_bone_pose(i, pose)
