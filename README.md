## What's ***buildenv***?
A series of lua scripts to help describe [Premake5](https://premake.github.io/) projects.

## Usage

Describe your projects in `.lua` files:

```lua
Demo = Proj:register('Demo')

-- init some data used by parents
function Demo:init()
	-- it's important to use 'self' because of inheritance
	self.parent = App -- set project inheritance, you may also use 'Lib' others made by yourself
	self.dependencies = { DemoLib } -- use to add dependencies, will call 'add_dependencies()' function on dependence projects
end

function Demo:setup_project()
	-- do some Premake operations specific to your project
end

function Demo:setup_workspace()
	-- do some Premake operations specific to your workspace in case this project is used as a root project
end

function Demo:add_dependencies(other)
	-- called when 'other' depends on this project
end
```
###
Generate your project by running the Python script:

```python
import buildenv.buildenv
import os

working_dir = os.path.dirname(__file__)
root_project = working_dir
root_project_name = 'Demo' # project that will be used to setup the workspace
projects_folder = f'{root_project}/code' # base folder that contain every project config that will be loaded

buildenv.setup(root_project, root_project_name, projects_folder)
```
###
Using proposed project descriptors, the generated solution is under ***[root_project]/.generated/projects/visualStudio/***

## Features
- Windows only
- Structure to execute Premake5
- Supported projects platforms: Windows
- Write your own project descriptors
- Use App and Lib descriptors as a base for your projects
	- Generate Visual Studio C++ Solution
	- Support .exe and .lib generation
	- Support .lib or custom dependencies

## TODO
- Build from various platform
- Cross platform support
- Handle project dependencies from existing git repositories