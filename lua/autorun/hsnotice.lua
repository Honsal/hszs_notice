if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("hsnotice/cl_init.lua")
	include("hsnotice/init.lua")
else
	include("hsnotice/cl_init.lua")
end