snake = {}
snake.__index = snake

local svonly = {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_DONTRECORD}

print("[GSnake Minigame] Begin Initializing GSnM...!")
print("[GSnM] --- Please Note ---")
print("[GSnM] Please note that this version is a simplified version for better compatibility for workshop.")
print("[GSnM] If you wish a full version of the game, which includes pointshop 1 integration and other customisation, please refer to Workshop page for more info!")

snake.cvar = {}
snake.cvar.ForceWindowSize 	= CreateConVar( "snake_force_window_size", "1", svonly, "Force GSnake window to a fixed size of: 1024 x 576 ? Set to 0 if you prefer 'Almost-Fullscreen' size.")
snake.cvar.AutoAnnounce		= CreateConVar( "snake_announce", "1", svonly, "Announce dead players to play Snake mini game?" )
snake.cvar.OnlySpectator	= CreateConVar( "snake_only_spectator", "1", svonly, "Make the minigame only available when spectating (including dead players)?")

if SERVER then
	AddCSLuaFile("snake/cl_snake.lua")
	AddCSLuaFile("snake/sh_snake.lua")
	
	include("snake/sh_snake.lua")
	include("snake/snake_js.lua")
	include("snake/sv_snake.lua")
else
	include("snake/sh_snake.lua")
	include("snake/cl_snake.lua")
end

print("[GSnake Minigame] Successfully loaded GSnM...!")