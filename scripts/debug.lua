Debug = {}
Debug.tab_count = 0
Debug.enabled = false

local function change_tab_level(add_value)
	Debug.tab_count = Debug.tab_count + add_value
end

function Debug:add_tab_level()
	change_tab_level(1)
end

function Debug:remove_tab_level(add_value)
	change_tab_level(-1)
end

function Debug:print(info)
	local tabs = string.rep("  ", Debug.tab_count)
	if Debug.enabled then
		print('DEBUG: ' .. tabs .. info)
	end
end