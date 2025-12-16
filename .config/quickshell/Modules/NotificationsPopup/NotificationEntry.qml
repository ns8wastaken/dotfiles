pragma ComponentBehavior: Bound

import Quickshell.Services.Notifications
import QtQuick
import qs.Components
import qs.Config
import qs.Theme

Rectangle {
    id: root

    required property Notification modelData

    width: Config.notifications.width
    height: Config.notifications.height

    color: Theme.backgroundPrimary

    border.color: Theme.outline
    border.width: 1

    radius: 12

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.dismiss()
    }

    // Image (used if it has one)
    Component {
        id: realImage
        RoundedImage {
            width: row.height - 2 * Config.notifications.popupMargins
            height: row.height - 2 * Config.notifications.popupMargins
            image.fillMode: Image.PreserveAspectFit
            image.source: root.modelData.image
            radius: 8
        }
    }

    // Svg Icon (used if there is no image)
    Component {
        id: fallbackIcon
        SvgIcon {
            size: row.height - 2 * Config.notifications.popupMargins
            source: "bell.svg"
            color: Theme.textPrimary
        }
    }

    // Notification
    Row {
        id: row

        width: parent.width
        height: parent.height

        padding: Config.notifications.popupMargins
        spacing: Config.notifications.popupMargins

        // Image
        Loader {
            id: iconLoader
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: root.modelData.image !== ""
                ? realImage
                : fallbackIcon;
        }

        // Notification contents
        Column {
            anchors.verticalCenter: parent.verticalCenter

            width: root.width - iconLoader.width - Config.notifications.popupMargins * 3

            // Title
            Text {
                width: parent.width

                text: root.modelData.summary

                font.family: Config.fonts.sans
                font.pixelSize: Config.fontSizeNormal
                font.bold: true

                color: Theme.textPrimary

                elide: Text.ElideRight
            }

            // Body
            Text {
                width: parent.width

                text: root.modelData.body

                font.family: Config.fonts.sans
                font.pixelSize: Config.fontSizeSmall

                color: Theme.textPrimary

                maximumLineCount: 2
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                elide: Text.ElideRight
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        onTriggered: root.expire()
    }

    NumberAnimation {
        // id: slideIn
        target: root
        property: "x"
        from: Config.notifications.width
        to: 0
        duration: 150
        easing.type: Easing.OutCubic
        running: true
    }

    NumberAnimation {
        id: slideOutExpire
        target: root
        property: "x"
        from: 0
        to: Config.notifications.width
        duration: 150
        easing.type: Easing.InCubic
        onStopped: root.modelData.expire()
        running: false
    }

    NumberAnimation {
        id: slideOutDismiss
        target: root
        property: "x"
        from: 0
        to: Config.notifications.width
        duration: 150
        easing.type: Easing.InCubic
        onStopped: root.modelData.expire()
        running: false
    }

    function expire() { slideOutExpire.start(); }
    function dismiss() { slideOutDismiss.start(); }
}
