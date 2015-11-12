import subprocess
from os.path import expanduser
home = expanduser("~")

def get_password():
    return subprocess.check_output(["gpg", "-dq", home+"/.passwd.gpg"]).strip()
