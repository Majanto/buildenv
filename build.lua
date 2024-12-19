include('utilities/premake_args.lua')

include('utilities/system.lua')
include('utilities/env.lua')
include('utilities/base.lua')
include('utilities/main.lua')

-- Root
env.root = _OPTIONS['root']
if env.root == nil then
	print('Error: Missing root path')
	os.exit()
end

-- Paths after root
include('utilities/paths.lua')

-- Global config
include(env.config_file)
if env.config == nil then
	print('Error: Missing config')
	os.exit()
end

-- Loading project configs
for i, file in ipairs(GetFilesRecursive(env.code_dir, '%.lua$')) do
	include(file)
	env.projects[#env.projects].dir = GetDirPath(file)
end

-- Init projects
for i, proj in ipairs(env.projects) do
	if proj.Init then
		proj:Init()
	end
end

-- TODO: make this be the global config file
-- Setup solution
-- workspace("YOO")
workspace(env.config.name)
location(env.solution_dir)
configurations { 'Debug', 'Release' }
architecture('x64')

-- project "MyProject"
-- kind "ConsoleApp"
-- language "C++"

Base:Init()
Main:Init()

-- Setup projects
for i, proj in ipairs(env.projects) do
	local function RecursiveSetup(_proj)
		if _proj == nil then
			return
		end
		RecursiveSetup(_proj.parent)
		if _proj.Setup then
			_proj:Setup(proj)
		end
	end
	RecursiveSetup(proj)
end