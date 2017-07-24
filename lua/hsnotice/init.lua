Msg("##############################\n")
Msg("## Loading Notice Module    ##\n")
HSNotice = {}
Msg("## joinalert.lua            ##\n")
include("joinalert.lua")
Msg("## Complete!                ##\n")
Msg("##############################\n")

util.AddNetworkString("hsnotice")

local hsn_delay = CreateConVar("hsn_delay", "60", FCVAR_SERVER_CAN_EXECUTE, "Set delay of showing notice"):GetInt()
local hsn_noticefile = CreateConVar("hsn_noticefile", "notices.txt", FCVAR_SERVER_CAN_EXECUTE):GetString()

if !file.Exists("hsnotice/" .. hsn_noticefile, "DATA") then
	file.Write("hsnotice/" .. hsn_noticefile, "")
end

function HSNotice.PrintNotice()
	local fulltext = file.Read("hsnotice/" .. hsn_noticefile, "DATA")
	local splited = string.Explode("\r?\n", fulltext, true)
	local broadcasted = table.Random(splited)
	net.Start("hsnotice")
		net.WriteString(broadcasted)
	net.Broadcast()
	MsgC(Color(0, 255, 0), "[HSNotice]" .. broadcasted .. "\n")
	ulx.logString("[HSNotice] " .. broadcasted)
end
timer.Remove("HSN_PrintNotice", hsn_delay, 0, HSNotice.PrintNotice)
timer.Create("HSN_PrintNotice", hsn_delay, 0, HSNotice.PrintNotice)


cvars.AddChangeCallback("hsn_delay", function(name, old, new)
	timer.Remove("HSN_PrintNotice", new, 0, HSNotice.PrintNotice)
	timer.Create("HSN_PrintNotice", new, 0, HSNotice.PrintNotice)
	HSNotice.PrintNotice()
end)