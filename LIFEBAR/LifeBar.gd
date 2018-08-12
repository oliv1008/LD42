extends Control
const RECT_SIZE = 48

func update(health, maxHealth):
	$Health.rect_size = Vector2( RECT_SIZE * health / maxHealth, 8)