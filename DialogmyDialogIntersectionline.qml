import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import OpenCascade 7.6

Dialog {
    id: myDialogLine
    title: "Построить модель"
    width: 250
    height: 300
    standardButtons:  StandardButton.Ok|StandardButton.Cancel

    property real m_X
    property real m_Y
    property real m_Z
    property real m_Col



    Column {
        anchors.fill: parent
        spacing: 10
        Text {
            text: "Координаты объекта:"
        }
        TextField {
            id: nameFieldX
            width: parent.width
            placeholderText: "X:"
        }

        TextField {
            id: nameFieldY
            width: parent.width
            placeholderText: "Y:"
        }
        TextField {
            id: nameFieldZ
            width: parent.width
            placeholderText: "Z:"
        }
    }
    onButtonClicked: {
        if (clickedButton === StandardButton.Ok) {
            m_X = nameFieldX.text
            m_Y = nameFieldY.text
            m_Z = nameFieldZ.text
            console.log("X:", m_X, "Y:", m_Y, "Z:", m_Z)
        }
        else {
            var openCascade = Qt.binding(function() { return openCascade });
            openCascade.createDemoScene();
            }
    }
}
