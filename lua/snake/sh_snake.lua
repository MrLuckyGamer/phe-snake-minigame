local ADDON_INFO = {
	name	= "GSnake",
	version	= "1.0",
	info	= "A Snake Minigame for Garry's Mod.",
	
	settings = {
		{"snake_force_window_size", "check", "SERVER", "Force GSnake window to a Fixed or Almost-Fullscreen size."},
		{"snake_announce", "check", "SERVER", "Announce dead players to play Snake mini game?" },
		{"snake_only_spectator", "check", "SERVER", "Make the minigame only available when spectating (including dead players)?" }
	},
	
	client	= {}
}
list.Set("PHE.Plugins","PH Snake",ADDON_INFO)