include('utilities/system.lua')
include('utilities/premake_args.lua')
include('utilities/env.lua')

env.LoadPaths()
env.LoadConfig()
env.LoadProjects()
env.InitSolution()
env.InitProjects()