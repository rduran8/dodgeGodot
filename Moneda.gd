extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CoinTimer.set_wait_time(rand_range(2,5))
	$CoinTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_start_game():
	queue_free()
	
func _on_agafar_moneda():
	queue_free()

func _on_CoinTimer_timeout():
	queue_free()
