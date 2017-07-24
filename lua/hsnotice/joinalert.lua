local function LogAndTsay(str)
	ulx.logString("[HSNotice] " .. str)
	ulx.tsay(NULL, "[HSNotice] " .. str)
end

function HSNotice.JoinAlert(pl)
	local str = "플레이어[" .. (pl:Nick() or "{UNKNOWN}") .. "] 님께서 게임에 참여하셨습니다. (" .. pl:IPAddress() .. ")"
	LogAndTsay(str)
end
hook.Remove("PlayerInitialSpawn", "HSNotice.JoinAlert", HSNotice.JoinAlert)
hook.Add("PlayerInitialSpawn", "HSNotice.JoinAlert", HSNotice.JoinAlert)