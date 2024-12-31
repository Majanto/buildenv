Lib = Declare('Lib')

function Lib:Init()
	self.parent = Base
end

function Lib:Setup()
	kind('StaticLib')
end

function Lib:AddDependencies(other)
	if self.precompiled == nil or self.precompiled == false then
		links { self.name .. '.lib' }
		libdirs { GetProjectTargetDir(self.name) }
		includedirs { self.dir }
	end
end