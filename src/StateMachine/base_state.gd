class_name BaseState
extends Node2D


export var animation_name: String

var character: KinematicBody2D


func enter(msg: Dictionary = {}) -> void:
	character.animations.play(animation_name)


func exit() -> void:
	pass


func input(event: InputEvent) -> BaseState:
	return null


func process(delta: float) -> BaseState:
	return null


func physics_process(delta: float) -> BaseState:
	return null
