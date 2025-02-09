import subprocess
import os

def setup(root_folder, root_project_name, projects_folder):
	current_dir = os.path.dirname(__file__)
	subprocess.run(f'"{current_dir}/premake/premake5" vs2022 --file={current_dir}/build.lua --root={root_folder} --root-proj={root_project_name} --projs-folder={projects_folder}')