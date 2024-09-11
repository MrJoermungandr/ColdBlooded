# From Rostige Pipe
extends Control

@export var action := "ui_up"

@onready var label: Label = $Label
@onready var button: Button = $Button

#TODO properly expand this for controller support
func _ready() -> void:
	assert(InputMap.has_action(action))
	set_process_unhandled_key_input(false)
	display_current_key()
	label.text = action.capitalize()


func _toggled(is_button_pressed: bool) -> void:
	set_process_unhandled_key_input(is_button_pressed)
	if is_button_pressed:
		button.text = "<press a key>"
		modulate = Color.YELLOW
		release_focus()
	else:
		display_current_key()
		modulate = Color.WHITE
		# Grab focus after assigning a key, so that you can go to the next
		# key using the keyboard.
		set_focus_mode(Control.FOCUS_ALL)
		grab_focus()

# NOTE: You can use the `_input()` callback instead, especially if
# you want to work with gamepads.
func _input(event: InputEvent) -> void:
	if(not button.button_pressed):
		return
	# Skip if pressing Enter, so that the input mapping GUI can be navigated
	# with the keyboard. The downside of this approach is that the Enter
	# key can't be bound to actions.
	if event is InputEventKey and event.keycode != KEY_ENTER:
		remap_action_to(event)
		button.button_pressed = false
	elif event is InputEventMouseButton:
		remap_action_to(event)
		button.button_pressed = false


func remap_action_to(event: InputEvent) -> void:
	var old_event = try_get_input_event(event)
	if(old_event == null):
		push_error("No old Event found during remap")
	# We first change the event in this game instance.
	InputMap.action_erase_event(action, old_event)
	#InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	# And then save it to the keymaps file.
	KeyPersistence.keymaps[action] = event
	KeyPersistence.save_keymap()
	button.text = event.as_text()


func display_current_key() -> void:
	var action_events = InputMap.action_get_events(action)
	var event: InputEvent
	for i in action_events:
		if i.is_class("InputEventKey") or i.is_class("InputEventMouseButton"):
			event = i
	var current_key := event.as_text()
	button.text = current_key

func try_get_input_event(event: InputEvent):
	var action_events = InputMap.action_get_events(action)
	if (event is InputEventKey) or (event is InputEventMouseButton):
		for i in action_events:
			if i.is_class("InputEventKey") or i.is_class("InputEventMouseButton"):
				return i
		return null
	else:
		return null
