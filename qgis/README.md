## Configure PyCharm Interpreter Path

Open PyCharm community in your computer and Open the existing project e.g.
D:\ProjectFolder

- Select and then click OK to open the project in PyCharm
- Click on “Trust the project” if asked.
- Project will be opened and will be displayed on the left side menu under Project Tab.
- Click on Settings on the top right corner (as shown in following picture).
- The setting dialogue box will appear on your screen
- In settings dialogue box select Project > Python Interpreter > Add Interpreter > Add Local Interpreter
- Click on Virtualenv Environment > Existing
- Click on three dots to browse to the following path:

```bash
C:\Program Files\QGIS 3.22.16\apps\Python39\python.exe
```

- Click ok to set path and ok another time to add interpreter.


## Configure PyCharm Interpreter Custom Paths


- You can see the setting option in front of python interpreter selection drop down menu and click on “Show All”.
- Right click on Python 3.9 and click on “Show Interpreter Paths”
- Click on Plus icon, add the following path and click OK.

```bash
C:\Program Files\QGIS 3.22.16\apps\Python39\python.exe
C:\Program Files\QGIS 3.22.16\apps\qgis-ltr\bin
C:\Program Files\QGIS 3.22.16\apps\qgis-ltr\python
C:\Program Files\QGIS 3.22.16\apps\qgis-ltr\python\plugins
C:\Program Files\QGIS 3.22.16\apps\qgis-ltr\python\plugins\processing
C:\Program Files\QGIS 3.22.16\apps\qgis-ltr\python\plugins\processing\core
C:\Program Files\QGIS 3.22.16\apps\qgis-ltr\python\plugins\processing\algs\qgis
```

## Test the Installation

Verify if all dependencies by running the imports.py script.

- Restart PyCharm
- Run the imports.py file in the project:

```bash
python imports.py
```
