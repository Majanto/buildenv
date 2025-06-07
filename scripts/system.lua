System = {}

System.windows = 'Windows'
System.linux = 'Linux'
System.macos = 'Mac OS'

function System:platform()
	-- Standard Lua method
	local dir_sep = package.config:sub(1, 1)
	if dir_sep == '\\' then
		return System.windows
	else
		-- Use uname command to further distinguish macOS from Linux
		local uname_output = io.popen('uname'):read('*l')
		if uname_output == 'Darwin' then
			return System.macos
		else
			return System.linux
		end
	end
end

function System:is_windows()
	return System:platform() == System.windows
end

function System:is_linux()
	return System:platform() == System.linux
end

function System:is_macos()
	return System:platform() == System.macos
end

function System:get_files_recursive(dir, filter)
	local files = {}
	-- Command for listing files depending on the platform
	local command
	if System:is_windows() then
		command = 'dir "' .. dir .. '" /S /B /A-D' -- Windows
	else
		command = 'find "' .. dir .. '" -type f' -- Unix-like systems (Linux, macOS)
	end

	local p = io.popen(command)
	for file in p:lines() do
		if file:match(filter) then
			table.insert(files, file)
		end
	end
	p:close()

	return files
end

function System:get_dir_path(file_path)
	-- Determine the directory separator based on the platform
	local dir_sep = package.config:sub(1, 1) == "\\" and "\\" or "/"

	-- Match the directory part of the file path
	return file_path:match("(.*" .. dir_sep .. ")") or "./"
end

function System:get_file_name(file_path)
	return file_path:match("^.+[\\/](.+)$") or file_path
end

function System:stop(info)
	print('Error: ' .. info)
	print('Early stop.')
	os.exit()
end

function System:stop_if(test, info)
	if test then
		System:stop(info)
	end
end