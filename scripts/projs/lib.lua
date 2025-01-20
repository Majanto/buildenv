Lib = proj:register('Lib')

function Lib:init()
	self.parent = Base
end

function Lib:setup()
	kind('StaticLib')
end

function Lib:add_dependencies(other)
	if self.precompiled == nil or self.precompiled == false then
		links { self.name .. '.lib' }
		libdirs { GetProjectTargetDir(self.name) }
		includedirs { self.dir }
	end
end