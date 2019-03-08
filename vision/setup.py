import os, sys
from cx_Freeze import setup,Executable

os.environ['TCL_LIBRARY'] = "C:\\Users\\woner\\AppData\\Local\\Programs\\Python\\Python36\\tcl\\tcl8.6"
os.environ['TK_LIBRARY'] = "C:\\Users\\woner\\AppData\\Local\\Programs\\Python\\Python36\\tcl\\tk8.6"

build_exe_options = dict(


        includes = ["sys","os","lxml","re","tkinter", os.getcwd() + "/converter"],

        include_files = [os.getcwd() + "/tcl86t.dll", os.getcwd() + "/tk86t.dll", os.getcwd() + "/test.xml", \
        os.getcwd() + "/VCRUNTIME140.dll", os.getcwd() + "/test.xsl", os.getcwd() + "/PIC0.jpg", os.getcwd() + "/PIC1.png", \
        os.getcwd() + '/PIChankook_atlasbx.jpg', os.getcwd() + '/PIChankook_group.jpg', os.getcwd() + '/PIChankook_inovative.jpg' ]

)

 

base = None

if sys.platform == "win32":

    base = "Win32GUI"

 

setup(

    name = "한타 출원 보고서 생성기",

    varsion = "1.0",

    author="jumong",

    description = "make xml and xsl files for hwp",

    options = {"build_exe": build_exe_options},

    executables = [Executable("gui.py", base = base, targetName="한타 출원보고서 생성기.exe")]

)

