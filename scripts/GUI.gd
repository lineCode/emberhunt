"""

"""
extends Control

onready var debugLabel = $CanvasLayer/debugLabel 
onready var fpsLabel = $CanvasLayer/FPS

export(NodePath) var playerNode = "../player"

onready var inventorySystem = $CanvasLayer/inventorySystem
var playerBody : KinematicBody2D = null

func _ready():
	set_process_input(true)
	inventorySystem.hide()
	playerBody = get_node("../player").get_child(0)
	
	$CanvasLayer/moveButton.init(playerBody)
	$CanvasLayer/shootButton.init(playerBody.get_node("weapon"))


func _input(event):
	if event is InputEventKey and event.scancode == KEY_I and event.is_pressed() and not event.echo:
		inventorySystem.visible = ! inventorySystem.visible
		get_node("CanvasLayer/moveButton").disabled = inventorySystem.visible
		get_node("CanvasLayer/shootButton").disabled = inventorySystem.visible
		
		
func _process(delta):
	debugLabel.set_text(str(playerBody.get_position()))
	if delta != 0:
		fpsLabel.set_text("FPS: "+str(round(1/delta)))
	

func _on_TouchScreenButton_pressed():
	if not Global.paused:
		Global.paused = true
		SoundPlayer.play(preload("res://assets/sounds/click.wav"))
		var scene = preload("res://scenes/PauseMenu.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("PauseMenu")
		$CanvasLayer.add_child(scene_instance)
		# Disable touchpads
		get_node("CanvasLayer/moveButton").disabled = true
		get_node("CanvasLayer/moveButton").isPressed = false
		get_node("CanvasLayer/moveButton")._playerBody.direction = 0
		get_node("CanvasLayer/moveButton")._playerBody.speed = 0
		get_node("CanvasLayer/moveButton/buttonSprite").global_position = get_node("CanvasLayer/moveButton").origin
		get_node("CanvasLayer/moveButton/buttonSprite").hide()
		get_node("CanvasLayer/moveButton/background").hide()
		get_node("CanvasLayer/shootButton").disabled = true
		get_node("CanvasLayer/shootButton").isPressed = false
		get_node("CanvasLayer/shootButton")._weaponNode.rotation = 0
		get_node("CanvasLayer/shootButton")._weaponNode.attacking = false
		get_node("CanvasLayer/shootButton/buttonSprite").global_position = get_node("CanvasLayer/shootButton").origin
		get_node("CanvasLayer/shootButton/buttonSprite").hide()
		get_node("CanvasLayer/shootButton/background").hide()


func _on_toggleInventory_pressed():
	inventorySystem.visible = ! inventorySystem.visible
	# Disable touchpads
	get_node("CanvasLayer/moveButton").disabled = inventorySystem.visible
	get_node("CanvasLayer/moveButton").isPressed = ! inventorySystem.visible
	get_node("CanvasLayer/moveButton")._playerBody.direction = 0
	get_node("CanvasLayer/moveButton")._playerBody.speed = 0
	get_node("CanvasLayer/moveButton/buttonSprite").hide()
	get_node("CanvasLayer/moveButton/background").hide()
	get_node("CanvasLayer/shootButton").disabled = inventorySystem.visible
	get_node("CanvasLayer/shootButton").isPressed = ! inventorySystem.visible
	get_node("CanvasLayer/shootButton")._weaponNode.rotation = 0
	get_node("CanvasLayer/shootButton")._weaponNode.attacking = false
	get_node("CanvasLayer/shootButton/buttonSprite").hide()
	get_node("CanvasLayer/shootButton/background").hide()
