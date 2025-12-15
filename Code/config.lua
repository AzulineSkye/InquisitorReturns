local enable_funny_checkbox = Options:add_checkbox("enableFunny")
	
enable_funny_checkbox:add_getter(function()
	return Settings.enable_funny
end)

enable_funny_checkbox:add_setter(function(value)
	Settings.enable_funny = value
	SettingsFile:write(Settings)
end)