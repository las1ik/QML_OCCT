import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import OpenCascade 7.6

Dialog {

    title: "Положение модели и масштаб"
    width: 250
    height: 300
    standardButtons:  StandardButton.Ok|StandardButton.Cancel

    property real m_X
    property real m_Y
    property real m_Z
    property real m_scale

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
            text: "Scale:"
        }
        TextField {
            id: nameFieldscale
            width: parent.width
            placeholderText: "scale:"
        }
    }

    onButtonClicked: {
        if (clickedButton === StandardButton.Ok) {
            m_X = nameFieldX.text
            m_Y = nameFieldY.text
            m_Z = nameFieldZ.text
            if(nameFieldscale.text >= 1){
                m_scale = nameFieldscale.text
                console.log("Scale:", m_scale)
            }
            else{
                m_scale = 1
                console.log("Веденное значение scale недопустимо, установленно значение по умолчанию(1)")
            }
            console.log("X:", m_X, "Y:", m_Y, "Z:", m_Z)

        } else {
            m_X = 0; m_Y = 0; m_Z = 0
            console.log("X:", m_X, "Y:", m_Y, "Z:", m_Z)
        }
    }


}
