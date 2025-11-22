extends CharacterBody2D

# IMPORTANTE: Use valores ajustados para física Godot
@export var gravity := 980.0 
@export var jump_force := 450 
@export var glide_gravity := 100.0 
@export var max_fall_speed_gliding := 200.0 
@export var glide_delay := 0.2 # Opcional: tempo de espera para ativar o planeio após o pulo

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	
	var is_gliding = false
	var active_gravity = gravity # Assume a gravidade normal por PADRÃO
	
	# Reinicia a velocity.y no chão
	if is_on_floor():
		velocity.y = 0
	
	# Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_force 
		$jump_sound.play() 
		
	# --- Lógica de Planeio e Gravidade ---
	if not is_on_floor():
		
		# 1. VERIFICAÇÃO DO PLANEIO (Exceção)
		# O Planeio SÓ PODE ser ativado se a galinha:
		# a) Estiver fora do chão E
		# b) Estiver segurando o botão Jump E
		# c) A velocidade Y for positiva (>= 0), ou seja, JÁ ESTIVER CAINDO.
		if Input.is_action_pressed("Jump") and velocity.y >= 0:
			is_gliding = true
			active_gravity = glide_gravity
			
		# 2. APLICAÇÃO da Gravidade (Normal ou de Planeio)
		velocity.y += active_gravity * delta # Usa a gravidade (Normal na subida, Glide na queda)
		
		# 3. LIMITE de queda (apenas se estiver planando)
		if is_gliding:
			velocity.y = min(velocity.y, max_fall_speed_gliding)
			
	# -------------------------------------
	
	# Animation
	if not is_on_floor():
		if is_gliding:
			animation.play("Glide") 
		else:
			animation.play("Jump") 
	else:
		animation.play("Run")
	
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("danger"):
		var main = get_tree().get_current_scene()
		main.on_player_died()
		
	elif area.is_in_group("item"):
		var main = get_tree().get_current_scene()
		main.colect_item()
		area.queue_free()
		$bonus_sound.play()
