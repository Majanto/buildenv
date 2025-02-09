Proj = {}
Proj.projects = {}

local function is_valid_name(name)
	-- TODO: Check for collisions
	return name == nil
end

-- Load projects config from the folder path passed as argument.
-- Set its .dir value based on the folder of its config file.
local function load()
	include('scripts/projs/base.lua')
	include('scripts/projs/lib.lua')
	include('scripts/projs/app.lua')
	for i, file in ipairs(System:get_files_recursive(Config.projs_folder, '%.lua$')) do
		prev_count = #Proj.projects
		include(file)
		System:stop_if(#Proj.projects > prev_count + 1, "Registering more than one project isn't supported")
		Proj.projects[#Proj.projects].dir = System:get_dir_path(file)
	end
end

-- Calls init function on every registered projects
local function init()
	for i, p in ipairs(Proj.projects) do
		Proj:call(p, 'init')
	end
end

local function setup()
	for i, p in ipairs(Proj.projects) do
		if p.name == Config.root_project then
			root_project = p
		end
	end

	System:stop_if(root_project == nil, "Root project not found")

	Proj:call(root_project, 'setup_workspace')

	local function recursive(_proj)
		if _proj.dependencies ~= nil then
			for i, p in pairs(_proj.dependencies) do
				recursive(p)
			end
		end
		Proj:call(_proj, 'setup_project')
	end
	recursive(root_project)
end

function Proj:register(name)
	System:stop_if(name == nil, 'Missing name on Proj:register()')
	for i, p in ipairs(Proj.projects) do
		System:stop_if(name == p.name, 'Registering project ' .. name .. ' but it already exist')
	end

	p = {}
	p.name = name
	Debug:print(p.name .. ' is ' .. tostring(p))
	table.insert(Proj.projects, p)
	return p
end

-- Calls func(obj) starting for the top most obj.parent.parent... to obj
function Proj:call(obj, func, ...)
	local args = {...}
	local function recursive(_obj)
		if _obj == nil then
			return
		end
		recursive(_obj.parent)
		if _obj[func] then
			Debug:print(_obj.name .. '.' .. func)
			Debug:add_tab_level()
			_obj[func](obj, table.unpack(args))
			Debug:remove_tab_level()
		end
	end
	args_tostring = ''
	for i, v in ipairs(args) do
		if i > 1 then args_tostring = args_tostring .. ', ' end
		args_tostring = args_tostring .. tostring(v)
	end
	Debug:print('Calling ' .. func .. '(' .. args_tostring ..') for ' .. obj.name)
	--Debug:add_tab_level()
	recursive(obj)
	--Debug:remove_tab_level()
end

function Proj:build()
	load()
	init()
	setup()
end