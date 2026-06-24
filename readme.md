# Hit'n'Run

Action platformer rougelike inspired by hollow knight

# Table of contens

- [Features](#features)
	- [Status Effects](#status-effects-system)


## Features

### Status effects System

The status effect system uses the `StatusEffect` and `CurrentEffects` resources to manage status effects, which effects get executed in the `status_effects` node.

#### Current status effects

ID | Effect
--- | ---
0 | Poison (blindness, slowness)
1 | Shock (dazzle)
2 | Frost (slowness, increased damage taken)
3 | Decay (takes fixed percentage of health and stops at 5hp)
4 | Fire (continuous damage)
5 | Regeneration (healing)
6 | Sleep (slowness, can’t attack)
7 | Confusion (reversed controlls)
8 | Slowness
9 | Speed
10 | Weakness
11 | Strenght

#### How to add new effects

New status effects can be added by:
1. adding them to the enum in `scripts/resources/status_effect.gd`
2. adding the sprites of the effect for the effect display and particles in `scripts/globals/global_assets.gd`
3. adding an execution in `scripts/components/status_effects.gd`
4. enjoy your new effect


## Thanks
- [pixelfranek](https://pixelfranek.itch.io/free-textures-of-light) for the light textures
