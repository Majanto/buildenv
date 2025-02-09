Main = Proj:register('Main')

function Main:init()
	self.workspace_name = 'MainWorkspace'
	self.parent = App
	self.dependencies = { SmallLib }
end