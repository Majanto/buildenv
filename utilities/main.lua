Main = Declare()

function Main:Init()
	Main.parent = Base
end

function Main:Setup(proj)
	kind('ConsoleApp')
	files{
		proj.dir .. '/**.h',
		proj.dir .. '/**.c',
		proj.dir .. '/**.cpp'
	}
end