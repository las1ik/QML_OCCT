import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.12


//MenuBar {
//    id: menu
//    width: win.width
//    height: 20
//    Menu {
//       title: "File"
//       MenuItem  { text: "&New"}
//       MenuItem  { text: "&Open" }
//       MenuItem  { text: qsTr("&Save") }
//       MenuItem  { text: qsTr("Save &As") }
//       MenuSeparator { }
//       MenuItem  { text: qsTr("&Quit")
//           onTriggered: Qt.quit();}
//    }
//    Menu {
//       title: "Edit"
//       MenuItem  { text: qsTr("Cu&t") }
//       MenuItem  { text: qsTr("&Copy") }
//       MenuItem  { text: qsTr("&Paste") }
//    }
//    Menu {
//       title: "Help"
//       MenuItem { text: qsTr("&About")
//           onTriggered: {about.show();}
//       }
//    }

//    delegate: MenuBarItem {
//        id: menuBarItem
//        width: win.width
//        height: parent.height
//        contentItem: Text {
//            text: menuBarItem.text
//            color: "white"
//            font.family: "Arial"
//            font.pixelSize: 8
//        }
//    }

//    background: Rectangle {
//        id: rectback
//        width: menu.width
//        height: parent.height
//        implicitWidth: menu.width
//        implicitHeight: parent.height
//        color: "#202020"

//    }
//}
ApplicationWindow {
    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem { text: "Open..." }
            MenuItem { text: "Close" }
        }

        Menu {
            title: "Edit"
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }
    }
}

