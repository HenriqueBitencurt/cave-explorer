extends Control

@onready var lista_personagens = $CenterContainer/VBoxContainer/ScrollContainer/ListaPersonagens
@onready var btn_jogar = $CenterContainer/VBoxContainer/BotoesInferiores/BtnJogar

var personagem_selecionado_slot := -1

func _ready():
	btn_jogar.disabled = true
	aplicar_estilo_ui()
	carregar_lista()

func carregar_lista():
	for child in lista_personagens.get_children():
		lista_personagens.remove_child(child)
		child.queue_free()

	var personagens = PlayerData.carregar_todos()
	print("Personagens encontrados: ", personagens.size())

	if personagens.size() == 0:
		var label = Label.new()
		label.text = "Nenhum personagem criado ainda."
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_color_override("font_color", Color(0.95, 0.90, 0.75))
		lista_personagens.add_child(label)
		return

	for i in personagens.size():
		var slot = criar_slot(personagens[i], i)
		lista_personagens.add_child(slot)

func criar_slot(dados: Dictionary, indice: int) -> PanelContainer:
	var slot = PanelContainer.new()
	var style = StyleBoxTexture.new()
	style.texture = load("res://assets/UI/RectangleBox_96x96.png")
	style.texture_margin_left = 8
	style.texture_margin_right = 8
	style.texture_margin_top = 8
	style.texture_margin_bottom = 8
	slot.add_theme_stylebox_override("panel", style)

	var hbox = HBoxContainer.new()
	slot.add_child(hbox)

	var label = Label.new()
	label.text = dados["nome"]
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_color_override("font_color", Color(0.95, 0.90, 0.75))
	hbox.add_child(label)

	var btn_sel = Button.new()
	btn_sel.text = "Selecionar"
	btn_sel.pressed.connect(_on_slot_selecionado.bind(indice))
	hbox.add_child(btn_sel)

	var btn_del = Button.new()
	btn_del.text = "Deletar"
	btn_del.pressed.connect(_on_deletar.bind(indice))
	hbox.add_child(btn_del)

	return slot

func _on_slot_selecionado(indice: int):
	personagem_selecionado_slot = indice
	PlayerData.carregar_personagem(indice)
	btn_jogar.disabled = false

func _on_deletar(indice: int):
	PlayerData.deletar_personagem(indice)
	personagem_selecionado_slot = -1
	btn_jogar.disabled = true
	carregar_lista()

func aplicar_estilo_ui():
	var bg = $BackgroundEscuro
	bg.color = Color(0.71, 0.66, 0.60)

	var titulo = $CenterContainer/VBoxContainer/LabelTitulo
	titulo.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	titulo.add_theme_color_override("font_color", Color(0.95, 0.90, 0.75))

	var btn_novo_style = StyleBoxTexture.new()
	btn_novo_style.texture = load("res://assets/UI/HighlightButton_60x23.png")
	btn_novo_style.texture_margin_left = 6
	btn_novo_style.texture_margin_right = 6
	btn_novo_style.texture_margin_top = 4
	btn_novo_style.texture_margin_bottom = 4

	var btn_novo = $CenterContainer/VBoxContainer/BotoesInferiores/BtnNovoPersonagem
	btn_novo.add_theme_stylebox_override("normal", btn_novo_style)
	btn_novo.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))
	btn_jogar.add_theme_stylebox_override("normal", btn_novo_style)
	btn_jogar.add_theme_color_override("font_color", Color(0.9, 0.8, 0.5))

func _on_btn_novo_personagem_pressed():
	PlayerData.resetar()
	get_tree().change_scene_to_file("res://scenes/character_creation.tscn")

func _on_btn_jogar_pressed():
	if personagem_selecionado_slot == -1:
		return
	get_tree().change_scene_to_file("res://scenes/world.tscn")