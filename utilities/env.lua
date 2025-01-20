env = {}
env.projects = {}

-- TODO: Refactor files, mainly maybe split this one? Wrap function in classes?



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