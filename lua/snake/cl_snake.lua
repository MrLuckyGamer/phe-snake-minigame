// create a link under window
snake.BoardScript = snake.BoardScript or ""

net.Receive("snake.net.ClientInfo", function()
	local size = net.ReadUInt(18)
	local data = net.ReadData(size)
	
	data = util.Decompress(data)
	snake.BoardScript = data
	
	print("[GSnake] Retreving Snake Board data and caching them... (" .. tostring(size) .. " Bytes).")
end)

function snake:CloseWindow()
	if !snake.f then return end
	
	if (snake.f and snake.f.IsOpen) then
		chat.AddText(color_white, "[GSnake]", Color(10,235,10), " Closing minigame window... You can reopen it again by pressing F9.")
		snake.f:Close()
	end
end

function snake:Post( int )
	local msg = "I've just beat the Snake minigame by scoring " .. tostring(int) .. " points!"
	if engine.ActiveGamemode() == "terrortown" then
		LocalPlayer():ConCommand( "say_team ".. msg )
	else
		LocalPlayer():ConCommand( "say ".. msg )
	end
end

function snake.BeginPlay()
	if !snake.BoardScript or snake.BoardScript == "" then
		chat.AddText(color_white, "[GSnake] ", Color(255,40,40),"Error loading the minigame!")
		return
	end

	if snake.cvar.ForceWindowSize:GetBool() then
		snake.Width		= 1024
		snake.Height 	= 576
	else
		snake.Width		= ScrW()-100
		snake.Height 	= ScrH()-30
	end

	if snake.cvar.OnlySpectator:GetBool() and LocalPlayer():Alive() then
		chat.AddText(color_white, "[GSnake] ", Color(255,40,40),"The Snake minigame is only available when spectating!")
		return
	end

	snake.f = vgui.Create("DFrame")
	
	snake.f:SetSize(snake.Width, snake.Height)
	snake.f:SetPos(0,0)
	snake.f:SetTitle("GSnake - A Simple Garry's Mod 'Snake' Game!")
	snake.f.Paint = function(self,w,h)
		draw.RoundedBox(8,0,0,w,h,Color(20,20,20,180))
	end
	function snake.f:OnClose()
		self.IsOpen = false
	end
	
	snake.html = vgui.Create("DHTML", snake.f)
	snake.html:Dock(TOP)
	snake.html:SetSize(0,snake.f:GetTall() - 60)
	snake.html:SetHTML(snake.BoardScript)
	snake.html:AddFunction("console","doPost",function( int )
		snake:Post( int )
	end)
	
	snake.text = vgui.Create("DLabel", snake.f)
	snake.text:Dock(FILL)
	snake.text:DockMargin(10,6,0,0)
	snake.text:SetText("Find out more PH:E plugins @ https://prophuntenhanced.xyz/plugins !")
	snake.text:SetFont("HudHintTextLarge")
	snake.text:SetTextColor(color_white)
	
	snake.f:MakePopup()
	snake.f:Center()
	
	snake.f.IsOpen = true
	
	snake.html:SetAllowLua(true)
end
concommand.Add("wlv_gsnake", snake.BeginPlay, nil, "Open snake minigame window!")