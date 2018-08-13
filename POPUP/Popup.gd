extends Node2D

var TextureSprite = {"Mine" : preload("res://Assets/Pixel Art/Icones/icone amelio mine2.png"),\
					"Generateur" : preload("res://Assets/Pixel Art/Icones/icone amelio genera.png"), \
					"Entrepot" : preload("res://Assets/Pixel Art/Icones/icone amelio mine.png"),\
					"Labo" : preload("res://Assets/Pixel Art/Icones/icone amelio labo.png")
}

func _ready():
	$AnimationPlayer.play("Fade out")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func initialize(batiment, bonus):
	var texte = str("+ ", bonus)
	$Label.text = texte
	if batiment == "Mine":
		$Sprite.texture = TextureSprite.Mine
	elif batiment == "Generateur":
		$Sprite.texture = TextureSprite.Generateur
	elif batiment == "Entrepot":
		$Sprite.texture = TextureSprite.Entrepot
	elif batiment == "Labo":
		$Sprite.texture = TextureSprite.Labo

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fade out":
		queue_free()
