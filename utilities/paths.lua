env.config_file = env.root .. '/config.lua'
env.code_dir = env.root .. '/code'
env.generated_dir = env.root .. '/.generated/'
env.solution_dir = env.generated_dir .. 'projects/visualStudio/'

function GetProjectLocation(name)
	return env.solution_dir .. name
end

function GetProjectObjDir(name)
	return env.solution_dir .. name .. "/intermediates/"
end

function GetProjectTargetDir(name)
	return env.solution_dir .. name .. "/binaries/$(Platform)/$(Configuration)"
end