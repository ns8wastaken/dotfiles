import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Theme

Rectangle {
    id: root

    required property DesktopEntry modelData
    required property bool isSelected

    readonly property int margins: 4

    color: isSelected ? Theme.colors.highlight : Theme.colors.backgroundSecondary

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

            color: Theme.colors.backgroundSecondary

            visible: itemIcon.isLoaded

            Image {
                id: itemIcon

                readonly property bool isLoaded: status === Image.Ready

                anchors.centerIn: parent

                width: parent.height - 8
                height: parent.height - 8

                source: Quickshell.iconPath(root.modelData.icon, true)

                mipmap: true
                antialiasing: true
            }
        }

        // App name
        Text {
            Layout.fillWidth: true

            text: root.modelData.name

            font.family: Theme.fonts.sans
            font.pixelSize: Theme.fontSize.small

            color: root.isSelected
                ? Theme.colors.textPrimaryInverted
                : Theme.colors.textPrimary;

            elide: Text.ElideRight
        }
    }
}
