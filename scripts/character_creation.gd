extends Control

# Referências aos labels
@onready var label_corpo = $CenterContainer/HBoxContainer/PainelOpcoes/LinhaCorpo/LabelCorpo
@onready var label_cabelo = $CenterContainer/HBoxContainer/PainelOpcoes/LinhaCabelo/LabelCabelo
@onready var label_cor = $CenterContainer/HBoxContainer/PainelOpcoes/LinhaCorCabelo/LabelCor
@onready var label_roupa = $CenterContainer/HBoxContainer/PainelOpcoes/LinhaRoupa/LabelRoupa
@onready var label_acess = $CenterContainer/HBoxContainer/PainelOpcoes/LinhaAcess/LabelAcess

# Referência ao personagem no SubViewport
@onready var sub_viewport = $CenterContainer/HBoxContainer/PreviewPersonagem/SubViewport
var appearance_node: Node = null

func _ready():
	# Carregar o player no SubViewport
	var player_scene = load("res://scenes/player.tscn")
	var player = player_scene.instantiate()
	sub_viewport.add_child(player)
	appearance_node = player
	atualizar_labels()

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

# ── JOGAR ──
func _on_btn_jogar_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
