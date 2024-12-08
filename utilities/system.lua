local platform_windows = 'Windows'
local platform_linux = 'Linux'
local platform_macos = 'Mac OS'

function GetPlatform()
	-- Standard Lua method
	local dir_sep = package.config:sub(1, 1)
	if dir_sep == '\\' then
		return platform_windows
	else
		-- Use uname command to further distinguish macOS from Linux
		local uname_output = io.popen('uname'):read('*l')
		if uname_output == 'Darwin' then
			return platform_macos
		else
			return platform_linux
		end
	end
end

function IsWindows()
	return GetPlatform() == platform_windows
end

function IsLinux()
	return GetPlatform() == platform_linux
end

function IsMacOS()
	return GetPlatform() == platform_macos
end

function GetFilesRecursive(dir, filter)
	local files = {}
	-- Command for listing files depending on the platform
	local command
	if IsWindows() then
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

function GetDirPath(file_path)
    -- Determine the directory separator based on the platform
    local dir_sep = package.config:sub(1, 1) == "\\" and "\\" or "/"

    -- Match the directory part of the file path
    return file_path:match("(.*" .. dir_sep .. ")") or "./"
end