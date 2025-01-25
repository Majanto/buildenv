require('utilities/premake_args.lua')

require('utilities/system.lua')
require('utilities/env.lua')
require('utilities/base.lua')
require('utilities/lib.lua')
require('utilities/app.lua')

-- Root
env.root = _OPTIONS['root']
StopIf(env.root == nil, 'Missing root path')

-- Paths after root
require('utilities/paths.lua')

-- Global config
require(env.config_file)
StopIf(env.config == nil, 'Missing config')

-- Loading project configs
for i, file in ipairs(GetFilesRecursive(env.code_dir, '%.lua$')) do
	require(file)
	env.projects[#env.projects].dir = GetDirPath(file)
end

-- Init projects
for i, proj in ipairs(env.projects) do
	Call(proj, 'Init')
end

-- TODO: make this be the global config file
-- Setup solution
workspace(env.config.name)
startproject(env.config.start)
location(env.solution_dir)
configurations { 'Debug', 'Release' }
architecture('x64')

-- TODO: make this done automatically
Base:Init()
App:Init()
Lib:Init()

-- Setup projects
for i, proj in ipairs(env.projects) do
	Call(proj, 'Setup')
end