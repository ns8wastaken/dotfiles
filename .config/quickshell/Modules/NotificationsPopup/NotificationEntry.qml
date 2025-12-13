pragma ComponentBehavior: Bound

import QtQuick
import qs.Components
import qs.Settings

Rectangle {
    id: root

    required property var modelData

    width: Settings.notifications.width
    height: Settings.notifications.height

    color: Theme.backgroundPrimary

    border {
        color: Theme.outline
        width: 1
    }

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
            width: row.height - 2 * Settings.notifications.popupMargins
            height: row.height - 2 * Settings.notifications.popupMargins
            image.fillMode: Image.PreserveAspectFit
            image.source: root.modelData.image
            color: Theme.backgroundPrimary
            radius: 8
        }
    }

    // Svg Icon (used if there is no image)
    Component {
        id: fallbackIcon
        SvgIcon {
            size: row.height - 2 * Settings.notifications.popupMargins
            source: "bell.svg"
            color: Theme.textPrimary
        }
    }

    // Notification
    Row {
        id: row

        width: parent.width
        height: parent.height

        padding: Settings.notifications.popupMargins
        spacing: Settings.notifications.popupMargins

        // Image
        Loader {
            id: iconLoader
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: root.modelData.image !== ""
                ? realImage
                : fallbackIcon
        }

        // Notification contents
        Column {
            anchors.verticalCenter: parent.verticalCenter

            width: root.width - iconLoader.width - Settings.notifications.popupMargins * 3

            // Title
            Text {
                width: parent.width

                text: root.modelData.summary

                font.family: Settings.notifications.fontFamily
                font.pixelSize: Settings.fontSizeNormal
                font.bold: true

                color: Theme.textPrimary

                elide: Text.ElideRight
            }

            // Body
            Text {
                width: parent.width

                text: root.modelData.body

                font.family: Settings.notifications.fontFamily
                font.pixelSize: Settings.fontSizeSmall

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

    NumberAnimation on x {
        // id: slideIn
        from: Settings.notifications.width
        to: 0
        duration: 150
        easing.type: Easing.OutCubic
        running: true
    }

    NumberAnimation on x {
        id: slideOutExpire
        from: 0
        to: Settings.notifications.width
        duration: 150
        easing.type: Easing.InCubic
        onStopped: root.modelData.expire()
        running: false
    }

    NumberAnimation on x {
        id: slideOutDismiss
        from: 0
        to: Settings.notifications.width
        duration: 150
        easing.type: Easing.InCubic
        onStopped: root.modelData.expire()
        running: false
    }

    function expire() { slideOutExpire.start(); }
    function dismiss() { slideOutDismiss.start(); }
}
