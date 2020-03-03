extends Node

export (PackedScene) var Mob
export (PackedScene) var Mob2
export (PackedScene) var coin
var score

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob
	if (rand_range(0,100) <= 20):
		mob = Mob2.instance()
		add_score(2)
	else:
		mob = Mob.instance()
		add_score(1)
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	$HUD.connect("start_game", mob, "_on_start_game")

func spawn_coin():
	$CoinTimer.start()
	var moneda = coin.instance()
	add_child(moneda)
	moneda.position.x = rand_range(0,500)
	moneda.position.y = rand_range(0,900)
	$Player.connect("agafar_moneda", moneda, "_on_agafar_moneda")
	
func add_score(add):
	score += add
	$HUD.update_score(score)
	if(score > 10):
		if(add == 1 && score % 20 == 0):
			spawn_coin()
		elif(add == 2 && score % 20 <= 1):
			spawn_coin()
		elif(add == 5 && score % 20 <= 4):
			spawn_coin()
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	
func _on_Player_agafar_moneda():
	add_score(5)
