# QML_OCCT
Simple example integrating OpenCASCADE into QML
opencascade 7.6

qt 5.15.2 MinGW 64-bit

qmake

compile opencascade7.6

Link on occt executable files: https://drive.google.com/file/d/1DONwr5bpLlDS7oma03epuSpmZT-_GLu7/view?usp=sharing

X: \...\ - your way to "build7.6.0MinGW81+qt5.x" folder

	1.Open "Projects" tab, in field "Build Environment"add to PATH:
				X:...\build7.6.0MinGW81+qt5.x\3rd party\MinGW
				X:...\build7.6.0MinGW81+qt5.x\inc
				X:...\build7.6.0MinGW81+qt5.x\MinGW81\bin
				X:...\build7.6.0MinGW81+qt5.x\MinGW81\libd

	2.Edit QML_OCCT.pro file:
				INCLUDEPATH +=X:/.../build7.6.0MinGW81+qt5.x/inc
				LIBS +=-LX:/.../build7.6.0MinGW81+qt5.x/MinGW81/libd

License

GNU Lesser General Public License 3.0
