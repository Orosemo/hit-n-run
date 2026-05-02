extends Node
class_name StatusEffects

@export var effect_container: EffectContainer

@export_category("needed components")
@export var health_component: Health
@export var velocity: Velocity

var current_status_effects = {}

var tick_timer

func set_effect(type: int, max_duration:float, strengh: int):
    effect_container.manage_effect(type, max_duration, max_duration)
    if current_status_effects[type]:
        current_status_effects[type]["current_duration"] += max_duration
    else: 
        current_status_effects[type]["current_duration"] = max_duration
        current_status_effects[type]["duration"] = max_duration
        current_status_effects[type]["type"] = type
        current_status_effects[type]["strengh"] = strengh

func execute_effects(effect):
    # reset effects
    velocity.shock = false

    # execute effects
    match effect["type"]:
        GlobalVars.FIRE:
            health_component.damage(effect["strengh"])
        GlobalVars.POISON:
            if health_component.get_health() - effect["strengh"] > 0:
                health_component.damage(effect["strengh"])
            else:
                health_component.set_health(effect["strengh"])
        GlobalVars.DEATH:
            health_component.damage(effect["strengh"])
        GlobalVars.REGENERATION:
            health_component.heal(effect["strengh"])
        GlobalVars.SHOCK:
            velocity.shock = true
            

func update_effects():
    for effect in current_status_effects:
        effect["current_duration"] -= 1 
        effect_container.manage_effect(effect["type"], effect["current_duration"], effect["duration"])
        # run effect functions
        execute_effects(effect)
        if effect["current_duration"] == 0:
            current_status_effects.erase(effect)
        

func _ready():
    tick_timer = Timer.new()
    tick_timer.wait_time = 1
    tick_timer.one_shot = false
    tick_timer.timeout.connect(update_effects())
    add_child(tick_timer)
    tick_timer.start()