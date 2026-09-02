class_name Dash extends State

func enter() -> void:
	var movement := player.movement_component
	var input := player.input_component
	if movement.body.velocity.y >= 0.0:
		player.movement_component.stop_vertical()
		
	movement.can_dash = false
	movement.dash(input.move_dir.x)
	
func physics_update(delta: float) -> void:
	var input := player.input_component
	var movement := player.movement_component
	
	player.play_animation("dash")
	movement.apply_gravityx(delta)
	
	if movement.can_climb and input.up_pressed:
		state_machine.transition_to("Climbing")
		return
	
	if abs(movement.body.velocity.x) <= movement.speed * 0.4:
		state_machine.transition_to("Falling")
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
