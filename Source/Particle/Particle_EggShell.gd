extends GPUParticles2D

func setID(ID:int):
	process_material.anim_offset_min=1/80.0*ID
	process_material.anim_offset_max=1/80.0*ID
	emitting=true
