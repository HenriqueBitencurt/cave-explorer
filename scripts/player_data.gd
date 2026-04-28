extends Node

# Índices das escolhas do jogador
var corpo_index := 0
var cabelo_index := 0
var cor_cabelo_index := 0
var roupa_index := 0
var acessorio_index := 0
var nome_personagem: String = ""

# Personagem atualmente selecionado (índice na lista)
var personagem_selecionado := -1

# Nomes dos corpos
const CORPOS = [
	"char1", "char2", "char3", "char4",
	"char5", "char6", "char7", "char8"
]

# Nomes dos cabelos
const CABELOS = [
	"bob", "braids", "buzzcut", "curly", "emo",
	"extra_long", "french_curl", "gentleman",
	"long_straight", "midiwave", "ponytail",
	"spacebuns", "wavy"
]

# Nomes das roupas
const ROUPAS = [
	"basic", "clown", "dress", "floral", "overalls",
	"pants", "pants_suit", "pumpkin", "sailor",
	"shoes", "skirt", "skull", "spaghetti",
	"spooky", "sporty", "stripe", "suit", "witch"
]

# Nomes dos acessórios
const ACESSORIOS = [
	"none", "beard", "earring_emerald", "earring_red",
	"glasses", "glasses_sun", "hat_cowboy", "hat_lucky",
	"hat_pumpkin", "hat_witch", "mask_clown_blue",
	"mask_clown_red", "mask_spooky"
]

# Frames por animação
const FRAMES_POR_ANIM = {
	"walk": 8, "axe": 5, "sword": 4, "pickaxe": 5,
	"hoe": 5, "fish": 5, "carry": 8, "pickup": 5,
	"jump": 5, "hurt": 1, "die": 2, "water": 2, "block": 1
}

# Linhas por animação
const LINHAS_POR_ANIM = {
	"walk": 4, "axe": 4, "sword": 4, "pickaxe": 4,
	"hoe": 4, "fish": 4, "carry": 4, "pickup": 4,
	"jump": 4, "hurt": 4, "die": 1, "water": 4, "block": 4
}

const SAVE_PATH = "user://personagens.json"
const MAX_PERSONAGENS = 6

# ── SALVAR ──
func salvar_personagem():
	var personagens = carregar_todos()

	var novo = {
		"nome": nome_personagem,
		"corpo": corpo_index,
		"cabelo": cabelo_index,
		"cor_cabelo": cor_cabelo_index,
		"roupa": roupa_index,
		"acessorio": acessorio_index
	}

	if personagem_selecionado >= 0 and personagem_selecionado < personagens.size():
		# Editando personagem existente
		personagens[personagem_selecionado] = novo
	else:
		# Novo personagem
		personagens.append(novo)

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(personagens))
	file.close()

# ── CARREGAR TODOS ──
func carregar_todos() -> Array:
	if not FileAccess.file_exists(SAVE_PATH):
		return []
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var texto = file.get_as_text()
	file.close()
	var resultado = JSON.parse_string(texto)
	if resultado is Array:
		return resultado
	return []

# ── CARREGAR UM PERSONAGEM ──
func carregar_personagem(indice: int):
	var personagens = carregar_todos()
	if indice < 0 or indice >= personagens.size():
		return
	var p = personagens[indice]
	nome_personagem = p["nome"]
	corpo_index = p["corpo"]
	cabelo_index = p["cabelo"]
	cor_cabelo_index = p["cor_cabelo"]
	roupa_index = p["roupa"]
	acessorio_index = p["acessorio"]
	personagem_selecionado = indice

# ── DELETAR ──
func deletar_personagem(indice: int):
	var personagens = carregar_todos()
	if indice < 0 or indice >= personagens.size():
		return
	personagens.remove_at(indice)
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(personagens))
	file.close()

# ── RESETAR PARA NOVO PERSONAGEM ──
func resetar():
	nome_personagem = ""
	corpo_index = 0
	cabelo_index = 0
	cor_cabelo_index = 0
	roupa_index = 0
	acessorio_index = 0
	personagem_selecionado = -1