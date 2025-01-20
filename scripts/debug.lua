Debug = {}
Debug.tab_count = 0

function Debug:add_tab_level(add_value)
	Debug.tab_count = Debug.tab_count + add_value
end

function Debug:print(info)
	local tabs = string.rep("  ", Debug.tab_count)
	--print('DEBUG: ' .. tabs .. info)
end