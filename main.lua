mods["ReturnsAPI-ReturnsAPI"].auto{mp = true, namespace = "inq"}

PATH = _ENV["!plugins_mod_folder_path"]

Options = ModOptions.new("inq")

Settings = {
	funny = false,
}

SettingsFile = TOML.new()

local init = function()
	--- Initialize settings here before requiring anything, useful if some options require a restart to apply.
	if SettingsFile:read() == nil then
		SettingsFile:write(Settings)
	else
		Settings = SettingsFile:read()
	end
				
	require(path.combine(PATH, "inputLibrary.lua")
	require(path.combine(PATH, "inquisitor.lua")
	
	HOTLOADING = true
end

Initialize.add(init)

if HOTLOADING then
	init()
end
