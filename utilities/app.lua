App = Declare('App')

function App:Init()
	self.parent = Base
end

function App:Setup()
	kind('ConsoleApp')
end