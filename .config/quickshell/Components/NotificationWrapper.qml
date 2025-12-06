pragma ComponentBehavior: Bound

import QtQuick
import qs.Components
import qs.Settings

MouseArea {
    id: root

    required property var modelData

    implicitWidth: 400 - (2 * Settings.notificationPadding)
    implicitHeight: 100 - (2 * Settings.notificationPadding)
    cursorShape: Qt.PointingHandCursor

    property real textWidth: width - height - row.spacing

    onClicked: modelData.dismiss()

    Row {
        id: row

        width: parent.implicitWidth
        height: parent.implicitHeight

        spacing: Settings.notificationPadding

        Loader {
            active: root.modelData.image != ""
            visible: active

            height: parent.height
            width: parent.height

            sourceComponent: RoundedImage {
                height: parent.height
                width: parent.height
                fillMode: Image.PreserveAspectFit
                source: root.modelData.image
                radius: 8
            }
        }

        Loader {
            id: svgIcon
            active: root.modelData.image == ""
            visible: active
            height: parent.height
            width: parent.height
            sourceComponent: Item {
                SvgIcon {
                    anchors.centerIn: parent
                    size: parent.height * 0.8
                    source: "fa_bell.svg"
                    color: "#ff0000"
                }
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            // Title
            Text {
                text: root.modelData.summary

                font.bold: true
                color: "#ff0000"
                font.pixelSize: Settings.fontSizeLarge
                width: root.textWidth
                elide: Text.ElideRight
            }

            // Body
            Text {
                text: root.modelData.body

                color: "#ff0000"
                font.pixelSize: Settings.fontSizeNormal
                elide: Text.ElideRight
                width: root.textWidth
            }
        }
    }
}
