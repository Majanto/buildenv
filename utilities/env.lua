env = {}
env.projects = {}

local function RecursivelyIncludeDirs(proj)
	includedirs { proj.dir }
	files {
		proj.dir .. '/**.h',
		proj.dir .. '/**.c',
		proj.dir .. '/**.cpp'
	}
	if proj.dependencies ~= nil then
		for key, dependence in pairs(proj.dependencies) do
			RecursivelyIncludeDirs(dependence)
		end
	end
end

local function SetupCompiled(proj)

	if proj.dependencies ~= nil then
		for key, dependence in pairs(proj.dependencies) do
			dependson { dependence.name }
			if proj.libname ~= nil or proj.libdir ~= nil then
				links { proj.libname == nil and dependence.libname or dependence.name }
				libdirs { proj.libdir == nil and dependence.libdir or GetProjectTargetDir(dependence.name) }
			end
			RecursivelyIncludeDirs(dependence)
		end
	end
end

function SetupShared(proj)
	SetupBase(proj, 'SharedItems')
end

function SetupLib(proj)
	SetupBase(proj, 'StaticLib')
	SetupCompiled(proj)
end

function SetupApp(proj)
	SetupBase(proj, 'ConsoleApp')
	SetupCompiled(proj)
end

function Register()
	proj = {}
	table.insert(env.projects, proj)
	print(proj)
	return proj
end

function Declare()
	proj = {}
	return proj
end