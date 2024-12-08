env = {}

type_app = {}

local function RecursivelyIncludeDirs(proj)
	includedirs { proj.dir }
	if proj.dependencies ~= nil then
		for key, dependence in pairs(proj.dependencies) do
			RecursivelyIncludeDirs(dependence)
		end
	end
end

local function SetupBase(proj, k)
	project(proj.name).group = proj.filter
	location(GetProjectLocation(proj.name))
	architecture('x64')
	kind(k)
	files {
		proj.dir .. '/**.h',
		proj.dir .. '/**.hpp',
		proj.dir .. '/**.cpp'
	}
end

local function SetupCompiled(proj)
	language('C++')
	cppdialect('C++20')
	flags { 'MultiProcessorCompile' }
	objdir(GetProjectObjDir(proj.name))
	targetdir(GetProjectTargetDir(proj.name))

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

local function SetupShared(proj)
	SetupBase(proj, 'SharedItems')
end

local function SetupLib(proj)
	SetupBase(proj, 'StaticLib')
	SetupCompiled(proj)
end

local function SetupApp(proj)
	SetupBase(proj, 'ConsoleApp')
	SetupCompiled(proj)
end

local function SetupProject(proj)
	if proj.type == type_app then SetupApp(proj)
	else print('Project ' .. proj.name .. " isn't supported")
	end
end


function env:LoadPaths()
	env.root = _OPTIONS['root']
	if env.root == nil then
		print('Error: Missing root path')
		os.exit()
	end
	include('utilities/paths.lua')
end


function env:LoadConfig()
	include(env.config_file)
	if env.config == nil then
		print('Error: Missing config')
		os.exit()
	end
end

function env:LoadProjects()
	env.projects = {}
	for i, file in ipairs(GetFilesRecursive(env.code_dir, '%.lua$')) do
		include(file)
		proj.dir = GetDirPath(file)
		table.insert(env.projects, proj)
	end
end

function env:InitSolution()
	workspace(env.config.name)
	location(env.solution_dir)
	configurations { 'Debug', 'Release' }
end

function env:InitProjects()
	for i, proj in ipairs(env.projects) do
		SetupProject(proj)
	end
end