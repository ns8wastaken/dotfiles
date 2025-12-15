import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Theme

Rectangle {
    id: root

    required property var modelData
    required property bool isSelected

    readonly property int margins: 4

    color: isSelected ? Theme.highlight.darker(1.1) : Theme.backgroundSecondary

    RowLayout {
        id: entryRow

        anchors.fill: parent
        anchors.centerIn: parent

        anchors {
            leftMargin: root.margins
            rightMargin: root.margins
        }

        spacing: root.margins

        // Icon
        Rectangle {
            implicitWidth: parent.height - 2 * root.margins
            implicitHeight: parent.height - 2 * root.margins

            radius: 8

            color: Theme.backgroundSecondary

            visible: itemIcon.isLoaded

            Image {
                id: itemIcon

                readonly property bool isLoaded: status == Image.Ready

                anchors.centerIn: parent

                width: parent.height - 8
                height: parent.height - 8

                source: Quickshell.iconPath(root.modelData.icon, true)

                mipmap: true
                antialiasing: true
                smooth: true
            }
        }

        // App name
        Text {
            Layout.fillWidth: true

            text: root.modelData.name

            font.family: Config.fonts.sans
            font.pixelSize: Config.fontSizeSmall

            color: root.isSelected
                ? Theme.textPrimaryInverted
                : Theme.textPrimary;

            elide: Text.ElideRight
        }
    }
}
