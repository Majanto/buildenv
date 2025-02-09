import sys
from os import path
buildenv_path = path.dirname(path.dirname(path.abspath(__file__)))
sys.path.append(buildenv_path)

import buildenv

buildenv.setup(f'{buildenv_path}/tests/simpleapp', f'Main', f'{buildenv_path}/tests/simpleapp/code')