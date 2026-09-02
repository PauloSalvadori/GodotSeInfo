class_name FallingState extends State


func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component
	
	player.play_animation("jump")
	movement.move_horizontal(input.move_dir.x)
	movement.apply_gravity(delta)
	
	if input.up_just_pressed and movement.can_dash == true:
		state_machine.transition_to("Dash")
		return
	
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return
		
	if player.is_on_floor():
		movement.can_dash = true
		if input.move_dir.x != 0.0:
			if input.run_pressed:
				state_machine.transition_to("Running")
			else:
				state_machine.transition_to("Walking")
		else:
			state_machine.transition_to("Idle")
			
		return
		
	movement.move_and_slide()
