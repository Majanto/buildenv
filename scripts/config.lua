Config = {}

-- Root
Config.root_project_file = _OPTIONS['root']
StopIf(Config.root_project_file == nil, 'Missing root project file')

Config.root_dir
Config.root_project = Config.root .. '/config.lua'
Config.code_dir = Config.root .. '/code'
Config.generated_dir = Config.root .. '/.generated/'
Config.solution_dir = Config.generated_dir .. 'projects/visualStudio/'

function Config:get_project_location(name)
	return Config.solution_dir .. name
end

function Config:get_project_obj_dir(name)
	return Config.solution_dir .. name .. "/intermediates/"
end

function Config:get_project_target_dir(name)
	return Config.solution_dir .. name .. "/binaries/$(Platform)/$(Configuration)"
end

newoption {
	trigger = 'root',
	description = 'Path to the root of the project',
	value = 'path/to/root',
	default = nil
}

newoption {
	trigger = 'start-proj',
	description = 'Path to the main project.lua',
	value = 'path/to/project.lua',
	default = nil
}

newoption {
	trigger = 'proj-folder',
	description = 'Path to the folder containing projects',
	value = 'path/to/projects',
	default = nil
}