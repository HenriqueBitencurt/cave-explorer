extends CharacterBody2D

const SPEED = 100.0

@onready var anim: AnimatedSprite2D = $sprite2d
@onready var ui = $"../CanvasLayer"
@onready var mapa = $"../blocos"
@onready var pickaxe_area = $PickaxeArea

var ultima_direcao := "down"

func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	velocity = direction.normalized() * SPEED
	move_and_slide()
	_update_animation(direction)

	if Input.is_action_just_pressed("minerar"):
		_tentar_minerar()

func _tentar_minerar():
	# Minera no TileMap
	var direcao = _get_direcao_mineracao()
	var pos_alvo = global_position + direcao * 32
	var cell = mapa.local_to_map(mapa.to_local(pos_alvo))
	mapa.receber_golpe(cell, ui)

	# Minera StaticBody2D (ouro antigo)
	for corpo in pickaxe_area.get_overlapping_bodies():
		if corpo.has_method("receber_dano"):
			corpo.receber_dano(ui)

func _get_direcao_mineracao() -> Vector2:
	match ultima_direcao:
		"down":  return Vector2.DOWN
		"up":    return Vector2.UP
		"right": return Vector2.RIGHT
		"left":  return Vector2.LEFT
	return Vector2.DOWN

func _update_animation(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		var idle_anim := "idle_" + ultima_direcao
		if anim.animation != idle_anim:
			anim.play(idle_anim)
		return

	var nova_anim := ""

	if dir.y > 0 and abs(dir.y) >= abs(dir.x):
		nova_anim = "walk_down"
		ultima_direcao = "down"
	elif dir.y < 0 and abs(dir.y) >= abs(dir.x):
		nova_anim = "walk_up"
		ultima_direcao = "up"
	elif dir.x > 0:
		nova_anim = "walk_right"
		ultima_direcao = "right"
	elif dir.x < 0:
		nova_anim = "walk_left"
		ultima_direcao = "left"

	if nova_anim != "" and anim.animation != nova_anim:
		anim.play(nova_anim)
