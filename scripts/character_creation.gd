extends Control

@onready var label_corpo = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCorpo/LabelCorpo
@onready var label_cabelo = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCabelo/LabelCabelo
@onready var label_cor = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCorCabelo/LabelCor
@onready var label_roupa = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaRoupa/LabelRoupa
@onready var label_acess = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaAcess/LabelAcess
@onready var input_nome = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/InputNome

@onready var sub_viewport = $CenterContainer/HBoxContainer/PreviewBox/PreviewPersonagem/SubViewport
var appearance_node: Node = null

func _ready():
	sub_viewport.size = Vector2(200, 200)
	var player_scene = load("res://scenes/player.tscn")
	var player = player_scene.instantiate()
	sub_viewport.add_child(player)
	appearance_node = player
	atualizar_labels()
	aplicar_estilo_ui()

	var camera = sub_viewport.get_node("player/Camera2D")
	if camera:
		camera.offset = Vector2(0, -48)

	var preview = $CenterContainer/HBoxContainer/PreviewBox
	var preview_style = StyleBoxTexture.new()
	preview_style.texture = load("res://assets/UI/RectangleBox_96x96.png")
	preview_style.texture_margin_left = 10
	preview_style.texture_margin_right = 10
	preview_style.texture_margin_top = 10
	preview_style.texture_margin_bottom = 10
	preview.add_theme_stylebox_override("panel", preview_style)

func atualizar_labels():
	label_corpo.text = "Corpo " + str(PlayerData.corpo_index + 1)
	label_cabelo.text = "Cabelo " + str(PlayerData.cabelo_index + 1)
	label_cor.text = "Cor " + str(PlayerData.cor_cabelo_index + 1)
	label_roupa.text = "Roupa " + str(PlayerData.roupa_index + 1)
	label_acess.text = "Acessório " + str(PlayerData.acessorio_index)

func atualizar_personagem():
	if appearance_node:
		appearance_node.aplicar_aparencia()
	atualizar_labels()

func aplicar_estilo_ui():
	var painel = $CenterContainer/HBoxContainer/PainelOpcoes
	var painel_style = StyleBoxTexture.new()
	painel_style.texture = load("res://assets/UI/RectangleBox_96x96.png")
	painel_style.texture_margin_left = 10
	painel_style.texture_margin_right = 10
	painel_style.texture_margin_top = 10
	painel_style.texture_margin_bottom = 10
	painel.add_theme_stylebox_override("panel", painel_style)

	var seta_esq = load("res://assets/UI/LeftArrowButton_7x10.png")
	var seta_dir = load("res://assets/UI/RightArrowButton_7x10.png")
	var btn_vazio = StyleBoxEmpty.new()

	var btns_prev = [
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCorpo/BtnCorpoPrev,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCabelo/BtnCabeloPrev,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCorCabelo/BtnCorPrev,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaRoupa/BtnRoupaPrev,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaAcess/BtnAcessPrev,
	]
	var btns_next = [
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCorpo/BtnCorpoNext,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCabelo/BtnCabeloNext,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaCorCabelo/BtnCorNext,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaRoupa/BtnRoupaNext,
		$CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LinhaAcess/BtnAcessNext,
	]

	for btn in btns_prev:
		btn.text = ""
		btn.icon = seta_esq
		btn.add_theme_stylebox_override("normal", btn_vazio)
		btn.add_theme_stylebox_override("hover", btn_vazio)
		btn.add_theme_stylebox_override("pressed", btn_vazio)

	for btn in btns_next:
		btn.text = ""
		btn.icon = seta_dir
		btn.add_theme_stylebox_override("normal", btn_vazio)
		btn.add_theme_stylebox_override("hover", btn_vazio)
		btn.add_theme_stylebox_override("pressed", btn_vazio)

	var btn_jogar = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/BtnJogar
	var jogar_style = StyleBoxTexture.new()
	jogar_style.texture = load("res://assets/UI/HighlightButton_60x23.png")
	jogar_style.texture_margin_left = 6
	jogar_style.texture_margin_right = 6
	jogar_style.texture_margin_top = 4
	jogar_style.texture_margin_bottom = 4
	btn_jogar.add_theme_stylebox_override("normal", jogar_style)
	btn_jogar.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))

	var labels = [label_corpo, label_cabelo, label_cor, label_roupa, label_acess]
	for label in labels:
		label.add_theme_color_override("font_color", Color(0.95, 0.90, 0.75))

	var titulo = $CenterContainer/HBoxContainer/PainelOpcoes/VBoxContainer/LabelTitulo
	titulo.add_theme_color_override("font_color", Color(0.95, 0.90, 0.75))

# ── CORPO ──
func _on_btn_corpo_prev_pressed():
	PlayerData.corpo_index = wrapi(PlayerData.corpo_index - 1, 0, PlayerData.CORPOS.size())
	atualizar_personagem()

func _on_btn_corpo_next_pressed():
	PlayerData.corpo_index = wrapi(PlayerData.corpo_index + 1, 0, PlayerData.CORPOS.size())
	atualizar_personagem()

# ── CABELO ──
func _on_btn_cabelo_prev_pressed():
	PlayerData.cabelo_index = wrapi(PlayerData.cabelo_index - 1, 0, PlayerData.CABELOS.size())
	atualizar_personagem()

func _on_btn_cabelo_next_pressed():
	PlayerData.cabelo_index = wrapi(PlayerData.cabelo_index + 1, 0, PlayerData.CABELOS.size())
	atualizar_personagem()

# ── COR DO CABELO ──
func _on_btn_cor_prev_pressed():
	PlayerData.cor_cabelo_index = wrapi(PlayerData.cor_cabelo_index - 1, 0, 14)
	atualizar_personagem()

func _on_btn_cor_next_pressed():
	PlayerData.cor_cabelo_index = wrapi(PlayerData.cor_cabelo_index + 1, 0, 14)
	atualizar_personagem()

# ── ROUPA ──
func _on_btn_roupa_prev_pressed():
	PlayerData.roupa_index = wrapi(PlayerData.roupa_index - 1, 0, PlayerData.ROUPAS.size())
	atualizar_personagem()

func _on_btn_roupa_next_pressed():
	PlayerData.roupa_index = wrapi(PlayerData.roupa_index + 1, 0, PlayerData.ROUPAS.size())
	atualizar_personagem()

# ── ACESSÓRIO ──
func _on_btn_acess_prev_pressed():
	PlayerData.acessorio_index = wrapi(PlayerData.acessorio_index - 1, 0, PlayerData.ACESSORIOS.size())
	atualizar_personagem()

func _on_btn_acess_next_pressed():
	PlayerData.acessorio_index = wrapi(PlayerData.acessorio_index + 1, 0, PlayerData.ACESSORIOS.size())
	atualizar_personagem()

# ── CRIAR PERSONAGEM ──
func _on_btn_jogar_pressed():
	var nome = input_nome.text.strip_edges()
	if nome == "":
		input_nome.placeholder_text = "⚠ Digite um nome!"
		return
	PlayerData.nome_personagem = nome
	PlayerData.salvar_personagem()
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")
