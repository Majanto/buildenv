App = proj:register('App')

function App:init()
	self.parent = Base
end

function App:setup()
	kind('ConsoleApp')
end