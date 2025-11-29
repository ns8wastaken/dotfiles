import QtQuick
import qs.Components
import qs.Settings

MouseArea {
    id: root

    required property var modelData

    width: 400 - (2 * Settings.notificationPadding)
    height: 100 - (2 * Settings.notificationPadding)
    cursorShape: Qt.PointingHandCursor

    property real textWidth: width - height - row.spacing

    onClicked: modelData.dismiss()

    Row {
        id: row

        width: parent.width
        height: parent.height

        spacing: Settings.notificationPadding

        // Rectangle {
        //     anchors.fill: parent
        //     color: "#0000ff"
        // }

        Loader {
            active: modelData.image != ""
            visible: active

            height: parent.height
            width: parent.height

            sourceComponent: RoundedImage {
                height: parent.height
                width: parent.height
                fillMode: Image.PreserveAspectFit
                source: modelData.image
                radius: 8
            }
        }

        // Loader {
        //     id: svgIcon
        //     active: modelData.image == ""
        //     visible: active
        //     height: parent.height
        //     width: parent.height
        //     sourceComponent: Item {
        //         SvgIcon {
        //             anchors.centerIn: parent
        //             size: parent.height * 0.8
        //             source: "fa_bell.svg"
        //             color: "#ff0000"
        //         }
        //     }
        // }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: modelData.summary
                font.bold: true
                color: "#ff0000"
                font.pixelSize: Settings.fontSizeLarge
                width: root.textWidth
                elide: Text.ElideRight
            }

            Text {
                text: modelData.body
                color: "#ff0000"
                font.pixelSize: Settings.fontSizeNormal
                elide: Text.ElideRight
                width: root.textWidth
            }
        }
    }
}
