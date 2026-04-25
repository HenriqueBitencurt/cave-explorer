extends CanvasLayer

const Slot = preload("res://scenes/slot.tscn")
const TAMANHO_HOTBAR = 9
const TAMANHO_INVENTARIO = 27

var inventario = []
var equipamentos = {
	"capacete": null,
	"peitoral": null,
	"calcas": null,
	"botas": null,
	"anel": null,
	"amuleto": null
}
var slot_selecionado = 0
var inventario_aberto = false

@onready var hotbar = $Control/Hotbar/HBoxContainer
@onready var painel_principal = $Control/PainelPrincipal
@onready var grid = $Control/PainelPrincipal/VBoxContainer/GridContainer
@onready var hotbar_copia = $Control/PainelPrincipal/VBoxContainer/HotbarCopia
@onready var painel_personagem_grid = $Control/PainelPrincipal/VBoxContainer/HBoxContainer/PainelPersonagem/GridContainer
@onready var lista_receitas = $Control/PainelPrincipal/VBoxContainer/HBoxContainer/PainelCrafting/VBoxContainer/ScrollContainer/ListaReceitas

func _ready():
	for i in TAMANHO_INVENTARIO:
		inventario.append(null)

	for i in TAMANHO_HOTBAR:
		var slot = Slot.instantiate()
		hotbar.add_child(slot)

	for i in 18:
		var slot = Slot.instantiate()
		grid.add_child(slot)

	for i in TAMANHO_HOTBAR:
		var slot = Slot.instantiate()
		hotbar_copia.add_child(slot)

	_criar_slots_equipamento()
	_aplicar_estilo_painel(painel_principal)

	painel_principal.visible = false
	await get_tree().process_frame
	_posicionar_hotbar()
	_atualizar_ui()

func _posicionar_hotbar():
	var hotbar_painel = $Control/Hotbar
	await get_tree().process_frame
	var tela = get_viewport().get_visible_rect().size
	var hotbar_size = hotbar_painel.size
	hotbar_painel.position = Vector2(
		(tela.x - hotbar_size.x) / 2,
		tela.y - hotbar_size.y - 8
	)

func _posicionar_painel_principal():
	await get_tree().process_frame
	var tela = get_viewport().get_visible_rect().size
	var painel_size = painel_principal.size
	painel_principal.position = Vector2(
		(tela.x - painel_size.x) / 2,
		(tela.y - painel_size.y) / 2
	)

func _criar_slots_equipamento():
	var ordem = ["", "capacete", "", "anel", "peitoral", "amuleto", "", "calcas", "", "", "botas", ""]
	for tipo in ordem:
		var slot = Slot.instantiate()
		painel_personagem_grid.add_child(slot)
		if tipo == "":
			slot.modulate = Color(0, 0, 0, 0)
			slot.mouse_filter = Control.MOUSE_FILTER_IGNORE
		else:
			var label = slot.get_node_or_null("Quantidade")
			if label:
				label.text = tipo.substr(0, 3).to_upper()
				label.visible = true

func _aplicar_estilo_painel(painel: Control):
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.25, 0.15, 0.08, 0.97)
	style.border_width_left = 3
	style.border_width_right = 3
	style.border_width_top = 3
	style.border_width_bottom = 3
	style.border_color = Color(0.7, 0.5, 0.15)
	style.corner_radius_top_left = 5
	style.corner_radius_top_right = 5
	style.corner_radius_bottom_left = 5
	style.corner_radius_bottom_right = 5
	painel.add_theme_stylebox_override("panel", style)

func _input(event):
	if event.is_action_pressed("inventario"):
		inventario_aberto = !inventario_aberto
		painel_principal.visible = inventario_aberto
		hotbar.get_parent().visible = !inventario_aberto
		if inventario_aberto:
			_posicionar_painel_principal()
		else:
			_posicionar_hotbar()
		_atualizar_ui()

	for i in range(9):
		if event.is_action_pressed("hotbar_" + str(i + 1)):
			slot_selecionado = i
			_atualizar_ui()

func adicionar_item(nome: String, quantidade: int, icone: Texture2D = null) -> bool:
	for i in TAMANHO_INVENTARIO:
		if inventario[i] != null and inventario[i].nome == nome:
			inventario[i].quantidade += quantidade
			_atualizar_ui()
			return true

	for i in TAMANHO_INVENTARIO:
		if inventario[i] == null:
			inventario[i] = {
				"nome": nome,
				"quantidade": quantidade,
				"icone": icone
			}
			_atualizar_ui()
			return true

	return false

func remover_item(slot_index: int, quantidade: int = 1):
	if inventario[slot_index] == null:
		return
	inventario[slot_index].quantidade -= quantidade
	if inventario[slot_index].quantidade <= 0:
		inventario[slot_index] = null
	_atualizar_ui()

func get_item_selecionado():
	return inventario[slot_selecionado]

func _atualizar_ui():
	for i in TAMANHO_HOTBAR:
		if i >= hotbar.get_child_count():
			break
		_configurar_slot(hotbar.get_child(i), inventario[i], i == slot_selecionado)

	if inventario_aberto:
		for i in 18:
			if i >= grid.get_child_count():
				break
			_configurar_slot(grid.get_child(i), inventario[TAMANHO_HOTBAR + i], false)

		for i in TAMANHO_HOTBAR:
			if i >= hotbar_copia.get_child_count():
				break
			_configurar_slot(hotbar_copia.get_child(i), inventario[i], i == slot_selecionado)

func _configurar_slot(slot: Control, item, selecionado: bool):
	var icone = slot.get_node_or_null("MarginContainer/Icone")
	var label = slot.get_node_or_null("Quantidade")

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.13, 0.08)
	style.corner_radius_top_left = 3
	style.corner_radius_top_right = 3
	style.corner_radius_bottom_left = 3
	style.corner_radius_bottom_right = 3

	if selecionado:
		style.border_width_left = 3
		style.border_width_right = 3
		style.border_width_top = 3
		style.border_width_bottom = 3
		style.border_color = Color(1.0, 0.85, 0.2)
		style.bg_color = Color(0.3, 0.2, 0.1)
	else:
		style.border_width_left = 2
		style.border_width_right = 2
		style.border_width_top = 2
		style.border_width_bottom = 2
		style.border_color = Color(0.6, 0.45, 0.2)

	slot.add_theme_stylebox_override("panel", style)

	if item == null:
		if icone:
			icone.visible = false
			icone.texture = null
		if label:
			label.visible = false
	else:
		if icone:
			icone.texture = item.icone
			icone.visible = true
		if label:
			label.visible = item.quantidade > 1
			label.text = str(item.quantidade)
