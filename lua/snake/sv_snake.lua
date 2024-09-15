snake.Data = util.Compress(snake.DataHTML)
util.AddNetworkString("snake.net.ClientInfo")

hook.Add("PlayerInitialSpawn", "snake.PlayerInit", function( ply )	
	-- https://github.com/Facepunch/garrysmod-requests/issues/718
	-- Very dirty code because Sending net messages to a player is not 100% reliable.
	hook.Add("SetupMove",ply,function(self,ply,_,cmd)
		if self == ply and not cmd:IsForced() then 
			hook.Run("snake.PlayerInit",self)
			hook.Remove("SetupMove",self)
		end
	end)

	local size = snake.Data:len()
	print( "[GSnM] Sending snake gameboard to player " .. ply:Nick() .. "... " )
	net.Start("snake.net.ClientInfo")
		net.WriteUInt(size, 18) //somewhere about 16 KB for safety.
		net.WriteData(snake.Data, size)
		net.Send( ply )
end)

hook.Add("PlayerSpawn", "snake.ForceCloseSnake", function(ply)
	timer.Simple(0.5, function()
		ply:SendLua("snake.CloseWindow()")
	end)
end)

hook.Add("PlayerDeath", "snake.AnnouncePlayer", function(ply)
	timer.Simple(2, function()
		if ( ply and IsValid(ply) ) and snake.cvar.AutoAnnounce:GetBool() then
			ply:SendLua([[notification.AddLegacy("Hey! Wanna try Snake Minigame? Press F9 to play Snake!", NOTIFY_GENERIC, 8)]])
			ply:SendLua([[surface.PlaySound('garrysmod/save_load]]..math.random(1,4)..[[.wav')]])
		end
	end)
end)

hook.Add("PlayerButtonDown", "snake.KeyPress", function( ply , btn )
	if (IsValid(ply) and btn == KEY_F9) then
		ply:SendLua("snake.BeginPlay()")
	end
end)