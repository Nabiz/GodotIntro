extends KinematicBody2D

export var gravity = 200
export var speed = 200
export var jump_speed = -200

var velocity = Vector2.ZERO

onready var animation_sprite = $AnimatedSprite

func _process(_delta):
    if Input.is_action_pressed("ui_right"):
        velocity.x = speed
    elif Input.is_action_pressed("ui_left"):
        velocity.x = -speed
    else:
        velocity.x = 0
        
    if Input.is_action_pressed("ui_up") and is_on_floor():
        velocity.y = jump_speed

    set_animation()

func _physics_process(delta):
    velocity.y += gravity*delta
    velocity = move_and_slide(velocity, Vector2.UP)

func set_animation():
    if velocity == Vector2.ZERO:
        animation_sprite.animation = "idle"
    elif velocity.y == 0 and velocity.x != 0:
        animation_sprite.animation = "run"
    
    if velocity.x < 0:
        animation_sprite.flip_h = true
    else:
        animation_sprite.flip_h = false
