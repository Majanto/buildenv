Lib = Proj:register('Lib')

function Lib:init()
	self.parent = Base
end

function Lib:setup_project()
	kind('StaticLib')
end

function Lib:add_dependencies(other)
	if self.precompiled == nil or self.precompiled == false then
		links { self.name .. '.lib' }
		libdirs { Config:get_project_target_dir(self.name) }
		includedirs { self.dir }
	end
end