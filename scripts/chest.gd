extends Node2D

signal on_area_entered(name, inventory)
signal on_area_exited(name)

const InventoryPrefab = preload("res://scenes/Inventory.tscn") 
const Inventory = preload("res://scripts/inventory/Inventory.gd")


var _inventory = InventoryPrefab.instance()

func _ready():
	_inventory.update_inventory_size(12)
	add_item(0)


func _on_area_body_entered(body):
	get_node("/root/Console").write_line("entered")
	emit_signal("on_area_entered", name, _inventory)

func _on_area_body_exited(body):
	emit_signal("on_area_exited", name)

func add_item(itemId):
	_inventory.add_item(Global.allItems[itemId])
	
