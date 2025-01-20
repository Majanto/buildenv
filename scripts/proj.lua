Proj = {}
Proj.projects = {}

local function is_valid_name(name)
	-- TODO: Check for collisions
	return name == nil
end

function Proj:register(name)
	System:stop_if(is_valid_name(name), 'Missing name on proj:register()')
	p = {}
	p.name = name
	Debug:print(p.name .. ' is ' .. tostring(p))
	table.insert(Proj.projects, p)
	return p
end