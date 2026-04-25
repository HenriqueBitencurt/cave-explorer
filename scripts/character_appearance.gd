extends Node

# Caminho base dos assets
const BASE_PATH = "res://assets/personagem/separate/"

# Frames e linhas por animação (já mapeados)
const FRAMES_POR_ANIM = {
	"walk": 8, "axe": 5, "sword": 4, "pickaxe": 5,
	"hoe": 5, "fish": 5, "carry": 8, "pickup": 5,
	"jump": 5, "hurt": 1, "die": 2, "water": 2, "block": 1
}
const LINHAS_POR_ANIM = {
	"walk": 4, "axe": 4, "sword": 4, "pickaxe": 4,
	"hoe": 4, "fish": 4, "carry": 4, "pickup": 4,
	"jump": 4, "hurt": 4, "die": 1, "water": 4, "block": 4
}

const FRAME_SIZE = 32  # cada frame tem 32x32 pixels
const NUM_CORES_CABELO = 14

# Referências aos sprites do personagem
@onready var corpo: AnimatedSprite2D = $corpo
@onready var cabelo: AnimatedSprite2D = $cabelo
@onready var roupa: AnimatedSprite2D = $roupa
@onready var olhos: AnimatedSprite2D = $olhos
@onready var acessorio: AnimatedSprite2D = $acessorio

func _ready():
	aplicar_aparencia()

func aplicar_aparencia():
	aplicar_corpo()
	aplicar_cabelo()
	aplicar_roupa()
	aplicar_olhos()
	aplicar_acessorio()

# ─── CORPO ───────────────────────────────────────────────
func aplicar_corpo():
	var nome = PlayerData.CORPOS[PlayerData.corpo_index]
	var frames = SpriteFrames.new()
	for anim in FRAMES_POR_ANIM.keys():
		var path = BASE_PATH + anim + "/" + nome + "_" + anim + ".png"
		var tex = load(path)
		if tex == null:
			continue
		frames.add_animation(anim)
		frames.set_animation_speed(anim, 8.0)
		var cols = FRAMES_POR_ANIM[anim]
		var rows = LINHAS_POR_ANIM[anim]
		for row in rows:
			for col in cols:
				var atlas = AtlasTexture.new()
				atlas.atlas = tex
				atlas.region = Rect2(col * FRAME_SIZE, row * FRAME_SIZE, FRAME_SIZE, FRAME_SIZE)
				frames.add_frame(anim, atlas)
	corpo.sprite_frames = frames
	corpo.play("walk")

# ─── CABELO ──────────────────────────────────────────────
func aplicar_cabelo():
	var nome = PlayerData.CABELOS[PlayerData.cabelo_index]
	var cor = PlayerData.cor_cabelo_index
	var frames = SpriteFrames.new()
	for anim in FRAMES_POR_ANIM.keys():
		var path = BASE_PATH + anim + "/hair/" + nome + "_" + anim + ".png"
		var tex = load(path)
		if tex == null:
			continue
		frames.add_animation(anim)
		frames.set_animation_speed(anim, 8.0)
		var cols = FRAMES_POR_ANIM[anim]
		var rows = LINHAS_POR_ANIM[anim]
		# offset horizontal da cor escolhida
		var offset_x = cor * cols * FRAME_SIZE
		for row in rows:
			for col in cols:
				var atlas = AtlasTexture.new()
				atlas.atlas = tex
				atlas.region = Rect2(offset_x + col * FRAME_SIZE, row * FRAME_SIZE, FRAME_SIZE, FRAME_SIZE)
				frames.add_frame(anim, atlas)
	cabelo.sprite_frames = frames
	cabelo.play("walk")

# ─── ROUPA ───────────────────────────────────────────────
func aplicar_roupa():
	var nome = PlayerData.ROUPAS[PlayerData.roupa_index]
	var frames = SpriteFrames.new()
	for anim in FRAMES_POR_ANIM.keys():
		var path = BASE_PATH + anim + "/clothes/" + nome + "_" + anim + ".png"
		var tex = load(path)
		if tex == null:
			continue
		frames.add_animation(anim)
		frames.set_animation_speed(anim, 8.0)
		var cols = FRAMES_POR_ANIM[anim]
		var rows = LINHAS_POR_ANIM[anim]
		for row in rows:
			for col in cols:
				var atlas = AtlasTexture.new()
				atlas.atlas = tex
				atlas.region = Rect2(col * FRAME_SIZE, row * FRAME_SIZE, FRAME_SIZE, FRAME_SIZE)
				frames.add_frame(anim, atlas)
	roupa.sprite_frames = frames
	roupa.play("walk")

# ─── OLHOS ───────────────────────────────────────────────
func aplicar_olhos():
	var frames = SpriteFrames.new()
	for anim in FRAMES_POR_ANIM.keys():
		var path = BASE_PATH + anim + "/eyes/eyes_" + anim + ".png"
		var tex = load(path)
		if tex == null:
			continue
		frames.add_animation(anim)
		frames.set_animation_speed(anim, 8.0)
		var cols = FRAMES_POR_ANIM[anim]
		var rows = LINHAS_POR_ANIM[anim]
		for row in rows:
			for col in cols:
				var atlas = AtlasTexture.new()
				atlas.atlas = tex
				atlas.region = Rect2(col * FRAME_SIZE, row * FRAME_SIZE, FRAME_SIZE, FRAME_SIZE)
				frames.add_frame(anim, atlas)
	olhos.sprite_frames = frames
	olhos.play("walk")

# ─── ACESSÓRIO ───────────────────────────────────────────
func aplicar_acessorio():
	var nome = PlayerData.ACESSORIOS[PlayerData.acessorio_index]
	if nome == "none":
		acessorio.visible = false
		return
	acessorio.visible = true
	var frames = SpriteFrames.new()
	for anim in FRAMES_POR_ANIM.keys():
		var path = BASE_PATH + anim + "/acc/" + nome + "_" + anim + ".png"
		var tex = load(path)
		if tex == null:
			continue
		frames.add_animation(anim)
		frames.set_animation_speed(anim, 8.0)
		var cols = FRAMES_POR_ANIM[anim]
		var rows = LINHAS_POR_ANIM[anim]
		for row in rows:
			for col in cols:
				var atlas = AtlasTexture.new()
				atlas.atlas = tex
				atlas.region = Rect2(col * FRAME_SIZE, row * FRAME_SIZE, FRAME_SIZE, FRAME_SIZE)
				frames.add_frame(anim, atlas)
	acessorio.sprite_frames = frames
	acessorio.play("walk")
