Config = {}

-- Premake new arguments
newoption {
	trigger = 'root',
	description = 'Path to the root of the project',
	value = 'path/to/root',
	default = nil
}

newoption {
	trigger = 'root-proj',
	description = 'Name of the root project',
	value = 'path/to/project.lua',
	default = nil
}

newoption {
	trigger = 'projs-folder',
	description = 'Path to the folder containing projects',
	value = 'path/to/projects',
	default = nil
}

function Config:init()
	-- Root
	Config.root_dir = _OPTIONS['root']
	System:stop_if(Config.root_dir == nil, 'Missing Config.root_dir')
	print('Config.root_dir= ' .. Config.root_dir)
	
	Config.root_project = _OPTIONS['root-proj']
	System:stop_if(Config.root_project == nil, 'Missing Config.root_project')
	print('Config.root_project= ' .. Config.root_project)

	Config.projs_folder = _OPTIONS['projs-folder']
	System:stop_if(Config.projs_folder == nil, 'Missing Config.projs_folder')
	print('Config.projs_folder= ' .. Config.projs_folder)

	Config.generated_dir = Config.root_dir .. '/.generated/'
	Config.solution_dir = Config.generated_dir .. 'projects/visualStudio/'
end

function Config:get_project_location(name)
	return Config.solution_dir .. name
end

function Config:get_project_obj_dir(name)
	return Config.solution_dir .. name .. "/intermediates/"
end

function Config:get_project_target_dir(name)
	return Config.solution_dir .. name .. "/binaries/$(Platform)/$(Configuration)"
end