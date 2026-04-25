extends TileMapLayer

const BLOCOS = {
	"pedra":     { "vida": 4,  "drop": "Sheet01", "dx": 64,  "dy": 128 },
	"carvao":    { "vida": 5,  "drop": "Sheet02", "dx": 224, "dy": 160 },
	"cobre":     { "vida": 6,  "drop": "Sheet03", "dx": 160, "dy": 160 },
	"ferro":     { "vida": 8,  "drop": "Sheet01", "dx": 224, "dy": 96  },
	"ouro":      { "vida": 10, "drop": "Sheet01", "dx": 192, "dy": 96  },
	"esmeralda": { "vida": 12, "drop": "Sheet01", "dx": 224, "dy": 160 },
	"ametista":  { "vida": 14, "drop": "Sheet02", "dx": 128, "dy": 96  },
	"ruby":      { "vida": 16, "drop": "Sheet01", "dx": 224, "dy": 128 },
	"diamante":  { "vida": 20, "drop": "diamante_img", "dx": 0, "dy": 0 },
}


const SHEETS = {
	"Sheet01":      preload("res://assets/StewV_Minerals_Sheet_01T.png"),
	"Sheet02":      preload("res://assets/StewV_Minerals_Sheet_02T.png"),
	"Sheet03":      preload("res://assets/StewV_Minerals_Sheet_03T.png"),
	"props":        preload("res://assets/free_props_TileSheet.png"),
	"diamante_img": preload("res://assets/item551.png"),
}

var vida_blocos = {}

func receber_golpe(cell: Vector2i, ui: Node) -> void:
	var data = get_cell_tile_data(cell)
	if data == null:
		return

	var tipo = data.get_custom_data("tipo")
	if tipo == "" or tipo == "parede":
		return

	if not BLOCOS.has(tipo):
		return

	if not vida_blocos.has(cell):
		vida_blocos[cell] = BLOCOS[tipo]["vida"]

	vida_blocos[cell] -= 1
	print("Bloco ", tipo, " vida restante: ", vida_blocos[cell])

	if vida_blocos[cell] <= 0:
		_quebrar_bloco(cell, tipo, ui)

func _quebrar_bloco(cell: Vector2i, tipo: String, ui: Node) -> void:
	vida_blocos.erase(cell)
	erase_cell(cell)

	var info = BLOCOS[tipo]
	var icone: Texture2D

	if info["dx"] == 0 and info["dy"] == 0:
		icone = SHEETS[info["drop"]]
	else:
		var atlas = AtlasTexture.new()
		atlas.atlas = SHEETS[info["drop"]]
		atlas.region = Rect2(info["dx"], info["dy"], 32, 32)
		icone = atlas

	ui.adicionar_item(tipo, 1, icone)
	print("Dropou: ", tipo)
