extends Node

const VERSION = "v1.5.0"

const P1_COLOR = Color("3e85d7")
const P2_COLOR = Color("dc3b3d")

enum DEATH_BY {
	CRUSHED,
	FALL,
	RESTART
}

var play_music = true
var play_sounds = true
