## What's ***buildenv***?
A series of lua scripts based on [Premake5](https://premake.github.io/) to generate C++ project

## Usage
- In your root folder, create ***config.lua***:
```lua
env.config = {}
env.config.name = 'SolutionName'
```

- In ***./code/***, create ***XXX.lua***:
```lua
proj = {}
proj.name = 'ProjectName'
proj.type = type_app
```

- Run build.py from your project folder.

The generated solution is under ***./.generated/projects/visualStudio/***

## Features
- Generate Visual Studio C++ Solution
- Support .exe application
- Windows only

## TODO
- Cross platform support
- Lib project, and more
- Project dependencies