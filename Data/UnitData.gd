class_name UnitData
extends Object

var name: String = "None"
var speed: float = 200.0
var faction: String = "Neutral"
# Player - owned and controlled by the player, attacks what ever they have their units set to attack.
# Neutral - passive unowned mobs that don't automatically attack unless triggered to elsewhere
# Hostile - naturally aggressive unowned mobs.
# Other faction names can be specified later for specific behaviors, but the default function should be based on neutral.

