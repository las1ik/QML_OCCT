import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import OpenCascade 7.6

Dialog {
    id: dialog
    title: "Размеры блока и его положение"
    width: 250
    height: 300
    standardButtons:  StandardButton.Ok|StandardButton.Cancel|StandardButton.RestoreDefaults

    property real m_X
    property real m_Y
    property real m_Z
    property real m_A
    property real m_B
    property real m_C

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
            text: "Длина:"
        }
        TextField {
            id: nameFieldA
            width: parent.width
            placeholderText: "a:"
        }

        Text {
            text: "Ширина:"
        }
        TextField {
            id: nameFieldB
            width: parent.width
            placeholderText: "b:"
        }
        Text {
            text: "Высота:"
        }
        TextField {
            id: nameFieldC
            width: parent.width
            placeholderText: "c:"
        }

    }

    onButtonClicked: {
        if (clickedButton === StandardButton.Ok) {
            m_X = nameFieldX.text
            m_Y = nameFieldY.text
            m_Z = nameFieldZ.text
            m_A = nameFieldA.text
            m_B = nameFieldB.text
            m_C = nameFieldC.text
            console.log("A:", m_A, "B:", m_B, "C:", m_C)

        } else if (clickedButton === StandardButton.Cancel) {
            m_A = 0; m_B = 0; m_C = 0
            console.log("A:", m_A, "B:", m_B, "C:", m_C)
        } else if (clickedButton === StandardButton.RestoreDefaults) {
            m_X = 1
            m_Y = 1
            m_Z = 1
            m_A = 1
            m_B = 1
            m_C = 1
            console.log("Установленны значения по умолчанию(1)")
            dialog.accepted()
            dialog.close()
        }
    }


}
