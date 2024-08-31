extends Resource
class_name GameSave

#has to be a dictorary of Array[LevelRun] but sadly no typed dicts yet
@export_storage
var runs: Dictionary

#TODO maybe player coins and unlocks if we have those
