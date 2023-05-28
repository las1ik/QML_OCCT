TEMPLATE = app
QT += qml quick core gui opengl widgets

CONFIG += c++17


QML_IMPORT_PATH =
QML_DESIGNER_IMPORT_PATH =

RESOURCES += qml.qrc \
    qml.qrc

DEFINES += QT_DEPRECATED_WARNINGS

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

!contains(QMAKE_TARGET.arch, x86_64) {
	ARCH_BITS_SIZE = 32
	DEFINES += _OCC32
} else {
	ARCH_BITS_SIZE = 64
	DEFINES += _OCC64
}

INCLUDEPATH +=D:/qtyrov/build7.6.0MinGW81+qt5.x/inc

isEmpty(OCCT_INCLUDE_DIR):OCCT_INCLUDE_DIR = $$(CSF_OCCTIncludePath)
isEmpty(OCCT_LIBRARY_DIR):OCCT_LIBRARY_DIR = $$(CSF_OCCTLibPath)

INCLUDEPATH += $$OCCT_INCLUDE_DIR

LIBS += "$$join(OCCT_LIBRARY_DIR, " -L", -L)"

win32-g++ {
LIBS +=-LD:/qtyrov/build7.6.0MinGW81+qt5.x/MinGW81/libd


LIBS +=     \
-llibTKBin.dll     \
-llibTKBinL.dll    \
-llibTKBinTObj.dll \
-llibTKBinXCAF.dll \
-llibTKBO.dll      \
-llibTKBool.dll    \
-llibTKBRep.dll    \
-llibTKCAF.dll     \
-llibTKCDF.dll     \
-llibTKDCAF.dll    \
-llibTKDraw.dll    \
-llibTKernel.dll   \
-llibTKFeat.dll    \
-llibTKFillet.dll  \
-llibTKG2d.dll     \
-llibTKG3d.dll     \
-llibTKGeomAlgo.dll \
-llibTKGeomBase.dll \
-llibTKHLR.dll     \
-llibTKIGES.dll    \
-llibTKLCAF.dll    \
-llibTKMath.dll    \
-llibTKMesh.dll    \
-llibTKMeshVS.dll  \
-llibTKOffset.dll  \
-llibTKOpenGl.dll  \
-llibTKPrim.dll    \
-llibTKQADraw.dll  \
-llibTKService.dll \
-llibTKShHealing.dll \
-llibTKStd.dll     \
-llibTKStdL.dll    \
-llibTKSTEP.dll    \
-llibTKSTEP209.dll \
-llibTKSTEPAttr.dll \
-llibTKSTEPBase.dll \
-llibTKSTL.dll     \
-llibTKTObj.dll    \
-llibTKTObjDRAW.dll \
-llibTKTopAlgo.dll \
-llibTKTopTest.dll \
-llibTKV3d.dll     \
-llibTKVCAF.dll    \
-llibTKViewerTest.dll \
-llibTKVRML.dll    \
-llibTKXCAF.dll    \
-llibTKXDEDRAW.dll \
-llibTKXDEIGES.dll \
-llibTKXDESTEP.dll \
-llibTKXml.dll     \
-llibTKXmlL.dll   \
-llibTKXmlTObj.dll \
-llibTKXmlXCAF.dll \
-llibTKXSBase.dll  \
-llibTKXSDRAW.dll
}

else:win32-msvc*:  {
# LIBS +=-LD:/Cascade/occt760build/vc16/lib
  LIBS +=-LD:/Cascade/occt760build/vc16/libd
LIBS +=     \
-lTKBin     \
-lTKBinL    \
-lTKBinTObj \
-lTKBinXCAF \
-lTKBO      \
-lTKBool    \
-lTKBRep    \
-lTKCAF     \
-lTKCDF     \
-lTKDCAF    \
-lTKDraw    \
-lTKernel   \
-lTKFeat    \
-lTKFillet  \
-lTKG2d     \
-lTKG3d     \
-lTKGeomAlgo \
-lTKGeomBase \
-lTKHLR     \
-lTKIGES    \
-lTKLCAF    \
-lTKMath    \
-lTKMesh    \
-lTKMeshVS  \
-lTKOffset  \
-lTKOpenGl  \
-lTKPrim    \
-lTKQADraw  \
-lTKService \
-lTKShHealing \
-lTKStd     \
-lTKStdL    \
-lTKSTEP    \
-lTKSTEP209 \
-lTKSTEPAttr \
-lTKSTEPBase \
-lTKSTL     \
-lTKTObj    \
-lTKTObjDRAW \
-lTKTopAlgo \
-lTKTopTest \
-lTKV3d     \
-lTKVCAF    \
-lTKViewerTest \
-lTKVRML    \
-lTKXCAF    \
-lTKXDEDRAW \
-lTKXDEIGES \
-lTKXDESTEP \
-lTKXml     \
-lTKXmlL    \
-lTKXmlTObj \
-lTKXmlXCAF \
-lTKXSBase  \
-lTKXSDRAW
}

win32: LIBS += -luser32 -lopengl32

HEADERS += OcctView.h	
SOURCES += main.cpp OcctView.cpp

DISTFILES +=

