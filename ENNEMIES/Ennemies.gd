extends Node2D

var direction = 1
const ATTACK_DISTANCE = 64
var coolDown
var speed = 200

func _ready():
	$AnimationPlayer.play("Walk")
	pass

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, global_position + Vector2(ATTACK_DISTANCE * direction, 0), [$KinematicBody2D, self], 10)
	if result:
		attack(result.collider.get_parent())
	if $KinematicBody2D != null:
		$KinematicBody2D.move_and_collide(speed * delta * Vector2(direction, 0))
		position = $KinematicBody2D.global_position
		$KinematicBody2D.position = Vector2(0, 0)
	elif $AnimationPlayer.current_animation == "Walk":
		queue_free()
func attack(result):
	if coolDown:
		result.receiveAttack(10.0)
		$AnimationPlayer.play("Attack")
		coolDown = false
func kill():
	queue_free()


func _on_Cooldown_timeout():
	coolDown = true

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("Walk")