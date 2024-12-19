Base = Declare()

function Base:Init()
end

function Base:Setup(proj)
	project(proj.name).group = proj.filter
	location(GetProjectLocation(proj.name))
	language('C++')
	cppdialect('C++20')
	objdir(GetProjectObjDir(proj.name))
	targetdir(GetProjectTargetDir(proj.name))
	flags { 'MultiProcessorCompile' }
end