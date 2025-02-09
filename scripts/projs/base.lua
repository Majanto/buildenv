Base = Proj:register('Base')

function Base:init()
end

function Base:setup_project()
	project(self.name).group = self.filter
	location(Config:get_project_location(self.name))
	language('C++')
	cppdialect('C++20')
	objdir(Config:get_project_obj_dir(self.name))
	targetdir(Config:get_project_target_dir(self.name))
	flags { 'MultiProcessorCompile' }

	if self.dependencies ~= nil then
		for key, dependence in pairs(self.dependencies) do
			Proj:call(dependence, 'AddDependencies', self)
		end
	end
	
	files {
		self.dir .. '/**.h',
		self.dir .. '/**.c',
		self.dir .. '/**.cpp'
	}
	includedirs { self.dir }
end

function Base:setup_workspace()
	workspace(self.workspace_name)
	startproject(self.name)
	location(Config.solution_dir)
	configurations { 'Debug', 'Release' }
	architecture('x64')
end

function Base:add_dependencies(other)
	dependson { self.name }
end