env = {}
env.projects = {}

-- TODO: Refactor files, mainly maybe split this one? Wrap function in classes?

function IsValidName(name)
	-- TODO: Check for collisions
	return name == nil
end

function Register(name)
	StopIf(IsValidName(name), 'Missing name on Register()')
	proj = {}
	proj.name = name
	Debug(proj.name .. ' is ' .. tostring(proj))
	table.insert(env.projects, proj)
	return proj
end

function Declare(name)
	StopIf(IsValidName(name), 'Missing name on Declare()')
	proj = {}
	proj.name = name
	Debug(proj.name .. ' is ' .. tostring(proj))
	return proj
end

-- Calls func(obj) starting for the top most obj.parent.parent... to obj
function Call(obj, func, ...)
	local args = {...}
	local function Recursive(_obj)
		if _obj == nil then
			return
		end
		Recursive(_obj.parent)
		if _obj[func] then
			Debug(_obj.name .. '.' .. func)
			Debug_IncrTab()
			_obj[func](obj, table.unpack(args))
			Debug_DecrTab()
		end
	end
	args_tostring = ''
	for i, v in ipairs(args) do
		if i > 1 then args_tostring = args_tostring .. ', ' end
        args_tostring = args_tostring .. tostring(v)
    end
	Debug('Calling ' .. func .. '(' .. args_tostring ..') for ' .. obj.name)
	Debug_IncrTab()
	Recursive(obj)
	Debug_DecrTab()
end

tabCount = 0
function Debug_IncrTab()
	tabCount = tabCount + 1
end

function Debug_DecrTab()
	tabCount = tabCount - 1
end

function Debug(info)
	local tabs = string.rep("  ", tabCount)
	print('DEBUG: ' .. tabs .. info)
end

function Stop(info)
	print('Error: ' .. info)
	print('Early stop.')
	os.exit()
end

function StopIf(test, info)
	if test then
		Stop(info)
	end
end