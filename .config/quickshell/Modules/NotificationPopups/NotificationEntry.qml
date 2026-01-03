pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import qs.Components
import qs.Config
import qs.Theme

Rectangle {
    id: root

    required property Notification modelData
    readonly property int expireTimeout: modelData?.expireTimeout >= 0
        ? modelData.expireTimeout
        : Config.notifications.defaultExpireTimeout;
    readonly property string appIconPath: Quickshell.iconPath(root.modelData?.appIcon, true)

    width: Config.notifications.width
    height: Config.notifications.height

    color: Theme.colors.backgroundPrimary

    border.color: Theme.colors.outline
    border.width: 1

    radius: 12

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.dismiss()
    }

    // Icon (used if it has one)
    Component {
        id: realImage
        RoundedImage {
            width: row.height - 2 * Config.notifications.imageMargins
            height: row.height - 2 * Config.notifications.imageMargins
            image.fillMode: Image.PreserveAspectFit
            image.source: root.appIconPath
            radius: 8
        }
    }

    // Svg Icon (used if there is no image)
    Component {
        id: fallbackIcon
        LucideIcon {
            source: "bell-ring"
            size: row.height - 2 * Config.notifications.imageMargins
            color: Theme.colors.textPrimary
        }
    }

    // Notification
    Row {
        id: row

        width: parent.width
        height: parent.height

        padding: Config.notifications.imageMargins
        spacing: Config.notifications.imageMargins

        // Image
        Loader {
            id: iconLoader
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: root.appIconPath !== ""
                ? realImage
                : fallbackIcon;
        }

        // Notification contents
        Column {
            anchors.verticalCenter: parent.verticalCenter

            width: root.width - iconLoader.width - Config.notifications.imageMargins * 3

            /* ---- Title ---- */
            Text {
                width: parent.width

                text: root.modelData?.summary ?? ""

                font.family: Theme.fonts.sans
                font.pixelSize: Theme.fontSize.normal
                font.bold: true

                color: Theme.colors.textPrimary

                elide: Text.ElideRight
            }

            /* ---- Body ---- */
            Text {
                visible: text !== ""

                width: parent.width

                text: root.modelData?.body ?? ""

                font.family: Theme.fonts.sans
                font.pixelSize: Theme.fontSize.small

                color: Theme.colors.textPrimary

                maximumLineCount: 2
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                elide: Text.ElideRight
            }
        }
    }

    Timer {
        interval: root.expireTimeout
        running: true
        onTriggered: root.expire()
    }

    NumberAnimation {
        id: slideOutExpire
        target: root
        property: "x"
        from: 0
        to: root.width
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
        to: root.width
        duration: 150
        easing.type: Easing.InCubic
        onStopped: root.modelData.dismiss()
        running: false
    }

    function expire() { slideOutExpire.start(); }
    function dismiss() { slideOutDismiss.start(); }
}
