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

	self.registered_dll = {}
	if self.dependencies ~= nil then
		for key, dependence in pairs(self.dependencies) do
			Proj:call(dependence, 'add_dependencies', self)
		end
	end
	
	files {
		self.dir .. '/**.h',
		self.dir .. '/**.c',
		self.dir .. '/**.hpp',
		self.dir .. '/**.cpp',
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

function Base:register_dll_copy(path)
	self.registered_dll[#self.registered_dll+1] = 'robocopy ' .. System:get_dir_path(path) .. ' $(OutputPath) ' .. System:get_file_name(path) .. ' /njh /njs' --' /ndl /njh /njs /nc /ns' -- /np /nfl
end