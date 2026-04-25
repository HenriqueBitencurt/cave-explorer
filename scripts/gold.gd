extends StaticBody2D

func receber_dano(ui):
	var atlas = AtlasTexture.new()
	atlas.atlas = preload("res://assets/free_props_TileSheet.png")
	atlas.region = Rect2(80, 112, 16, 16)
	ui.adicionar_item("Ouro", 1, atlas)
	queue_free()
