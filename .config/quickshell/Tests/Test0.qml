import Quickshell
import QtQuick
import qs.Managers.Types

FloatingWindow {
    id: root

    color: "#181818"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: loader.toggle()
    }

    Text {
        text: "Click the screen"
        anchors.centerIn: parent
        font.pointSize: 24
        color: "#ffffff"
    }

    WmLoader {
        id: loader

        handle: "test0"
        anchors.centerIn: parent

        sourceComponent: WmWindow {
            Component.onCompleted: console.log("opened")
            onWmFocused: console.log("focused")
            onWmUnfocused: console.log("unfocused")

            color: "#ff0000"
            opacity: 0.6

            width: 100
            height: 100
            radius: 16
        }
    }
}
