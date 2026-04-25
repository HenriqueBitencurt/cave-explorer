extends Node

# Índices das escolhas do jogador
var corpo_index := 0        # 0 a 7 (char1 a char8)
var cabelo_index := 0       # 0 a 12 (bob, braids, buzzcut...)
var cor_cabelo_index := 0   # 0 a 13 (14 cores disponíveis)
var roupa_index := 0        # 0 a 17
var acessorio_index := 0    # 0 = nenhum, 1+

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

# Nomes dos acessórios (none = sem acessório)
const ACESSORIOS = [
	"none", "beard", "earring_emerald", "earring_red",
	"glasses", "glasses_sun", "hat_cowboy", "hat_lucky",
	"hat_pumpkin", "hat_witch", "mask_clown_blue",
	"mask_clown_red", "mask_spooky"
]

# Frames por animação (quantas colunas tem cada anim)
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
