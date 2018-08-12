extends Node2D
const RECT_SIZE = 48

func update(health, maxHealth):
	$Health.rect_size = Vector2( 48 * health / maxHealth, 8)