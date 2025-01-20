Base = proj:register('Base')

function Base:init()
end

function Base:setup()
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

function Base:add_dependencies(other)
	dependson { self.name }
end