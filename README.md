## What's ***buildenv***?
A series of lua scripts based on [Premake5](https://premake.github.io/) to generate C++ project

## Usage
- In your root folder, create ***config.lua*** (will be reworked at some point):
```lua
env.config = {}
env.config.name = 'SolutionName'
```

- In ***./code/***, create ***XXX.lua***:
```lua
Demo = Register('Demo') -- use 'Declare()' instead if you want a template project (unsupported for now)

-- init some data used by parents
function Demo:Init()
	-- it's important to use 'self' because of inheritance
	self.parent = App -- set project inheritance, you may also use 'Lib'
	self.dependencies = { DemoLib } -- use to add dependencies, will call 'AddDependencies()' function on dependence projects
end

function Demo:Setup()
	-- do some operation specific to your project
end

function Demo:AddDependencies(other)
	-- called when 'other' depends on this project
end
```

- Run build.py from your project folder.

The generated solution is under ***./.generated/projects/visualStudio/***

## Features
- Generate Visual Studio C++ Solution
- Support .exe and .lib generation
- Support .lib or custom dependencies
- Windows only

## TODO
- Cross platform support
- Rework main solution config file to be more user customizable, as project config files
- Allow user defined template project using ```Declare()``` instead of ```Register()```
- Reorganize scripts, wrap functions into classes
- Various improvements