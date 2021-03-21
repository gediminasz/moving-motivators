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
            "description": "I have plenty of things to investigate and to think about",
            "color": "FFA500",
        },
        {
            "title": "Acceptance",
            "description": "The people around me approve of what I do and who I am",
            "color": "FFD700",
        },
        {
            "title": "Power",
            "description": "There’s enough room for me to influence what happens around me",
            "color": "DAA520",
        },
        {
            "title": "Relatedness",
            "description": "I have good social contacts with the people in my work",
            "color": "008000",
        },
        {
            "title": "Goal",
            "description": "My purpose in life is reflected in the work that I do",
            "color": "000080",
        },
        {
            "title": "Honor",
            "description": "I feel proud that my personal values are reflected in how I work",
            "color": "00BFFF",
        },
        {
            "title": "Mastery",
            "description": "My work challenges my competence but it is still within my abilities",
            "color": "008B8B",
        },
        {
            "title": "Freedom",
            "description": "I am independent of others with my work and my responsibilities",
            "color": "DC143C",
        },
        {
            "title": "Order",
            "description": "There are enough rules and policies for a stable environment",
            "color": "FF69B4",
        },
        {
            "title": "Status",
            "description": "My position is good, and recognized by the people who work with me",
            "color": "800080",
        },
    ]

    for properties in cards:
        var card = Card.instance()
        card.get_node("Title").text = properties["title"]
        var stylebox = StyleBoxFlat.new()
        stylebox.bg_color = Color(properties["color"])
        card.get_node("Title").add_stylebox_override("normal", stylebox)
        card.get_node("Description").text = properties["description"]

        var x = clamp(rng.randfn() * 75, -100, +100)
        var y = clamp(rng.randfn() * 50, -100, +100)
        card.position = $Center.position + Vector2(x, y)
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
        shift = picked_card.position - get_global_mouse_position()

    if not Input.is_action_pressed("ui_lmb") and picked_card:
        picked_card.position = picked_card.position.round()
        picked_card = null
        shift = null


func _find_target_card():
    var mouse_position = get_global_mouse_position()
    var cards = get_tree().get_nodes_in_group("cards")
    cards.invert()
    for card in cards:
        if card.get_rect().has_point(mouse_position):
            return card
