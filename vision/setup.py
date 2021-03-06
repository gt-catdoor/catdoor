"""
This is a setup.py script generated by py2applet

Usage:
    python3 setup.py py2app
"""
import os, sys
from setuptools import setup
# from cx_Freeze import setup,Executable

# os.environ['TCL_LIBRARY'] = "./mylabelimage/Contents/lib/8.5"

APP = ['catdoor.py']
DATA_FILES = []
OPTIONS = {"packages":["numpy", "tensorflow", "cv2", "PIL", "pyscreenshot", "tkinter", "serial"], \
"resources":[os.getcwd() + "/output_labels.txt", os.getcwd() + "/output_graph.pb", os.getcwd() + "/serviceaccount.json", os.getcwd() + "/logo.jpg"],
'iconfile':'icon.icns'}

setup(
    app=APP,		
    data_files=DATA_FILES,
    options={'py2app': OPTIONS},
    setup_requires=['py2app'],
    install_requires=['firebase_admin', 'google-cloud-firestore']
)
