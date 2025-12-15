mods["ReturnsAPI-ReturnsAPI"].auto{mp = true, namespace = "inq"}

PATH = _ENV["!plugins_mod_folder_path"]

Options = ModOptions.new("inq")

Settings = {
	enable_funny = false,
}

SettingsFile = TOML.new()

local init = function()
	if SettingsFile:read() == nil then
		SettingsFile:write(Settings)
	else
		Settings = SettingsFile:read()
	end
	
	local folders = {
		"Language",
		"Code"
	}

	for _, folder in ipairs(folders) do
		local filepaths = path.get_files(path.combine(PATH, folder))
		for _, filepath in ipairs(filepaths) do
			if string.sub(filepath, -4, -1) == ".lua" then
				require(filepath)
			end
		end
	end
	
	HOTLOADING = true
end

Initialize.add(init)

if HOTLOADING then
	init()
end
