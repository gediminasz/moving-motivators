extends Node2D

var Card = preload("res://Card.tscn")

var picked_card = null
var shift = null

var rng = RandomNumberGenerator.new()

func _ready():
    randomize()
    rng.randomize()

    var cards = [
        {
            "title": "Curiosity",
            "description": "I have plenty of things to investigate and to think about"
        },
        {
            "title": "Acceptance",
            "description": "The people around me approve of what I do and who I am"
        },
        {
            "title": "Power",
            "description": "There’s enough room for me to influence what happens around me"
        },
        {
            "title": "Relatedness",
            "description": "I have good social contacts with the people in my work"
        },
        {
            "title": "Goal",
            "description": "My purpose in life is reflected in the work that I do"
        },
        {
            "title": "Honor",
            "description": "I feel proud that my personal values are reflected in how I work"
        },
        {
            "title": "Mastery",
            "description": "My work challenges my competence but it is still within my abilities"
        },
        {
            "title": "Freedom",
            "description": "I am independent of others with my work and my responsibilities"
        },
        {
            "title": "Order",
            "description": "There are enough rules and policies for a stable environment"
        },
        {
            "title": "Status",
            "description": "My position is good, and recognized by the people who work with me"
        },
    ]

    for properties in cards:
        var card = Card.instance()
        card.get_node("Title").text = properties["title"]
        card.get_node("Description").text = properties["description"]
        card.position = $Center.position + Vector2(rng.randi_range(-480, 480), rng.randi_range(-300, 300))
        card.rotation_degrees = rng.randi_range(-5, 5)
        card.add_to_group("cards")
        add_child(card)


func _process(delta):
    if picked_card:
        picked_card.position = get_global_mouse_position() + shift


func _input(event):
    var target_card = _find_target_card()

    if target_card and Input.is_action_just_pressed("ui_lmb"):
        picked_card = target_card
        picked_card.raise()
        picked_card.rotation_degrees = 0
        shift = picked_card.position - get_global_mouse_position()

    if not Input.is_action_pressed("ui_lmb") and picked_card:
        picked_card = null
        shift = null


func _find_target_card():
    var mouse_position = get_global_mouse_position()
    var cards = get_tree().get_nodes_in_group("cards")
    cards.invert()
    for card in cards:
        if card.get_rect().has_point(mouse_position):
            return card
