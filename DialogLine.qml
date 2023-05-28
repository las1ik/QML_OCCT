import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import OpenCascade 7.6

Dialog {
    id: dialog
    title: "Расположение треугольников"
    width: 250
    height: 600
    standardButtons:  StandardButton.Ok|StandardButton.Cancel|StandardButton.RestoreDefaults

    property real m_X1_1
    property real m_Y1_1
    property real m_Z1_1
    property real m_X2_1
    property real m_Y2_1
    property real m_Z2_1
    property real m_X3_1
    property real m_Y3_1
    property real m_Z3_1

    property real m_X1_2
    property real m_Y1_2
    property real m_Z1_2
    property real m_X2_2
    property real m_Y2_2
    property real m_Z2_2
    property real m_X3_2
    property real m_Y3_2
    property real m_Z3_2
    Text {
        id: txt1
        text: "Координаты точек треугольника №1:"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }
    Rectangle{
        id: col1
        width: parent.width
        height: 225
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txt1.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        Column {
            anchors.centerIn: parent
            spacing: 10

            Row {
               spacing: 10
               TextField { id: fieldX1_1; width: 50; height: 50; placeholderText: "X1" }

               TextField { id: fieldY1_1; width: 50; height: 50;  placeholderText: "Y1" }

               TextField { id: fieldZ1_1; width: 50; height: 50;  placeholderText: "Z1" }
            }

            Row {
               spacing: 10
               TextField { id: fieldX2_1; width: 50; height: 50;  placeholderText: "X2" }

               TextField { id: fieldY2_1;width: 50; height: 50;  placeholderText: "Y2" }

               TextField { id: fieldZ2_1;width: 50; height: 50;  placeholderText: "Z2" }
            }

            Row {
               spacing: 10

               TextField { id: fieldX3_1; width: 50; height: 50;  placeholderText: "X3" }

               TextField { id: fieldY3_1; width: 50; height: 50;  placeholderText: "Y3" }

               TextField { id: fieldZ3_1; width: 50; height: 50;  placeholderText: "Z3" }
            }
        }
    }
    Text {
        id: txt2
        text: "Координаты точек треугольника №2:"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: col1.bottom
        anchors.topMargin: 10
    }
    Rectangle{
        width: parent.width
        height: 225
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txt2.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        Column {
            anchors.centerIn: parent
            spacing: 10

            Row {
               spacing: 10
               TextField { id: fieldX1_2; width: 50; height: 50; placeholderText: "X1" }

               TextField { id: fieldY1_2; width: 50; height: 50;  placeholderText: "Y1" }

               TextField { id: fieldZ1_2; width: 50; height: 50;  placeholderText: "Z1" }
            }

            Row {
               spacing: 10
               TextField { id: fieldX2_2; width: 50; height: 50;  placeholderText: "X2" }

               TextField { id: fieldY2_2;width: 50; height: 50;  placeholderText: "Y2" }

               TextField { id: fieldZ2_2;width: 50; height: 50;  placeholderText: "Z2" }
            }

            Row {
               spacing: 10

               TextField { id: fieldX3_2; width: 50; height: 50;  placeholderText: "X3" }

               TextField { id: fieldY3_2; width: 50; height: 50;  placeholderText: "Y3" }

               TextField { id: fieldZ3_2; width: 50; height: 50;  placeholderText: "Z3" }
            }
        }
    }

    onButtonClicked: {
        if (clickedButton === StandardButton.Ok) {
            m_X1_1 = parseFloat(fieldX1_1.text)
            m_Y1_1 = parseFloat(fieldY1_1.text)
            m_Z1_1 = parseFloat(fieldZ1_1.text)
            m_X2_1 = parseFloat(fieldX2_1.text)
            m_Y2_1 = parseFloat(fieldY2_1.text)
            m_Z2_1 = parseFloat(fieldZ2_1.text)
            m_X3_1 = parseFloat(fieldX3_1.text)
            m_Y3_1 = parseFloat(fieldY3_1.text)
            m_Z3_1 = parseFloat(fieldZ3_1.text)

            m_X1_2 = parseFloat(fieldX1_2.text)
            m_Y1_2 = parseFloat(fieldY1_2.text)
            m_Z1_2 = parseFloat(fieldZ1_2.text)
            m_X2_2 = parseFloat(fieldX2_2.text)
            m_Y2_2 = parseFloat(fieldY2_2.text)
            m_Z2_2 = parseFloat(fieldZ2_2.text)
            m_X3_2 = parseFloat(fieldX3_2.text)
            m_Y3_2 = parseFloat(fieldY3_2.text)
            m_Z3_2 = parseFloat(fieldZ3_2.text)
            console.log( "X:", m_X1_2, m_X1_2)

        } else if (clickedButton === StandardButton.Cancel) {
            console.log(000)
            dialog.close()
        }else if (clickedButton === StandardButton.RestoreDefaults) {
            m_X1_1 = 101
            m_Y1_1 = 111
            m_Z1_1 = 121
            m_X2_1 = 223
            m_Y2_1 = 121
            m_Z2_1 = 151
            m_X3_1 = 142
            m_Y3_1 = 151
            m_Z3_1 = 171

            m_X1_2 = 266
            m_Y1_2 = 155
            m_Z1_2 = 161
            m_X2_2 = 131
            m_Y2_2 = 121
            m_Z2_2 = 131
            m_X3_2 = 121
            m_Y3_2 = 112
            m_Z3_2 = 161
            console.log(m_X1_1)
            dialog.accepted()
            dialog.close()
        }
    }
}
