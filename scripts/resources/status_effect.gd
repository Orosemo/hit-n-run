extends Resource
class_name StatusEffect

@export_enum("poison", "shock", "frost", "decay", "fire", "regeneration", "sleep", "confusion", "slowness", "speed", "weakness", "strenght") var id
@export var amount: float
@export var strenght: float
@export var active := false
var sprite: String
var capacity: float
var executed = false