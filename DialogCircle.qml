import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import OpenCascade 7.6

Dialog {

    title: "Размеры сферы и ее положение"
    width: 250
    height: 300
    standardButtons:  StandardButton.Ok|StandardButton.Cancel

    property real m_X
    property real m_Y
    property real m_Z
    property real m_R

    Column {
        anchors.fill: parent
        spacing: 10
        Text {
            text: "X:"
        }
        TextField {
            id: nameFieldX
            width: parent.width
            placeholderText: "x:"
        }

        Text {
            text: "Y:"
        }
        TextField {
            id: nameFieldY
            width: parent.width
            placeholderText: "y:"
        }
        Text {
            text: "Z:"
        }
        TextField {
            id: nameFieldZ
            width: parent.width
            placeholderText: "z:"
        }
        Text {
            text: "Радиус объекта:"
        }
        TextField {
            id: nameFieldRadius
            width: parent.width
            placeholderText: "Радиус:"
        }

    }

    onButtonClicked: {
        if (clickedButton === StandardButton.Ok) {
            m_X = nameFieldX.text
            m_Y = nameFieldY.text
            m_Z = nameFieldZ.text
            m_R = nameFieldRadius.text
            console.log( "m_R:", m_R)

        } else {
            m_R = 0;
            console.log("m_R:", m_R)
        }
    }


}
