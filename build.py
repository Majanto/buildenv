import subprocess
import os
import sys

project_root = sys.argv[1] if len(sys.argv) > 1 else os.getcwd()
current_dir = os.path.dirname(__file__)

subprocess.run(f'"{current_dir}/premake/premake5" vs2022 --file={current_dir}/build.lua --root={project_root}')