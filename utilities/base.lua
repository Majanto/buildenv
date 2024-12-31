Base = Declare('Base')
Debug(Base.name .. ' is ' .. tostring(Base))

function Base:Init()
end

function Base:Setup()
	Unsure(self, 'name', 'parent', 'dir')

	project(self.name).group = self.filter
	location(GetProjectLocation(self.name))
	language('C++')
	cppdialect('C++20')
	objdir(GetProjectObjDir(self.name))
	targetdir(GetProjectTargetDir(self.name))
	flags { 'MultiProcessorCompile' }

	if self.dependencies ~= nil then
		for key, dependence in pairs(self.dependencies) do
			Call(dependence, 'AddDependencies', self)
		end
	end
	
	files {
		self.dir .. '/**.h',
		self.dir .. '/**.c',
		self.dir .. '/**.cpp'
	}
	includedirs { self.dir }
end

function Base:AddDependencies(other)
	dependson { self.name }
end