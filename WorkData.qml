import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import OpenCascade 7.6
import QtQuick.Dialogs 1.3


Rectangle {
    id: rootRectangle
    width: mainWindow.width
    anchors {
        top: mainWindow.top
        left: mainWindow.left
        right: mainWindow.right
        bottom: mainWindow.bottom
    }

    DialogCircle {
        id: myDialogCircle
    }

    DialogBlock {
        id: myDialogBlock
    }

    DialogLine{
        id: myDialogLine
    }
    DialogModel{
        id: myDialogModel
    }
    Rectangle {
        id: rectmain
        color: "#404142"
        anchors.top: parent.bottom
        y:0
        width: parent.width
        height: 40

        Button{
            id: rect1
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            onClicked: {
                myDialogModel.open()
                myDialogModel.accepted.connect(function() {
                    var scale = parseFloat(myDialogModel.m_scale)

                    x = myDialogModel.m_X
                    y = myDialogModel.m_Y
                    z = myDialogModel.m_Z
                    openCascade.createModel(x, y, z, scale)
                })
            }
                background: Rectangle{
                    color: "#404142"
                    border.color: "#121111"
                    border.width: 1
                    }
                Text {
                     color: "black"
                     text: "Model"
                     anchors.centerIn: parent
                }
            }
        Button{
            id: rect2
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: rect1.right
            onClicked: {
                myDialogCircle.open()
                myDialogCircle.accepted.connect(function() {
                    var radius = parseFloat(myDialogCircle.m_R)

                    x = myDialogCircle.m_X
                    y = myDialogCircle.m_Y
                    z = myDialogCircle.m_Z
                    openCascade.createSphere(x, y, z, radius)
                })
            }
                background: Rectangle{
                    color: "#404142"
                    border.color: "#121111"
                    border.width: 1
                    }
                Text {
                     color: "black"
                     text: "Sphare"
                     anchors.centerIn: parent
                }
            }
        Button{
            id: rect3
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: rect2.right
            onClicked: {
                myDialogBlock.open()
                myDialogBlock.accepted.connect(function() {
                    var A = parseFloat(myDialogBlock.m_A)
                    var B = parseFloat(myDialogBlock.m_B)
                    var C = parseFloat(myDialogBlock.m_C)

                    x = myDialogBlock.m_X
                    y = myDialogBlock.m_Y
                    z = myDialogBlock.m_Z
                    openCascade.createBlock(x, y, z, A, B, C)
                })
            }
            background: Rectangle{
                color: "#404142"
                border.color: "#121111"
                border.width: 1
                }
            Text {
                 color: "black"
                 text: "Box"
                 anchors.centerIn: parent
            }
            }
        Button{
            id: rect4
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: rect3.right
            onClicked: {
                myDialogLine.open()
                myDialogLine.accepted.connect(function() {
                    var x1_1 = parseFloat(myDialogLine.m_X1_1)
                    var y1_1 = parseFloat(myDialogLine.m_Y1_1)
                    var z1_1 = parseFloat(myDialogLine.m_Z1_1)
                    var x2_1 = parseFloat(myDialogLine.m_X2_1)
                    var y2_1 = parseFloat(myDialogLine.m_Y2_1)
                    var z2_1 = parseFloat(myDialogLine.m_Z2_1)
                    var x3_1 = parseFloat(myDialogLine.m_X3_1)
                    var y3_1 = parseFloat(myDialogLine.m_Y3_1)
                    var z3_1 = parseFloat(myDialogLine.m_Z3_1)

                    var x1_2 = parseFloat(myDialogLine.m_X1_2)
                    var y1_2 = parseFloat(myDialogLine.m_Y1_2)
                    var z1_2 = parseFloat(myDialogLine.m_Z1_2)
                    var x2_2 = parseFloat(myDialogLine.m_X2_2)
                    var y2_2 = parseFloat(myDialogLine.m_Y2_2)
                    var z2_2 = parseFloat(myDialogLine.m_Z2_2)
                    var x3_2 = parseFloat(myDialogLine.m_X3_2)
                    var y3_2 = parseFloat(myDialogLine.m_Y3_2)
                    var z3_2 = parseFloat(myDialogLine.m_Z3_2)

                    x = myDialogLine.m_X1_1

                    openCascade.intersectionLine( x1_1, y1_1, z1_1,
                                                  x2_1, y2_1, z2_1,
                                                  x3_1, y3_1, z3_1,
                                                  x1_2, y1_2, z1_2,
                                                  x2_2, y2_2, z2_2,
                                                  x3_2, y3_2, z3_2)
                })
            }
            background: Rectangle{
                color: "#404142"
                border.color: "#121111"
                border.width: 1
                }
            Text {
                 color: "black"
                 text: "Line"
                 anchors.centerIn: parent
            }
            }
        Button{
            id: rect5
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: rect4.right
            onClicked: openCascade.erase();
            background: Rectangle{
                color: "#404142"
                border.color: "#121111"
                border.width: 1
                }
            Text {
                 color: "black"
                 text: "Delete"
                 anchors.centerIn: parent
            }
        }
        Button{
            id: rect6
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: rect5.right
            onClicked: openCascade.open();
            background: Rectangle{
                color: "#404142"
                border.color: "#121111"
                border.width: 1
                }
            Text {
                 color: "black"
                 text: "Open"
                 anchors.centerIn: parent
            }
        }
        Button{
            id: rect7
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.left: rect6.right
            onClicked: openCascade.save();
            background: Rectangle{
                color: "#404142"
                border.color: "#121111"
                border.width: 1
                }
            Text {
                 color: "black"
                 text: "Save"
                 anchors.centerIn: parent
            }
        }
    }

    OcctView {
        id: openCascade
        anchors.fill: myMA
        onOccViewChanged: mainWindow.update()
    }

    MouseArea {
        id: myMA
        x:0
        y:40
        width: mainWindow.width
        height: mainWindow.height - 80
        acceptedButtons:  Qt.AllButtons

        onClicked:
        {
//            if (myDialogCircle.m_R > 0)
//            {
//                console.log("  x: ",x," y: ",y)
//                x = myDialogCircle.m_X
//                y = myDialogCircle.m_Y
//                z = myDialogCircle.m_Z
//                radius = myDialogCircle.m_R
//                openCascade.createSphere(x,y,z,radius)
//            }

//            if (myDialogBlock.m_A > 0 && myDialogBlock.m_B && myDialogBlock.m_C)
//            {
//                console.log("  x: ",x," y: ",y)
//                x = myDialogBlock.m_X
//                y = myDialogBlock.m_Y
//                z = myDialogBlock.m_Z
//                openCascade.createBlock(x,y,z,myDialogBlock.m_A,
//                                              myDialogBlock.m_B,
//                                              myDialogBlock.m_C);
//            }
           // x = mouse.x
           // y = mouse.y
           // z = 0
           // console.log("  x: ",mouse.x," y: ",mouse.y, " z: ", z)

        }
        onPressed: {
            openCascade.mousePress(mouse.x, mouse.y, mouse.buttons)
        }
        onReleased: {
            openCascade.mouseRelease(mouse.x, mouse.y, mouse.buttons)
        }
        onWheel: {
            openCascade.mouseWheel(wheel.x, wheel.y, wheel.angleDelta.y, wheel.buttons)
        }
        onPositionChanged: {
            openCascade.mouseMove(mouse.x, mouse.y, mouse.buttons)
        }

    }
    Rectangle {
        id: myrect
        radius: 10
        border.width: 2
        border.color: "white"
        y: mainWindow.height-40
        height: 40
        width: mainWindow.width
        Row{
            anchors.centerIn: parent
            spacing: 5
            Text {
                    id: label
                    color: "black"
                    text: "Вариант 18. Никитченко.  Длинна линии пересечения:"

                }
            Text {
                text:openCascade.resultValue.toFixed(4)
            }
        }

    }


}
