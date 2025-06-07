App = Proj:register('App')

function App:init()
	self.parent = Base
end

function App:setup_project()
	kind('ConsoleApp')
	postbuildcommands{
		self.registered_dll,
		'ver >nul', -- Ignore robocopy errors
	}
end