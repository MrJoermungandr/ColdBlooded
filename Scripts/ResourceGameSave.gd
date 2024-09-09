extends Resource
class_name GameSave

#has to be a dictorary of LevelRun but sadly no typed dicts yet
@export_storage
var runs: Dictionary

@export_storage
var has_been_annoying=false

@export_storage
var has_been_logged_in=false

@export_storage
var jwt:String=""


#TODO maybe player coins and unlocks if we have those
