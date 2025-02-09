App = Proj:register('App')

function App:init()
	self.parent = Base
end

function App:setup_project()
	kind('ConsoleApp')
end