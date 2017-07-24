Msg("##############################\n")
Msg("## Loading Notice Module    ##\n")
-- Msg("## shared.lua               ##\n")
-- include("shared.lua")
-- Msg("## sv_checkpm.lua           ##\n")
-- include("sv_checkpm.lua")
Msg("## Complete!                ##\n")
Msg("##############################\n")

HSNotice = {}
HSNotice.EndTime = 0
HSNotice.Notice = ""

function HSNotice.PrintNotice()
	local notice = net.ReadString()
	if !notice then 
		return
	end
	HSNotice.Notice = notice
	HSNotice.EndTime = CurTime() + 20
	
	if !GAMEMODE:GetWaveActive() then
		chat.AddText(Color(13, 170, 255), "[HSNotice] ", Color(255, 255, 0), notice)
	end
	
	hook.Add("HUDPaint", "HSNotice.DrawNotice", HSNotice.DrawNotice)
	timer.Create("RemoveNotice", 20, 1, function()
		hook.Remove("HUDPaint", "HSNotice.DrawNotice")
	end)
end
net.Receive("hsnotice", HSNotice.PrintNotice)

function HSNotice.DrawNotice()
	local scrw, scrh = ScrW(), ScrH()
	local curtime = CurTime()
	local remain = math.max(0, HSNotice.EndTime - curtime)
	
	surface.SetFont("ChatFont")
	local w, h = surface.GetTextSize(HSNotice.Notice)
	
	if remain >= 10 then
		draw.RoundedBox(0, 0, scrh - h, scrw, h + 4, Color(30, 30, 30, 255 - (255 * ((remain - 10) / 10))))
		draw.DrawText(HSNotice.Notice, "ChatFont", ScrW() / 2 - w / 2, scrh - h, Color(255, 255, 0, 180 - (180 * ((remain - 10) / 10))), TEXT_ALIGN_LEFT)
	else
		draw.RoundedBox(0, 0, scrh - h, scrw, h + 4, Color(30, 30, 30, 255 * (remain / 10)))
		draw.DrawText(HSNotice.Notice, "ChatFont", ScrW() / 2 - w / 2, scrh - h, Color(255, 255, 0, 180 * (remain / 10)), TEXT_ALIGN_LEFT)
	end
end

function HSNotice.Advertisement(pl, text, tc, dd)
	local text = string.lower(text)
	if string.find(string.lower(text), "vip") or string.find(text, "브압") or string.find(text, "브앞") then
		chat.AddText(Color(45, 255, 17), "VIP는 프리미엄으로 바뀌었습니다.")
		chat.AddText(Color(232, 170, 12), "신청은 !reqp로 하실 수 있으며,")
		chat.AddText(Color(13, 255, 173), "자세한 내용은 !motd 최하단 프리미엄 섹션을 참조하세요.")
	end
end
hook.Remove("OnPlayerChat", "HSNotice.Advertisement", HSNotice.Advertisement)
hook.Add("OnPlayerChat", "HSNotice.Advertisement", HSNotice.Advertisement)